//
//  DataBaseManager.h
//  ReadAndLife
//
//  Created by Jerry on 16/3/3.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "ArticleDetailModel.h"
@interface DataBaseManager : NSObject

@property (nonatomic,strong)FMDatabase * dataBase;

+ (id)shareSingleton;

- (void)insertData:(ArticleDetailModel *)model;

- (void)deleteData:(ArticleDetailModel *)model;

- (NSArray *)searchData:(ArticleDetailModel *)model;

- (BOOL)checkDataDidCollection:(ArticleDetailModel *)data;

@end
