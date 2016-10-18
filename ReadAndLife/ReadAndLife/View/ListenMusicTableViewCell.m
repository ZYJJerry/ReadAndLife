//
//  ListenMusicTableViewCell.m
//  ReadAndLife
//
//  Created by Jerry on 16/3/5.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "ListenMusicTableViewCell.h"

@implementation ListenMusicTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellWithData:(MusicDetailModel *)model{
    self.songName.text = model.title;
    self.singerName.text = model.author[@"user_name"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
