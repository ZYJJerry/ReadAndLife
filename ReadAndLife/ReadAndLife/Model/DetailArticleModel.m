//
//  DetailArticleModel.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "DetailArticleModel.h"

@implementation DetailArticleModel

+ (DetailArticleModel *)getDataWithDictionary:(NSDictionary *)dictionary{
    NSDictionary * dic = dictionary[@"data"];
    DetailArticleModel * model = [[DetailArticleModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
