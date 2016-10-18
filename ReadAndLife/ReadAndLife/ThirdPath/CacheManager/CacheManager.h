//
//  CacheManager.h
//  MyRealityLife
//
//  Created by Jerry on 16/2/28.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject

//根据URL获取数据
+ (id)getDataFromCache:(NSString *)url;
//根据URL和数据写入缓存
+ (BOOL)writeDataToCache:(id)responseObject withUrl:(NSString *)url;

//文件操作需要一个fileManager
@property (nonatomic, strong) NSFileManager *manager;

+ (CacheManager *)manager;

- (NSString *)getFullPathByURL:(NSString *)url;

- (void)clearDisk;
@end
