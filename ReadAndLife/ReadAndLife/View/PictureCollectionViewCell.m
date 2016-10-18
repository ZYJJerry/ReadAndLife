//
//  PictureCollectionViewCell.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/29.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "PictureCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "HelperDefine.h"
@implementation PictureCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellImageWithModel:(PictureModel *)model{
    self.descLabel.text = model.title;
    [self.PicTureImage setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
//    self.backgroundColor = RGB(255, 255, 191);
}

@end
