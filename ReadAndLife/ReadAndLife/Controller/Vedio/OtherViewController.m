//
//  OtherViewController.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "OtherViewController.h"
#import "HelperDefine.h"
#import "AFNetworking.h"
#import "MovieModel.h"
#import "MovieContentTableViewCell.h"
#import "MoviePictureTableViewCell.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#define URL1 @"http://baobab.wandoujia.com/api/v1/feed?num=1&date="
#define URL2 @"&vc=125&u=39912febcd7affda38b6e528e76697152729ac02&v=1.8.1&f=iphone"
@interface OtherViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    int _lastPosition;
}
@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)NSArray * dataSource;

@property (nonatomic,strong)NSString * toDay;

//视频播放视图控制器
@property (nonatomic,strong)AVPlayerViewController * av;

@property (nonatomic,strong)MovieModel * movieModel;

//@property (nonatomic,strong)UIAlertView * isNotWiFi;

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNetData];
//    self.navigationController.navigationBar.hidden =YES;
    UIImageView * image = [[UIImageView alloc]initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"bg"];
    self.tableView.backgroundView = image;
}

- (void)initData{
    self.dataSource = [[NSArray alloc]init];
    self.toDay = [self getToDayDate];
    self.av = [[AVPlayerViewController alloc]init];
}

- (NSString *)getToDayDate{
    NSDateFormatter * formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = @"yyyyMMdd";
    NSDate * date = [NSDate date];
    NSString * dateString = [formater stringFromDate:date];
    //NSLog(@"%@",dateString);
    return dateString;
}

- (void)getNetData{
    
    //http://baobab.wandoujia.com/api/v1/feed?num=1&date=20160302&vc=125&u=39912febcd7affda38b6e528e76697152729ac02&v=1.8.1&f=iphone
    NSString * path = [NSString stringWithFormat:@"%@%@%@",URL1,self.toDay,URL2];
    //NSLog(@"%@",path);
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataSource = [MovieModel getDataWithDictionary:responseObject];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)createView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"qqq%ld",self.dataSource.count);
//    if (indexPath.row != 0) {
        MovieContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"movieContent"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MovieContentTableViewCell" owner:self options:nil]lastObject];
            MovieModel * model = self.dataSource[indexPath.row];
            [cell setData:model];
        }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieModel * model = self.dataSource[indexPath.row];
    self.movieModel = model;
    [self netMonitor];

}
- (void)netMonitor{
    UIAlertView * alertNoNet = [[UIAlertView alloc]initWithTitle:nil message:@"无网络连接" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    UIAlertView * unkonwnNet = [[UIAlertView alloc]initWithTitle:nil message:@"未知的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    UIAlertView * isNotWiFi = [[UIAlertView alloc]initWithTitle:nil message:@"正在使用运营商网络" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"继续观看", nil];
    isNotWiFi.tag = 1000;
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 连接状态回调处理
    /* AFNetworking的Block内使用self须改为weakSelf, 避免循环强引用, 无法释放 */
    //    __weak typeof(self) weakSelf = self;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         switch (status)
         {
             case AFNetworkReachabilityStatusUnknown:
                 [unkonwnNet show];
                 break;
             case AFNetworkReachabilityStatusNotReachable:
                 
                 [alertNoNet show];
                 break;
             case AFNetworkReachabilityStatusReachableViaWWAN:
                 // 回调处理
                 [isNotWiFi show];
                 break;
             case AFNetworkReachabilityStatusReachableViaWiFi:{
                 self.av.player = [AVPlayer playerWithURL:[NSURL URLWithString:self.movieModel.playUrl]];
                 [self.view.window.rootViewController presentViewController:self.av animated:YES completion:nil];
             }
                 break;
             default:
                 break;
         }
     }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1000) {
        if (buttonIndex == 1) {
            self.av.player = [AVPlayer playerWithURL:[NSURL URLWithString:self.movieModel.playUrl]];
            [self.view.window.rootViewController presentViewController:self.av animated:YES completion:nil];
        }      
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        return ScreenWidth;
//    }else
    return ScreenWidth;
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
//     Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
