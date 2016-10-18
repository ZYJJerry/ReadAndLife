//
//  CacheManager.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/28.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "CacheManager.h"
#import "NSString+Hashing.h"
static CacheManager * cache = nil;

@implementation CacheManager

+ (id)getDataFromCache:(NSString *)url{
    
    if (!cache) {
        cache = [[CacheManager alloc]init];
    }
    //获取路径
    NSString *filePath = [cache getFullPathByURL:url];
    
    //返回二进制
    return [NSData dataWithContentsOfFile:filePath];
}


//根据URL和数据写入缓存
+ (BOOL)writeDataToCache:(id)responseObject withUrl:(NSString *)url {
    if (!cache) {
        cache = [CacheManager manager];
    }
    //获取文件路径(根据Hash后的URL作为文件名称)
    NSString *fullPath = [cache getFullPathByURL:url];
    //把数据写入文件
    return [cache writeData:responseObject toFile:fullPath];
}

+ (CacheManager *)manager {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (!cache) {
            cache = [[self alloc] init];
        }
    });
    return cache;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.manager = [NSFileManager defaultManager];
    }
    return self;
}


- (NSString *)getFullPathByURL:(NSString *)url{
    //md5加密
    NSString * fileName = [url MD5Hash];
    //获取文件主路径
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    path = [path stringByAppendingString:@"/ResponseCache"];
    //NSLog(@"文件在这儿:--%@",path);
    BOOL isDirectory = YES;
    //如果不存在就创建
    if (![self.manager fileExistsAtPath:path isDirectory:&isDirectory]) {
        NSError *error = nil;
        [self.manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        
    }
    return [path stringByAppendingFormat:@"/%@",fileName];
}

- (void)clearDisk{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    path = [path stringByAppendingString:@"/ResponseCache"];
    if ([self.manager fileExistsAtPath:path]) {
        NSError *error = nil;
        [self.manager removeItemAtPath:path error:&error];
    }
}


//写入操作
- (BOOL)writeData:(id)responseObject toFile:(NSString *)filePath {
    //如果文件不存在，如果存在，但是超时，也写入。
    if ([self checkCacheIsTimeout:filePath] || ![self.manager fileExistsAtPath:filePath]) {
        //创建一个文件，文件地址为filePath，内容为responseObject
        return [self.manager createFileAtPath:filePath contents:responseObject attributes:nil];
    }
    return NO;
}

//判断缓存是否超时
- (BOOL)checkCacheIsTimeout:(NSString *)filePath {
    NSError *error = nil;
    //获取文件的信息
    NSDictionary *dict = [self.manager attributesOfItemAtPath:filePath error:&error];
    //当前文件最新的修改时间
    NSDate *modificationDate = dict[NSFileModificationDate];
    //取得时间差(最新修改时间至当前时间的时间差)
    NSTimeInterval time = [modificationDate timeIntervalSinceNow];
    if (time >= 50 * 60) {
        return YES;
    }
    //NSLog(@"%f",time);
    return NO;
}
@end
