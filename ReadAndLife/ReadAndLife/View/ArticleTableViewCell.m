//
//  ArticleTableViewCell.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "ArticleDetailModel.h"
#import "HelperDefine.h"
#import "DataBaseManager.h"
@implementation ArticleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellDataWith:(ArticleDetailModel *)model{
    DataBaseManager *manager = [DataBaseManager shareSingleton];
    if ([manager checkDataDidCollection:model]) {

        self.collection.text = @"已收藏";
    }else{
    
        self.collection.text = @"未收藏";
    }
    self.model = model;
    self.name.text = model.name;
    self.desc.text = model.desc;
    [self.myImageView setImageWithURL:[NSURL URLWithString:model.image]];

}
- (IBAction)collectionButtonDidClicked:(id)sender {
    DataBaseManager *manager = [DataBaseManager shareSingleton];
    if ([manager checkDataDidCollection:self.model]) {
        [manager deleteData:self.model];
        self.collection.text = @"未收藏";
    }else{
        [manager insertData:self.model];
        self.collection.text = @"已收藏";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
