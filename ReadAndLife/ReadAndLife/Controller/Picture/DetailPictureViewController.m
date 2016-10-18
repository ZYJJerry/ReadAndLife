//
//  DetailPictureViewController.m
//  ReadAndLife
//
//  Created by Jerry on 16/3/2.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "DetailPictureViewController.h"
#import "UIImageView+AFNetworking.h"
#import "HelperDefine.h"
//static BOOL MyHidden = NO;
@interface DetailPictureViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *picDetail;
@property (strong, nonatomic)  UILabel *descTitle;
@property (strong, nonatomic)  UITextView *content;
@property (strong, nonatomic)  UIButton *saveButton;
@property (strong, nonatomic)  UIView *descView;
@property (nonatomic,strong)PictureModel * model;

@end

@implementation DetailPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self createView];
    [self createTapGesture];
}

- (void)createView{
    [self.picDetail setImageWithURL:[NSURL URLWithString:self.model.cover]];
    self.picDetail.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);

    self.descView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight/6*5, ScreenWidth, ScreenHeight/6)];
    self.descView.backgroundColor = BlackColor;
    
    
    self.descTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, ScreenWidth/4*3, 15)];
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveButton.frame = CGRectMake(ScreenWidth-50, 0, 40, 40);
    self.content = [[UITextView alloc]initWithFrame:CGRectMake(10, 20, ScreenWidth/4*3, ScreenHeight/6-30)];
    [self.descView addSubview:self.descTitle];
    [self.descView addSubview:self.saveButton];
    [self.descView addSubview:self.content];
    [self.picDetail addSubview:self.descView];
    
    self.descTitle.font = [UIFont systemFontOfSize:14];
    
    self.descTitle.text = self.model.title;
    self.content.text = self.model.content;
    
    self.content.backgroundColor = BlackColor;
    self.descTitle.textColor = WhiteColor;
    self.content.textColor = WhiteColor;
    
    self.descView.alpha = 0.5;
    [self.saveButton setImage:[UIImage imageNamed:@"DownLoad"] forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(savePicture) forControlEvents:UIControlEventTouchUpInside];
    
    self.picDetail.userInteractionEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (instancetype)initWithModel:(PictureModel *)model{
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)savePicture{
    UIImageWriteToSavedPhotosAlbum(self.picDetail.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    
    NSString *message = @"呵呵";
    if (!error) {
        message = @"成功保存到相册";
    }else
    {
        message = [error description];
    }
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark - gesture

- (void)createTapGesture{
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    
    [self.picDetail addGestureRecognizer:tapGesture];
}

- (void)tapGesture:(UITapGestureRecognizer *)gesture{
    [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:NULL];

}

//允许响应多个手势
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
