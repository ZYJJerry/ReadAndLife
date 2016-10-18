//
//  CollectionTableViewCell.m
//  ReadAndLife
//
//  Created by Jerry on 16/3/4.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "CollectionTableViewCell.h"

@implementation CollectionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellContent:(ArticleDetailModel *)model{
    self.name.text = model.name;
    self.desc.text = model.desc;
    self.name.textColor = [UIColor whiteColor];
    self.desc.textColor = [UIColor whiteColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
