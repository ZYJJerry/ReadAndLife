//
//  ArticleDetailModel.h
//  MyRealityLife
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
/*
 {
 "unid": "32583",
 "name": "南方下北风",
 "desc": "离开的时候她嘴上还叼着一根翘得老高的烟，对初小姐说：“我想学的是时装设计剪
 */

#import <Foundation/Foundation.h>

@interface ArticleDetailModel : NSObject
@property (nonatomic,copy)NSString * unid;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * desc;
@property (nonatomic,copy)NSString * contentLink;
@property (nonatomic,copy)NSString * shareLink;
@property (nonatomic,copy)NSString * image;
//@property (nonatomic,strong)NSDictionary * detail;
+ (NSMutableArray *)getDataFromArray:(NSArray *)array;


@end
