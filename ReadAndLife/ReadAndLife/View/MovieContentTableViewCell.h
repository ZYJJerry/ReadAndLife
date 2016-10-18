//
//  MovieContentTableViewCell.h
//  ReadAndLife
//
//  Created by Jerry on 16/3/2.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
@interface MovieContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *PicImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;


- (void)setData:(MovieModel *)model;

@end
