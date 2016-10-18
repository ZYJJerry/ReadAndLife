//
//  MusicModel.h
//  MyRealityLife
//
//  Created by Jerry on 16/2/26.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "BaseModel.h"

@interface MusicModel : BaseModel

@property (nonatomic,copy)NSString * data;

+ (NSArray *)getDataFromDictionary:(NSDictionary *)dic;

@end
