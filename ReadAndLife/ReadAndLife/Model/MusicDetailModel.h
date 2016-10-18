//
//  MusicDetailModel.h
//  MyRealityLife
//
//  Created by Jerry on 16/2/26.
//  Copyright © 2016年 zhouyuju. All rights reserved.
/*
 "id": "221",
 "title": "整夜大雨",
 "cover": "http://image.wufazhuce.com/FsX9qltcy6727mzNAOz_F1YGcx_j",
 "isfirst": "0",
 "story_title": "渴望幸福的机器人",
 "story":
 "lyric":
 "info":
 "platform": "1",
 "music_id": "1773344114",
 "charge_edt": "（责任编辑：叶耶耶子）",
 "related_to": "0",
 "web_url": "http://m.xiami.com/song/1773344114?f=one",
 "praisenum": 561,
 "sort": "0",
 "maketime": "2016-02-25 20:55:00",
 "last_update_date": "2016-02-25 16:53:51",
 "author": {
 "user_id": "6143208",
 "user_name": "邱比",
 "web_url": "http://image.wufazhuce.com/FhqFpQeCptqbQbWm8dJctGlefU6k",
 "desc": "台湾音乐人"
 },
 "story_author": {
 "user_id": "6143208",
 "user_name": "邱比",
 "web_url": "http://image.wufazhuce.com/FhqFpQeCptqbQbWm8dJctGlefU6k"
 }
 }
 */

#import "BaseModel.h"

@interface MusicDetailModel : BaseModel

@property (nonatomic,copy)NSString *id;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *cover;
@property (nonatomic,copy)NSString *story_title;
@property (nonatomic,copy)NSString *story;
@property (nonatomic,copy)NSString *lyric;
@property (nonatomic,copy)NSString *info;
@property (nonatomic,copy)NSString *music_id;
@property (nonatomic,strong)NSDictionary *author;
@property (nonatomic,strong)NSDictionary *story_author;

+ (MusicDetailModel *)getModelFromData:(NSDictionary *)dic;

@end
