//
//  MusicViewController.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "MusicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "HelperDefine.h"
#import "Factory.h"
#import "AFNetworking.h"
#import "MusicModel.h"
#import "MusicDetailModel.h"
#import "MusicDetailTableViewCell.h"
#import "UIView+Addition.h"
#import "UIButton+AFNetworking.h"
#import "CacheManager.h"
#import "MusicDetailViewController.h"
#define listURL @"http://v3.wufazhuce.com:8000/api/music/idlist/0"
#define detailUrl @"http://v3.wufazhuce.com:8000/api/music/detail/"
@interface MusicViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,playSongDelegate>
{
    CGRect  _frame ;
    int _lastPosition;
}
@property (nonatomic,strong)UIScrollView * myScrollView;

@property (nonatomic,strong)NSArray * dataSource;

@property (nonatomic,strong)NSMutableArray * modelDataSource;

@property (nonatomic,strong)UITableView * firstTableView;

@property (nonatomic,strong)UITableView * secondTableView;

@property (nonatomic,strong)UITableView * thirdTableView;

@property (nonatomic,strong)NSMutableArray * musicDataSource;

@property(nonatomic,strong)MusicDetailModel * model;

@property (nonatomic, assign)NSInteger NetPage;

@property (nonatomic,strong)AVPlayerViewController * avPlayer;

@property (nonatomic,strong)NSData * netData;

@property (nonatomic,strong)AVAudioPlayer * player;

@property (nonatomic,strong)id MyResponseObject;

@property (nonatomic,strong)NSFileHandle * fileHandle;

@property (nonatomic,strong)NSURLConnection * connection;


@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self createViews];
    [self getNetData];
    self.tabBarItem.image = [UIImage imageNamed:@"big3"];
}

- (void)userQueue{
    
    for (MusicDetailModel * model in self.modelDataSource) {
        NSString * musicId = model.music_id;
        if (![musicId integerValue]) {
            [self.musicDataSource addObject:model];
            self.model = model;
        }
    }
}

- (void)initData{
    self.modelDataSource = [[NSMutableArray alloc]init];
    self.musicDataSource = [[NSMutableArray alloc]init];
    self.avPlayer = [[AVPlayerViewController alloc]init];
    self.NetPage = 0;
}

- (void)getNetData{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:listURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataSource = [MusicModel getDataFromDictionary:responseObject];
        
        for (int i = 0; i < self.dataSource.count; i++) {
            [self getDetailStory:self.dataSource[i]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@",error);
    }];
}

- (void)getDetailStory:(NSString *)string{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSString * url = [NSString stringWithFormat:@"%@%@",detailUrl,string];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MusicDetailModel * model = [MusicDetailModel getModelFromData:responseObject];
        [self.modelDataSource addObject:model];
        
        self.NetPage++;
        
        if (self.NetPage == self.dataSource.count) {
//            //NSLog(@"%ld----%ld可以开启线程",self.NetPage,self.modelDataSource.count);
            self.firstTableView.tag = 0;
            self.secondTableView.tag = 1;
            self.thirdTableView.tag = 2;
            [self.firstTableView reloadData];
            [self.secondTableView reloadData];
            [self.thirdTableView reloadData];
            [self userQueue];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@",error);
    }];
    
    
}

- (void)createViews{
    
    self.myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-49)];
    self.myScrollView.delegate = self;
    self.myScrollView.pagingEnabled = YES;
    [self.view addSubview:self.myScrollView];
    self.myScrollView.contentSize = CGSizeMake(self.myScrollView.width*3, 0);
    
    self.myScrollView.showsVerticalScrollIndicator = NO;
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    
    CGRect frame1 = CGRectMake(0, 0, self.myScrollView.width, self.myScrollView.frame.size.height);
    CGRect frame2 = CGRectMake(self.myScrollView.width, 0, self.myScrollView.width, self.myScrollView.frame.size.height);
    CGRect frame3 = CGRectMake(self.myScrollView.width*2, 0, self.myScrollView.width, self.myScrollView.frame.size.height);
    
    self.firstTableView = [[UITableView alloc]initWithFrame:frame1];
    self.firstTableView.delegate = self;
    self.firstTableView.dataSource = self;
    
    self.secondTableView = [[UITableView alloc]initWithFrame:frame2];
    self.secondTableView.delegate = self;
    self.secondTableView.dataSource = self;
    
    self.thirdTableView = [[UITableView alloc]initWithFrame:frame3];
    self.thirdTableView.delegate = self;
    self.thirdTableView.dataSource = self;
    
    [self.myScrollView addSubview:self.firstTableView];
    [self.myScrollView addSubview:self.secondTableView];
    [self.myScrollView addSubview:self.thirdTableView];
    
    self.firstTableView.showsVerticalScrollIndicator = NO;
    self.secondTableView.showsVerticalScrollIndicator = NO;
    self.thirdTableView.showsVerticalScrollIndicator = NO;
    
    self.firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.thirdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.firstTableView.estimatedRowHeight = 10000;
    self.secondTableView.estimatedRowHeight = 10000;
    self.thirdTableView.estimatedRowHeight = 10000;
    
    UIImageView * firstImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    firstImage.image = [UIImage imageNamed:@"bg"];
    UIImageView * secondImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    secondImage.image = [UIImage imageNamed:@"bg"];
    UIImageView * thirdImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    thirdImage.image = [UIImage imageNamed:@"bg"];
    self.firstTableView.backgroundView = firstImage;
    self.secondTableView.backgroundView = secondImage;
    self.thirdTableView.backgroundView = thirdImage;
}

