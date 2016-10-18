//
//  ArticleViewController.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "ArticleViewController.h"
#import "AFNetworking.h"
#import "ArticleModel.h"
#import "ArticleTableViewCell.h"
#import "PicForArticleTableViewCell.h"
#import "ArticleDetailModel.h"
#import "JHRefresh.h"
#import "DetailArticleViewController.h"
#import "HomeViewController.h"
#import "LocationManager.h"
#import "HelperDefine.h"
#define URL @"http://v4.api.maichong.me/subject/recommend"
@interface ArticleViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int _lastPosition;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * modelDataSource;
@property (nonatomic,strong)NSMutableArray * dataSource;
@property (nonatomic,assign)NSInteger page;
@end

@implementation ArticleViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self netMonitor];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)createView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , ScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"articleCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PicForArticleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"picForArticle"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIImageView * image = [[UIImageView alloc]initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"bg" ];
    self.tableView.backgroundView = image;
    [self.view addSubview:self.tableView];
    //    [self createLeftNavigationBarButtonWithTitle:@"edit" target:self action:@selector(editController)];
    [self addRefesh];
}

//- (void)editController{
//    [HomeViewController showLeftViewController];
//    
//}

- (void)addRefesh{
    __weak typeof(self) weakSelf = self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.page = 1;
        [weakSelf getNetData];
        
    }];
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.page ++;
        [weakSelf getNetData];
    }];
}

- (void)initData{
    self.modelDataSource = [[NSMutableArray alloc]init];
    self.dataSource = [[NSMutableArray alloc]init];
    self.page = 1;
    [self getNetData];
}

- (void)netMonitor{
    UIAlertView * alertNoNet = [[UIAlertView alloc]initWithTitle:nil message:@"无网络连接" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    UIAlertView * IsNotWiFi = [[UIAlertView alloc]initWithTitle:nil message:@"正在使用运营商网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
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
                 // 回调处理
                 break;
             case AFNetworkReachabilityStatusNotReachable:
                 
                 [alertNoNet show];
                 break;
             case AFNetworkReachabilityStatusReachableViaWWAN:
                 // 回调处理
                 break;
             case AFNetworkReachabilityStatusReachableViaWiFi:
                 // 回调处理
                 break;
             default:
                 break;
         }
     }];
}


- (void)getNetData{
//    __weak typeof(self) weakself = self;
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSString * PATH = [URL stringByAppendingFormat:@"/%@/%ld",@"1",self.page];
    [manager GET:PATH parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        //NSLog(@"%@",responseObject);
        [self.modelDataSource setArray:[ArticleModel getDataWithDictionary:responseObject]];
        ArticleModel * model = [self.modelDataSource lastObject];
        //        //NSLog(@"vvvvvvvvv%ld",self.modelDataSource.count);
        [self.dataSource setArray:[ArticleDetailModel getDataFromArray:model.items]];
        //        //NSLog(@"wwwwwwwwwwwwww%ld",self.dataSource.count);
        [self.tableView footerEndRefreshing];
        //结束下拉刷新
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    //NSLog(@"section %ld row的个数:%ld",section,self.dataSource.count);
    return self.dataSource.count-1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.modelDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleModel * model = self.modelDataSource[indexPath.section];
    if (indexPath.row == 0) {
        PicForArticleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"picForArticle"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PicForArticleTableViewCell" owner:self options:nil]lastObject];
            //            //NSLog(@"%@",model);
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setImageWithData:model];
        
        return cell;
    }else{
        self.dataSource = [ArticleDetailModel getDataFromArray:model.items];
        ArticleDetailModel * subModel = self.dataSource[indexPath.row-1];
        ArticleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"articleCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ArticleTableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellDataWith:subModel];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return self.view.frame.size.width+10;
        //        return 500;
    }else{
        return 320;
    }
}

//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    //NSLog(@"%ld",indexPath.row);
    if (indexPath.row != 0) {
        ArticleDetailModel * subModel = self.dataSource[indexPath.row-1];
        DetailArticleViewController * dvc = [[DetailArticleViewController alloc]initWithData:subModel.unid];
        self.tabBarController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:dvc animated:YES];
        CATransition *transition = [CATransition animation];
        transition.duration = 1;
        transition.delegate = self;
        transition.type = @"rippleEffect";
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置cell的显示动画为3D缩放
    
//    xy方向缩放的初始值为0.1
    
    cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
    
    //设置动画时间为0.25秒,xy方向缩放的最终值为1
    
    [UIView animateWithDuration:0.4 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
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

//在收藏界面取消收藏时重新加载视图，将已收藏变为未收藏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
