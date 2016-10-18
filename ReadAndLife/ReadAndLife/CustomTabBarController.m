//
//  CustomTabBarController.m
//  ReadAndLife
//
//  Created by Jerry on 16/3/1.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "CustomTabBarController.h"
#import "ArticleViewController.h"
#import "PictureViewController.h"
#import "MusicViewController.h"
#import "OtherViewController.h"
#import "Factory.h"
#import "HelperDefine.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers = [self createViewControllers];
    self.tabBar.backgroundImage = [UIImage imageNamed:@"bg-tab"];
    [self createButton];
}

- (NSArray *)createViewControllers{
    NSArray * class = @[@"ArticleViewController",@"MusicViewController",@"OtherViewController",@"PictureViewController"];
    NSMutableArray * temp = [[NSMutableArray alloc]init];
    for (int i = 0; i < class.count; i++) {
        Class cls = NSClassFromString(class [i]);
        UIViewController * controller = [[cls alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:controller];
        [temp addObject:nav];
    }
    return temp;
}

- (void)createButton{
    NSArray * titles = @[@"文字",@"音阅",@"看见",@"图志"];
    NSArray * picNames = @[@"big4@2x.png",@"big3@2x.png",@"big2@2x.png",@"big1@2x.png"];
    for (int i =0; i < self.viewControllers.count; i++) {
        //设置按钮的宽度
        CGFloat width = ScreenWidth/4.f;
        UIImage *image = [UIImage imageNamed:picNames[i]];
        UIButton * button = [Factory createButtonWithTitle:[titles objectAtIndex:i] frame:CGRectMake(i*width, 0, width, 48) backgroundColor:nil image:image backgroundImage:nil target:self action:@selector(buttonDidClicked:)];      //设置按钮选中状态图片
        if (i==0) {
            button.selected = YES;
        }
        [button setImage:[UIImage imageNamed:picNames[i]] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        
        //设置tag，用来在回调方法中区分按钮的身份
        button.tag = 100+i;
//        [self changeImageLocAndTitleLoc:button];
        [self.tabBar addSubview:button];
        
    }
}
- (void)buttonDidClicked:(UIButton *)button{

    //self.selectedIndex+100就是选中的按钮tag值
    UIButton * btn= (UIButton *)[self.tabBar viewWithTag:self.selectedIndex+100];
    //旧的按钮取消选中状态
    btn.selected = NO;
    //新的按钮的状态设置为选中
    button.selected = YES;
    //因为每个tag值都关联一个视图控制器，所以就用tag值来计算selectedIndex用来帮助切换视图。
    self.selectedIndex = button.tag-100;
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
