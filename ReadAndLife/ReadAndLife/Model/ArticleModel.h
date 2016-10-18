//
//  ArticleModel.h
//  MyRealityLife
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
/*
 "title": "败犬女王",
 "image": 
 "desc": "相亲相爱太易令人迷方向，始终怕跨不过。",
 "status": true,
 "link": "maichong://subject/get?id=146&title=%E8%B4%A5%E7%8A%AC%E5%A5%B3%E7%8E%8B",
 "createdat": 1456329601,
 "items":
 */

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject

@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * image;
@property (nonatomic,copy)NSString * desc;
@property (nonatomic,strong)NSArray * items;

+ (NSMutableArray *)getDataWithDictionary:(NSDictionary *)dictionary;

@end
