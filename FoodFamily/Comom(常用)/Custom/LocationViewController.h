//
//  LocationViewController.h
//  FoodFamily
//
//  Created by tam on 2017/11/20.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LocationDelegate <NSObject>
- (void)locationCallBackDataLatitude:(CGFloat)latitude Longitude:(CGFloat)longitude;
@end

@interface LocationViewController : UIViewController
+(LocationViewController *)shareManager;
-(void)startLocation;
@property (nonatomic,assign)id<LocationDelegate>delegate;
@end
