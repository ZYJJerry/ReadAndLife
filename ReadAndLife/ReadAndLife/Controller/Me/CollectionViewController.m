//
//  CollectionViewController.m
//  ReadAndLife
//
//  Created by Jerry on 16/3/3.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "CollectionViewController.h"
#import "DataBaseManager.h"
#import "ArticleDetailModel.h"
#import "ArticleTableViewCell.h"
#import "DetailArticleViewController.h"
#import "CollectionTableViewCell.h"
#import "Factory.h"
@interface CollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *collectionTableView;

@property (nonatomic,strong)NSMutableArray * dataSource;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createGesture];
    [self.collectionTableView registerNib:[UINib nibWithNibName:@"CollectionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.collectionTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    UIImageView * image = [[UIImageView alloc]initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"bg" ];
    self.collectionTableView.backgroundView = image;
    self.collectionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self createRightNavigationBarButtonWithTitle:@"edit" target:self action:@selector(changeEditStyle)];
}

- (void)createGesture{
    UISwipeGestureRecognizer * swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureAction)];
    //设置滑动方向
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.collectionTableView addGestureRecognizer:swip];
}

- (void)swipeGestureAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createRightNavigationBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)selector {
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:target action:selector];
    self.navigationItem.rightBarButtonItem = right;
}

- (IBAction)editMyCollection:(id)sender {
    self.collectionTableView.editing = !self.collectionTableView.editing;
}

- (void)initData{
    
    DataBaseManager * manager = [DataBaseManager shareSingleton];
    self.dataSource = [NSMutableArray arrayWithArray:[manager searchData:nil]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ArticleDetailModel * model = self.dataSource[indexPath.row];
    [cell setCellContent:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

        return 80;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleDetailModel * subModel = self.dataSource[indexPath.row];
    DetailArticleViewController * dvc = [[DetailArticleViewController alloc]initWithData:subModel.unid];
//    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dvc animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    DataBaseManager * manager = [DataBaseManager shareSingleton];
    ArticleDetailModel * subModel = self.dataSource[indexPath.row];
    [manager deleteData:subModel];
    [self.dataSource removeObject:subModel];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
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
