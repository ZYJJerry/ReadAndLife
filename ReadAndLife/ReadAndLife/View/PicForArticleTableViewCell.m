//
//  PicForArticleTableViewCell.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "PicForArticleTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "HelperDefine.h"
@implementation PicForArticleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setImageWithData:(ArticleModel *)model{
    [self.MyImageView setImageWithURL:[NSURL URLWithString:model.image]];
//    self.backgroundColor = RGB(255, 255, 191);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
