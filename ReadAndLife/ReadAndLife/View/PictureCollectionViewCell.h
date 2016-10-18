//
//  PictureCollectionViewCell.h
//  MyRealityLife
//
//  Created by Jerry on 16/2/29.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureModel.h"

@interface PictureCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *PicTureImage;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

- (void)setCellImageWithModel:(PictureModel *)model;

@end
