//
//  LocationManager.m
//  LimitFree
//
//  Created by Jerry on 16/2/19.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "LocationManager.h"

static LocationManager * location = nil;
@implementation LocationManager

+ (LocationManager *)shareSingleton{
    @synchronized(self) {
        if (!location) {
            location = [[self alloc]init];
        }
    }
    return location;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //创建真正的执行者
        [self createLocationManager];
    }
    return self;
}

- (void)createLocationManager{
    self.manager = [[CLLocationManager alloc]init];
    self.manager.delegate =self;
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        //向用户弹出提示,申请允许在程序使用状态下取得用户的位置信息
        [self.manager requestWhenInUseAuthorization];
    }
    //开始定位
    [self.manager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    self.location= [locations lastObject];
    //NSLog(@"%f  %f",self.location.coordinate.latitude,self.location.coordinate.longitude);
    CLGeocoder * gecoder = [[CLGeocoder alloc]init];
    [gecoder reverseGeocodeLocation:self.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark * placeMark = [placemarks lastObject];
        NSString * adress = [placeMark.addressDictionary[@"FormattedAddressLines"] lastObject];
        NSLog(@"地址%@",adress);
    }];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    //NSLog(@"授权状态已经改变");
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    //NSLog(@"授权失败");
}

@end
