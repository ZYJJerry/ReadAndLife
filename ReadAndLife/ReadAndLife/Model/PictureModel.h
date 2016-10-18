//
//  PictureModel.h
//  MyRealityLife
//
//  Created by Jerry on 16/2/28.
//  Copyright © 2016年 zhouyuju. All rights reserved.
/*
 {
 "guid": 12384,
 "type": 1,
 "cat": "9",
 "title": "Winter on Fire",
 "thumb": "http://pic.yupoo.com/fotomag/Fm40WtnJ/6O8UJ.jpg",
 "thumb_hd": "http://pic.yupoo.com/fotomag/Fm40WtnJ/6O8UJ.jpg",
 "cover": "http://pic.yupoo.com/fotomag/Fm40YmhQ/1uLzs.jpg",
 "cover_hd": "http://pic.yupoo.com/fotomag/Fm40YmhQ/1uLzs.jpg",
 "cover_hd_568h": "http://pic.yupoo.com/fotomag/Fm40YCTu/G3kpo.jpg",
 "pubdate": "February 28,2016",
 "archive_timestamp": 1456675200,
 "timestamp": 1456678320,
 "summary": "",
 "content": "《凛冬烈火：乌克兰为自由而战》电影海报",
 "latitude": 0,
 "longitude": 0,
 "geo_span": 0,
 "has_video": 0,
 "has_caption": 0,
 "has_location": 0,
 "has_toolbar": 0,
 "enable_wechat": 0,
 "is_focus": 0,
 "is_banner": 0
 }
 */

#import <Foundation/Foundation.h>

@interface PictureModel : NSObject

@property (nonatomic,copy)NSString * title;

@property (nonatomic,copy)NSString * thumb;

@property (nonatomic,copy)NSString * content;

@property (nonatomic,copy)NSString * cover;


+ (NSArray *)getModelWithData:(NSArray *)array;

@end
