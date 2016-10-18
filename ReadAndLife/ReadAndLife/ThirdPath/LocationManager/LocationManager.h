//
//  LocationManager.h
//  LimitFree
//
//  Created by Jerry on 16/2/19.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject<CLLocationManagerDelegate>
//执行位置信息管理的manager
@property (nonatomic,strong)CLLocationManager * manager;
//存储定位信息
@property (nonatomic,strong)CLLocation * location;
//设置单例,整个程序运行过程中只创建一次
+ (LocationManager *)shareSingleton;
@end
