//
//  LeftViewController.m
//  ReadAndLife
//
//  Created by Jerry on 16/3/1.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "MeViewController.h"
#import "AppDelegate.h"
#import "HelperDefine.h"
#import "LocationManager.h"
#import "CollectionViewController.h"
#import "LeftViewControllerTableViewCell.h"
#import "LoginTableViewCell.h"
#import "HomeViewController.h"
#import "UIView+Addition.h"
#import "CacheManager.h"
#import "AboutUsViewController.h"
@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableView;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
- (void)createView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
    UIImageView * image = [[UIImageView alloc]initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"bg" ];
    self.tableView.backgroundView = image;
    self.tableView.scrollEnabled = NO;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        LoginTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"login"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LoginTableViewCell" owner:self options:nil]lastObject];
        }
        cell.userIcon.image = [UIImage imageNamed:@"head"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        LeftViewControllerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"First"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LeftViewControllerTableViewCell" owner:self options:nil]lastObject];
        }
        cell.title.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
        if (indexPath.row == 1) {
            cell.title.text = @"收藏";
            cell.image.image = [UIImage imageNamed:@"likehl"];
        } if (indexPath.row == 2){
            cell.title.text = @"清除缓存";
            cell.image.image = [UIImage imageNamed:@"clean"];
        }  if(indexPath.row == 3){
            cell.title.text = @"关于我们";
            cell.image.image = [UIImage imageNamed:@"about"];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return ScreenWidth/4*3;
    }else{
        return 60;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        CollectionViewController * clvc = [[CollectionViewController alloc]init];
        AppDelegate  *delega = [UIApplication sharedApplication].delegate;

        [delega.navigationController pushViewController:clvc animated:YES];
        
    }
    if (indexPath.row == 2) {
        CacheManager * manager = [CacheManager manager];
        [manager clearDisk];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"清除缓存成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    if (indexPath.row == 3) {
        AboutUsViewController * avc = [[AboutUsViewController alloc]init];
        AppDelegate  *delega = [UIApplication sharedApplication].delegate;
        [delega.navigationController pushViewController:avc animated:YES];
    }
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
