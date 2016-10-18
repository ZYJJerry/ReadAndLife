//
//  ArticleModel.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel

+ (NSMutableArray *)getDataWithDictionary:(NSDictionary *)dictionary{
    NSDictionary * dic = dictionary[@"data"];
    NSArray * array = dic[@"list"];
    NSMutableArray * temp = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSDictionary * subDic in array) {
        ArticleModel * model = [[ArticleModel alloc]init];
        [model setValuesForKeysWithDictionary:subDic];
        [temp addObject:model];
    }
    return temp;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
