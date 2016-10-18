//
//  MusicDetailModel.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/26.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "MusicDetailModel.h"

@implementation MusicDetailModel

+ (MusicDetailModel *)getModelFromData:(NSDictionary *)dic{
    NSDictionary * subDic = dic[@"data"];
    MusicDetailModel * model = [[MusicDetailModel alloc]init];
    [model setValuesForKeysWithDictionary:subDic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
