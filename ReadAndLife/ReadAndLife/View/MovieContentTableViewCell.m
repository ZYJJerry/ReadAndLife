//
//  MovieContentTableViewCell.m
//  ReadAndLife
//
//  Created by Jerry on 16/3/2.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "MovieContentTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "HelperDefine.h"
@implementation MovieContentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setData:(MovieModel *)model{
    [self.PicImageView setImageWithURL:[NSURL URLWithString:model.coverForFeed]];
    [self.backImageView setImageWithURL:[NSURL URLWithString:model.coverBlurred]];
    self.backImageView.alpha = 0.8;
    self.title.text = model.title;
    self.desc.text = model.desc;
//    self.backgroundColor = RGB(255, 255, 191);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
