//
//  AboutUsViewController.m
//  ReadAndLife
//
//  Created by Jerry on 16/3/8.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "AboutUsViewController.h"
#import "DBSphereView.h"
#import "HelperDefine.h"
#import "UIView+Addition.h"
@interface AboutUsViewController ()

@property (nonatomic, retain) DBSphereView *sphereView;

@property (nonatomic,strong)UILabel * myLabel;
@property (nonatomic,strong)NSMutableArray * wordArray;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createGesture];
    self.view.backgroundColor = [UIColor whiteColor];
    self.sphereView = [[DBSphereView alloc] initWithFrame:CGRectMake(100, 50, ScreenWidth-200, ScreenWidth-200)];
    self.sphereView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2-150);
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i < 50; i ++) {
        UILabel * label = [[UILabel alloc]init];
        label.text = @"❀";
        NSInteger a=arc4random()%255;
        NSInteger b=arc4random()%255;
        NSInteger c=arc4random()%255;
        label.textColor = [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1];
        label.font = [UIFont fontWithName:@"Futura-Medium" size:20];
        label.textAlignment = 1;
        label.frame = CGRectMake(0, 0, 60, 20);
        [array addObject:label];
        [self.sphereView addSubview:label];
    }
    [self.sphereView setCloudTags:array];
    self.sphereView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.sphereView];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, self.sphereView.bottom, ScreenWidth-20, ScreenWidth/2)];
    label.text = @"身体和灵魂至少有一个在旅行，这样生活才充满惊喜\n\n author：伪文艺的Jerry\n\nidea：目光在远方的人\n\n2016 ZYJ ~";
    label.textColor = [UIColor blackColor];
    label.textAlignment = 1;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    self.myLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, label.bottom, ScreenWidth-20, ScreenHeight-label.bottom)];
    self.myLabel.numberOfLines = 0;
    self.myLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.myLabel];
    
}
- (void)createGesture{
    UISwipeGestureRecognizer * swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureAction)];
    //设置滑动方向
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swip];
}

- (void)swipeGestureAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
