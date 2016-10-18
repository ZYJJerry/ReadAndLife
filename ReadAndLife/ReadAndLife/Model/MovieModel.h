//
//  MovieModel.h
//  ReadAndLife
//
//  Created by Jerry on 16/3/2.
//  Copyright © 2016年 周玉举. All rights reserved.
/*
 {
 "id": 4724,
 "date": 1456848000000,
 "idx": 1,
 "title": "再见，终于过去的爱情",
 "description": "创意定格爱情短片「Amlia & Duarte」（阿米莉亚和杜瓦特）的故事从他们分手的那一刻开始，当生活中充满了对方遗留的气息、两个人共同的回忆，想要真正挥别那份过去的爱情并不容易。From Filmbilder",
 "category": "剧情",
 "duration": 490,
 "playUrl": "http://baobab.wdjcdn.com/14568142592690301love_x264.mp4",
 "playInfo": [
 {
 "height": 480,
 "width": 854,
 "name": "标清",
 "type": "normal",
 "url": "http://baobab.wdjcdn.com/1456815135074_4724_854x480.mp4"
 },
 {
 "height": 720,
 "width": 1280,
 "name": "高清",
 "type": "high",
 "url": "http://baobab.wdjcdn.com/14568142592690301love_x264.mp4"
 }
 ],
 "consumption": {
 "collectionCount": 376,
 "shareCount": 350,
 "playCount": 0,
 "replyCount": 18
 },
 "promotion": null,
 "waterMarks": null,
 "provider": {
 "name": "YouTube",
 "alias": "youtube",
 "icon": "http://img.wdjimg.com/image/video/fa20228bc5b921e837156923a58713f6_256_256.png"
 },
 "author": null,
 "adTrack": null,
 "shareAdTrack": null,
 "favoriteAdTrack": null,
 "webAdTrack": null,
 "coverForFeed": "http://img.wdjimg.com/image/video/0832b33b3cb36e4a91cf6bb6de8722f4_0_0.jpeg",
 "coverForDetail": "http://img.wdjimg.com/image/video/0832b33b3cb36e4a91cf6bb6de8722f4_0_0.jpeg",
 "coverBlurred": "http://img.wdjimg.com/image/video/1ee31e59165e61cbc1fc88215384e0da_0_0.jpeg",
 "coverForSharing": "http://img.wdjimg.com/image/video/0832b33b3cb36e4a91cf6bb6de8722f4_0_0.jpeg",
 "webUrl": "http://wandou.im/16rru5",
 "rawWebUrl": "http://www.wandoujia.com/eyepetizer/detail.html?vid=4724"
 }
 */

#import "BaseModel.h"

@interface MovieModel : BaseModel

@property (nonatomic,copy)NSString * uId;
@property (nonatomic,copy)NSString * desc;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * category;
@property (nonatomic,copy)NSString * duration;
@property (nonatomic,copy)NSString * playUrl;
@property (nonatomic,copy)NSString * coverForFeed;
@property (nonatomic,copy)NSString * coverForDetail;
@property (nonatomic,copy)NSString * coverBlurred;
@property (nonatomic,copy)NSString * rawWebUrl;

+ (NSArray *)getDataWithDictionary:(NSDictionary *)dic;
@end
