//
//  MovieModel.m
//  ReadAndLife
//
//  Created by Jerry on 16/3/2.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "MovieModel.h"
#import "JSONModel.h"
@implementation MovieModel

+ (NSArray *)getDataWithDictionary:(NSDictionary *)dic{
    NSMutableArray * modelArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSArray * array = dic[@"dailyList"];
    for (NSDictionary * subDic in array) {
        NSArray * vedioArray = subDic[@"videoList"];
        for (NSDictionary * realDic in vedioArray) {
            MovieModel * model = [[MovieModel alloc]init];
            [model setValuesForKeysWithDictionary:realDic];
            model.desc = realDic[@"description"];
            [modelArray addObject:model];
        }
    }
    
    return modelArray;
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"desc",@"id":@"uId"}];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}



@end
