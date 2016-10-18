//
//  MoviePictureTableViewCell.m
//  ReadAndLife
//
//  Created by Jerry on 16/3/2.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "MoviePictureTableViewCell.h"
#import "MovieModel.h"
#import "HelperDefine.h"
#import "UIImageView+AFNetworking.h"
@implementation MoviePictureTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellContentWithArray:(NSArray *)array{
    //NSLog(@"执行");
    if (array.count != 0) {
        self.mulArray = [[NSMutableArray alloc]init];
        [self.mulArray addObjectsFromArray:array];
        [self.mulArray insertObject:[array lastObject] atIndex:0];
        [self.mulArray addObject:array[0]];
    }
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(ScreenWidth/2-40, ScreenWidth-40, 80, 40)];
    self.pageControl.numberOfPages = array.count;
    self.showMovie.pagingEnabled = YES;
    self.showMovie.delegate =self;
    self.showMovie.showsHorizontalScrollIndicator = NO;
    
        self.showMovie.contentSize = CGSizeMake(ScreenWidth * self.mulArray.count, 0);
    for (int i = 0; i < self.mulArray.count; i++) {
        MovieModel * model = self.mulArray[i];
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenWidth)];
        [image setImageWithURL:[NSURL URLWithString:model.coverForFeed]];
        [self.showMovie addSubview:image];
    }
     _timer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(pageAdd) userInfo:nil repeats:YES];
    [self.pageControl addTarget:self action:@selector(pageChange) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.pageControl];
    self.showMovie.contentOffset =CGPointMake(ScreenWidth, 0);
   
}

- (void)pageAdd{
    static NSInteger _num = 0;
    _num++;
    
}

- (void)pageChange{
    //NSLog(@"%ld",(long)self.pageControl.currentPage);
    [self.showMovie setContentOffset:CGPointMake(self.showMovie.frame.size.width * self.pageControl.currentPage, 0)];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.showMovie.contentOffset.x >= ScreenWidth*(self.mulArray.count-1)) {
        [self.showMovie setContentOffset: CGPointMake(self.showMovie.frame.size.width, 0)];
    }
    if (self.showMovie.contentOffset.x <= 0){
        [self.showMovie setContentOffset: CGPointMake(self.showMovie.frame.size.width*(self.mulArray.count-2), 0)];
    }
    NSInteger page = scrollView.contentOffset.x/scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
