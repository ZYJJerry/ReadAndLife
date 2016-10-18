//
//  BaseViewController.h
//  UINavigationControllerDemo2
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import <UIKit/UIKit.h>

//BaseViewController作为所有UI阶段视图控制器的父类。
/*
 由于我们后续生成的视图控制器都继承与Base，而Base继承与UIViewController所以我们生成的视图控制器，都是UIViewController的子类。
 */
@interface BaseViewController : UIViewController

//声明一个初始化数据的方法
- (void)initData;

//声明一个创建视图的方法
- (void)createView;

//添加用户交互信息
- (void)addTouchAction;

//创建上导航的右侧按钮
- (void)createRightNavigationBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)selector;

//创建上导航的左侧按钮
- (void)createLeftNavigationBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)selector;

@end








