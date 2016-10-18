//
//  ArticleDetailModel.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "ArticleDetailModel.h"

@implementation ArticleDetailModel

+ (NSMutableArray *)getDataFromArray:(NSArray *)array{
    NSMutableArray * temp = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSDictionary * dic in array) {
        NSDictionary * subDic = dic[@"detail"];
        ArticleDetailModel * model = [[ArticleDetailModel alloc]init];
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
