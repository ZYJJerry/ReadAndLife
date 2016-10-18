//
//  MusicModel.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/26.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel


+ (NSArray *)getDataFromDictionary:(NSDictionary *)dic{
    NSArray * array = dic[@"data"];
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
