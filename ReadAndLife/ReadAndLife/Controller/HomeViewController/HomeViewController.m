//
//  HomeViewController.m
//  MyRealityLife
//
//  Created by Jerry on 16/3/1.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "HomeViewController.h"
#import "UIView+Addition.h"
#import "HelperDefine.h"
#import "CustomTabBarController.h"
static HomeViewController * home = nil;
@interface HomeViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong)UIView * maskView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addChildViewController:self.midViewController];
    [self.view addSubview:self.mid.view];
}

- (void)createView {
    [self createMaskView];
}
- (void)createMaskView{
    self.maskView = [[UIView alloc]initWithFrame:self.view.bounds];
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reviseMidView)];
    [self.maskView addGestureRecognizer:gesture];
    UISwipeGestureRecognizer * swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(reviseMidView)];
    swip.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.maskView addGestureRecognizer:swip];
}

- (void)reviseMidView{
    [UIView animateWithDuration:0.5 animations:^{
        self.mid.view.transform = CGAffineTransformMakeScale(1, 1);
        [self.mid.view setXOffset:0];
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.left.view removeFromSuperview];
    }];
}

+ (id)shareSingleton{
    @synchronized(home) {
        if (!home) {
            home = [[HomeViewController alloc] init];
        }
    }
    return home;
}

+ (void)showLeftViewController{
    [home showLeftViewController];
}

- (void)showLeftViewController{
    [self.view insertSubview:self.left.view belowSubview:self.mid.view];
    if (!self.maskView.superview) {
        [self.mid.view addSubview:self.maskView];
    }
    [UIView animateWithDuration:0.8 animations:^{
        self.mid.view.transform = CGAffineTransformScale(self.mid.view.transform, 0.9, 0.9);
        [self.mid.view setXOffset:ScreenWidth-100];
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
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
