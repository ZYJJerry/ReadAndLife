//
//  BaseViewController.m
//  UINavigationControllerDemo2
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "BaseViewController.h"
#import "HelperDefine.h"
#import "HomeViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    //初始化数据
    [self initData];
    //创建视图
    [self createView];
    //添加用户行为
    [self addTouchAction];
    [self createLeftNavigationBarButtonWithTitle:nil target:self action:@selector(editController)];
}

- (void)editController{
    [HomeViewController showLeftViewController];
    
}
//声明一个初始化数据的方法
- (void)initData {
    //只做空方法，不做实现，取消编译器的警告
}

//声明一个创建视图的方法
- (void)createView {
    //只做空方法，不做实现，取消编译器的警告
}

//添加用户交互信息
- (void)addTouchAction {
    //只做空方法，不做实现，取消编译器的警告
}

//声明一个创建上导航的右侧按钮
- (void)createRightNavigationBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)selector {
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:target action:selector];
    self.navigationItem.rightBarButtonItem = right;
}

//声明一个创建上导航的左侧按钮
- (void)createLeftNavigationBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)selector {
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:target action:selector];
    [left setImage:[UIImage imageNamed:@"head"]];
    self.navigationItem.leftBarButtonItem = left;
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
