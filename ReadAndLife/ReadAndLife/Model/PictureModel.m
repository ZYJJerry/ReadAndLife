//
//  PictureModel.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/28.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "PictureModel.h"

@implementation PictureModel

+ (NSArray *)getModelWithData:(NSArray *)array{
    NSMutableArray * temp = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in array) {
        if (![dic objectForKey:@"website"]) {
            [temp addObject:dic];
        }
    }
    NSMutableArray * modelArray = [[NSMutableArray alloc]init];
    for (NSDictionary * dict in temp) {
        PictureModel * model = [[PictureModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [modelArray addObject:model];
    }
    return modelArray;
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
