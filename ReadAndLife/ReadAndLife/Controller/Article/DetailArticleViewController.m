//
//  DetailArticleViewController.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "DetailArticleViewController.h"
#import "AFNetworking.h"
#import "DetailArticleModel.h"
#import "UMSocial.h"
@interface DetailArticleViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (nonatomic,copy)NSString * uid;
//@property (nonatomic)DetailArticleModel * model;
@end

@implementation DetailArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.tabBarController.tabBar.hidden = NO;
    self.myWebView.userInteractionEnabled = YES;
    [self createRightNavigationBarButtonWithTitle:@"分享" target:self action:@selector(shareMyArticle)];
}

- (void)createRightNavigationBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)selector {
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:target action:selector];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)shareMyArticle{

    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:[NSString stringWithFormat:@"http://v4.api.maichong.me/article/article-detail/%@",self.uid]
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToEmail,UMShareToSms,UMShareToRenren,UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:nil];
}

- (void)createGesture{
    UISwipeGestureRecognizer * swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureAction:)];
    //设置滑动方向
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.myWebView addGestureRecognizer:swip];
}

- (void)swipeGestureAction:(UISwipeGestureRecognizer *)gesture{

    [self.navigationController popViewControllerAnimated:YES];
}

- (instancetype)initWithData:(NSString *)string
{
    self = [super init];
    if (self) {
        self.uid = [string copy];
    }
    return self;
}

- (void)initData{
    [self getNetData];
    [self createGesture];
}


- (void)loadWebView{

}
- (void)getNetData{
    NSString * urlString = [NSString stringWithFormat:@"http://v4.api.maichong.me/article/article-detail/%@",self.uid];
    NSURLRequest * request =[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
    //NSLog(@"%@",urlString);
    [self.myWebView loadRequest:request];
    int fontSize = 60;		//设置字体大小
    NSString *str = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'", fontSize];
    //将对应的JS语句添加到webView中
    [self.myWebView stringByEvaluatingJavaScriptFromString:str];
    
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    self.navigationController.navigationBar.hidden = !self.navigationController.navigationBar.hidden;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//是否允许多个手势被响应
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
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
