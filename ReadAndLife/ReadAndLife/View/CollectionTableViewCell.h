//
//  CollectionTableViewCell.h
//  ReadAndLife
//
//  Created by Jerry on 16/3/4.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleDetailModel.h"
@interface CollectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *collectionImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;

- (void)setCellContent:(ArticleDetailModel *)model;

@end
