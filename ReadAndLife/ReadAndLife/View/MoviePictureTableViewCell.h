//
//  MoviePictureTableViewCell.h
//  ReadAndLife
//
//  Created by Jerry on 16/3/2.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviePictureTableViewCell : UITableViewCell<UIScrollViewDelegate>
{
    NSTimer * _timer;
    CGFloat a;
}
@property (weak, nonatomic) IBOutlet UIScrollView *showMovie;
@property (nonatomic,strong)UIPageControl * pageControl;
@property (nonatomic,strong)NSMutableArray * mulArray;


- (void)setCellContentWithArray:(NSArray *)array;

@end
