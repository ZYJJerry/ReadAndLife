//
//  PictureViewController.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "PictureViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "PictureModel.h"
#import "HelperDefine.h"
#import "PictureCollectionViewCell.h"
#import "DetailPictureViewController.h"
#define URL @"http://paper-cdn.2q10.com/api/list/today/zh-hans"

@interface PictureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    int _lastPosition;
}
@property (nonatomic,strong)NSArray * dataSource;

@property (nonatomic,strong)UICollectionView * collectionView;


@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"看见";
    [self getNetData];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)initData{

    self.dataSource = [[NSArray alloc]init];
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)createView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.itemSize = CGSizeMake(ScreenWidth/5, 30);
    layout.minimumInteritemSpacing = 0.5;
    layout.minimumLineSpacing = 0.5;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) collectionViewLayout:layout];
    self.collectionView.dataSource =self;
    self.collectionView.delegate =self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"PictureCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PictureCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    PictureModel * model = self.dataSource[indexPath.row];
    [cell setCellImageWithModel:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(ScreenWidth/3-3, (ScreenWidth/3-3)*(ScreenHeight/ScreenWidth));
    return size;
}



- (void)getNetData{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataSource = [PictureModel getModelWithData:responseObject];
        //NSLog(@"%ld",self.dataSource.count);
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@",error);
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PictureModel * model = self.dataSource[indexPath.row];
    DetailPictureViewController * pvc = [[DetailPictureViewController alloc]initWithModel:model];
    [self.view.window.rootViewController presentViewController:pvc animated:YES completion:nil];
}
//判断向上还是向下滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - _lastPosition > 25) {
        _lastPosition = currentPostion;
        self.tabBarController.tabBar.hidden = YES;
        //        //NSLog(@"ScrollUp now");
    }
    else if (_lastPosition - currentPostion > 25)
    {
        self.tabBarController.tabBar.hidden = NO;
        _lastPosition = currentPostion;
        //        //NSLog(@"ScrollDown now");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
