//
//  ListenMusicTableViewCell.h
//  ReadAndLife
//
//  Created by Jerry on 16/3/5.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicDetailModel.h"
@interface ListenMusicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UILabel *singerName;
- (void)setCellWithData:(MusicDetailModel *)model;
@end
