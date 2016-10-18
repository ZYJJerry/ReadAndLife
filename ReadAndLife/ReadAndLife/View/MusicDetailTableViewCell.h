//
//  MusicDetailTableViewCell.h
//  MyRealityLife
//
//  Created by Jerry on 16/2/26.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicDetailModel.h"
@interface MusicDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *musicImage;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *authorName;

@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UILabel *storyContent;
@property (weak, nonatomic) IBOutlet UIImageView *authorIcon;
@property (weak, nonatomic) IBOutlet UIButton *MusicShow;
- (void)setCellContentWithData:(MusicDetailModel *)model;

@end
