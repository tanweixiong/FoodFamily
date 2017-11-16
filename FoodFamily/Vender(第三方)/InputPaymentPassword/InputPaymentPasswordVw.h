//
//  InputPaymentPasswordVw.h
//  FoodFamily
//
//  Created by tam on 2017/11/16.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputPaymentPasswordDelegate <NSObject>
-(void)inputPaymentPasswordChangeBankCard;
@optional
/** 输入完成后进行回调 */
- (NSString *)inputPaymentPassword:(NSString *)pwd;
@end

@interface InputPaymentPasswordVw : UIView
@property (nonatomic, weak) id<InputPaymentPasswordDelegate> delegate;
- (void)show;
@end
