//
//  PicForArticleTableViewCell.h
//  MyRealityLife
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
@interface PicForArticleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *MyImageView;

- (void)setImageWithData:(ArticleModel *)model;

@end
