//
//  HomeViewController.h
//  MyRealityLife
//
//  Created by Jerry on 16/3/1.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController

@property (nonatomic,strong)UIViewController * left;

@property (nonatomic,strong)UIViewController * mid;

+ (void)showLeftViewController;

+ (id)shareSingleton;

@end
