//
//  LocationViewController.m
//  FoodFamily
//
//  Created by tam on 2017/11/20.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

#import "LocationViewController.h"
#import <MapKit/MapKit.h>

@interface LocationViewController ()<CLLocationManagerDelegate>
@property (strong,nonatomic) CLLocationManager* locationManager;
@end

@implementation LocationViewController

/**
 添加单例模式
 */
+(LocationViewController *)shareManager{
    static LocationViewController *manager = nil;
    static dispatch_once_t configToken;
    dispatch_once(&configToken, ^{
        manager = [[LocationViewController alloc] init];
    });
    return manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)startLocation{
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 5.0;
        [self.locationManager startUpdatingLocation];
     }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationCallBackDataLatitude:Longitude:)]) {
        [self.delegate locationCallBackDataLatitude:coordinate.latitude Longitude:coordinate.longitude];
    }
    // 2.停止定位
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}


@end
