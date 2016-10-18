//
//  ArticleTableViewCell.h
//  MyRealityLife
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
#import "ArticleDetailModel.h"
@interface ArticleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *collection;

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@property (nonatomic,strong)ArticleDetailModel * model;
- (void)setCellDataWith:(ArticleDetailModel *)model;

@end
