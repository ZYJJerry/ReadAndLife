//
//  AppDelegate.h
//  ReadAndLife
//
//  Created by Jerry on 16/3/1.
//  Copyright © 2016年 周玉举. All rights reserved.
//56d97be2e0f55a85dd002750

#import <UIKit/UIKit.h>
@class HomeViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong)HomeViewController *mainVC;
@property (nonatomic,strong) UINavigationController *navigationController;

@end