- (void)showMusicView{
    MusicDetailViewController * mdv = [[MusicDetailViewController alloc]initWithArray:self.musicDataSource];
    mdv.delagate =self;
    [self.view.window.rootViewController presentViewController:mdv animated:YES completion:NULL];
}
//判断音乐是否播放来确定暂停还是开始
//- (void)playerBeginAndStop:(UIButton * )button{
//    if ([self.myAudioPlayer isPlaying]) {
//        [self.pauseImage removeFromSuperview];
//        [self.playerView addSubview:self.playImage];
//        [self.myAudioPlayer pause];
//    }else{
//        if ([self.myAudioPlayer prepareToPlay]) {
//            [self.playImage removeFromSuperview];
//            [self.playerView addSubview:self.pauseImage];
//            //NSLog(@"播放音乐");
//            [self.myAudioPlayer play];
//        }else{
//            [self.playImage removeFromSuperview];
//            [self.playerView addSubview:self.pauseImage];
//            [self.myAudioPlayer play];
//        }
//        
//    }
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelDataSource.count == 0 ? 0 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MusicDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    MusicDetailModel * model = self.modelDataSource[tableView.tag];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MusicDetailTableViewCell" owner:self options:nil]lastObject];
    }
    [cell.MusicShow addTarget:self action:@selector(showMusicView) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellContentWithData:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicDetailModel * model = self.modelDataSource[tableView.tag];
    CGRect appInfoSize = [model.story boundingRectWithSize:CGSizeMake(ScreenWidth-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} context:NULL];
    return appInfoSize.size.height + ScreenWidth + 120;

}



#pragma ScrollDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.myScrollView) {
        [self updateContent];
    }
    
//    self.tabBarController.tabBar.hidden = !self.tabBarController.tabBar.hidden;
}

- (void)updateContent
{
    //先考虑右滑
    if (self.myScrollView.contentOffset.x >= ScreenWidth * 2)
    {
        if (self.thirdTableView.tag == self.modelDataSource.count - 1) {
            return;
        }
        self.firstTableView.tag ++;
        self.secondTableView.tag ++;
        self.thirdTableView.tag ++;
    }
    if (self.myScrollView.contentOffset.x <= ScreenWidth * 0.5) {
        if (self.firstTableView.tag == 0) {
            return;
        }
        self.firstTableView.tag --;
        self.secondTableView.tag --;
        self.thirdTableView.tag --;
    }
    
    [self performSelectorOnMainThread:@selector(setTableViewContentOffset) withObject:nil waitUntilDone:NO];
    [self performSelectorOnMainThread:@selector(tableViewReloadDataFunc) withObject:nil waitUntilDone:YES];
}

- (void)setTableViewContentOffset {
    [self.thirdTableView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void)tableViewReloadDataFunc {
    [self.firstTableView reloadData];
    [self.secondTableView reloadData];
    [self.thirdTableView reloadData];
    [self.myScrollView setContentOffset:CGPointMake(self.myScrollView.width, 0)];
}


#pragma mark - playSongDelegate

- (void)playerPlay:(NSURL *)url{
    //NSLog(@"%@",url);
    //后台播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    self.avPlayer.player = [AVPlayer playerWithURL:url];
    [self.avPlayer.player play];
}

//判断向上还是向下滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - _lastPosition > 25) {
        _lastPosition = currentPostion;
        self.tabBarController.tabBar.hidden = YES;
//        //NSLog(@"ScrollUp now");
    }
    else if (_lastPosition - currentPostion > 25)
    {
        self.tabBarController.tabBar.hidden = NO;
        _lastPosition = currentPostion;
//        //NSLog(@"ScrollDown now");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
