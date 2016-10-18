//
//  MusicDetailViewController.m
//  ReadAndLife
//
//  Created by Jerry on 16/3/2.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "MusicDetailViewController.h"
#import "HelperDefine.h"
#import "MusicDetailModel.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "ListenMusicTableViewCell.h"
@interface MusicDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong)NSArray * dataSource;
@property (weak, nonatomic) IBOutlet UITableView *MusicTableView;
@property (nonatomic,strong)MusicDetailModel * model;

@end

@implementation MusicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.MusicTableView registerNib:[UINib nibWithNibName:@"ListenMusicTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self createSwipeGesture];
    self.MusicTableView.showsHorizontalScrollIndicator = NO;
}



- (IBAction)backButton:(id)sender {
    [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (instancetype)initWithArray:(NSArray *)dataArray
{
    self = [super init];
    if (self) {
        self.dataSource = [NSArray arrayWithArray:dataArray];
    }
//    //NSLog(@"%ld",self.dataSource.count);
    return self;
}
- (void)createSwipeGesture{
    UISwipeGestureRecognizer * swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureAction)];
    //设置滑动方向
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.MusicTableView addGestureRecognizer:swip];
}

- (void)swipeGestureAction{
    [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:NULL];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListenMusicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    MusicDetailModel * model = self.dataSource[indexPath.row];
    [cell setCellWithData:model];
    self.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MusicDetailModel * model = self.dataSource[indexPath.row];

    [self.delagate playerPlay:[NSURL URLWithString:model.music_id]];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
