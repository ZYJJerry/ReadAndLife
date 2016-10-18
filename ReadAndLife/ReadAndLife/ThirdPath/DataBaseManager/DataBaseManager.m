//
//  DataBaseManager.m
//  ReadAndLife
//
//  Created by Jerry on 16/3/3.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "DataBaseManager.h"

static DataBaseManager * manager = nil;
@implementation DataBaseManager


+ (id)shareSingleton{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[DataBaseManager alloc]init];
        }
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //创建数据库
        [self createDataBase];
        //创建表
        [self createTable];
    }
    return self;
}

- (void)createDataBase{
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/ReadAndLife.db"];
    //NSLog(@"%@",path);
    self.dataBase = [FMDatabase databaseWithPath:path];
    if (self.dataBase) {
        //NSLog(@"建库成功");
        [self.dataBase open];
    }else{
        //NSLog(@"创建数据库失败");
        [self.dataBase close];
    }
    
}
- (void)createTable{
    NSString * sqlString = @"create table if not exists Collection(unid text,name text,desc text);";
    BOOL result = [self.dataBase executeUpdate:sqlString];
    if (!result) {
        //NSLog(@"App收藏表创建失败，数据库即将关闭");
        //关闭数据库
        [self.dataBase close];
    }else{
        //NSLog(@"建表成功");
    }
}
//增加数据
- (void)insertData:(ArticleDetailModel *)model {
    NSString *sqlString = @"insert into Collection (unid,name, desc) values (?,?,?);";

    BOOL result = [self.dataBase executeUpdate:sqlString, model.unid,model.name,model.desc];
    if (!result) {
        //NSLog(@"数据插入失败，数据库即将关闭");
        [self.dataBase close];
    }
}

- (void)deleteData:(ArticleDetailModel *)model{
    NSString * sqlString = @"delete from Collection where unid = ?;";
    BOOL result = [self.dataBase executeUpdate:sqlString, model.unid];
    if (!result) {
        //NSLog(@"删除失败，即将关闭数据库");
        [self.dataBase close];
    }
}

- (NSArray *)searchData:(ArticleDetailModel *)model{
    NSString * sqlString = nil;
    if (!model) {
        sqlString = @"select * from Collection;";
    }else{
        sqlString = [NSString stringWithFormat:@"select * from Collection where unid = '%@';", model.unid];
    }
    NSMutableArray * temp = [[NSMutableArray alloc]initWithCapacity:0];
    FMResultSet * result =[self.dataBase executeQuery:sqlString];
    while (result.next) {
        ArticleDetailModel * newModel = [[ArticleDetailModel alloc]init];
        newModel.unid = [result stringForColumn:@"unid"];
        newModel.name = [result stringForColumn:@"name"];
        newModel.desc = [result stringForColumn:@"desc"];
        [temp addObject:newModel];
    }
    return temp;
}


- (BOOL)checkDataDidCollection:(ArticleDetailModel *)data{
        NSArray *objects = [self searchData:data];
        if ([objects count] != 0) {
            return YES;
        } else {
            return NO;
        }
}

@end
