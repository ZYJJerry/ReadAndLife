//
//  AppDelegate.m
//  ReadAndLife
//
//  Created by Jerry on 16/3/1.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomTabBarController.h"
#import "HomeViewController.h"
#import "LocationManager.h"
#import "UMSocial.h"
#import "MeViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //设置友盟appkey
    [UMSocialData setAppKey:@"56d97be2e0f55a85dd002750"];
    
    [UMSocialWechatHandler setWXAppId:@"wx61087224609f7c18" appSecret:@"4b0cf54fc67304f6fc5d371fac49abfd" url:@"http://www.umeng.com/social"];
    
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1221243744" secret:@"    06c20cc7edf6459fb295560c0f7a65bc"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
//获取用户位置信息
//    [LocationManager shareSingleton];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.mainVC = [HomeViewController shareSingleton];
    MeViewController * left = [[MeViewController alloc]init];
    CustomTabBarController * cvc = [[CustomTabBarController alloc]init];
    self.mainVC.left = left;
    self.mainVC.mid = cvc;
    self.navigationController = [[UINavigationController alloc]initWithRootViewController:self.mainVC];
    self.navigationController.navigationBarHidden = YES;
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
