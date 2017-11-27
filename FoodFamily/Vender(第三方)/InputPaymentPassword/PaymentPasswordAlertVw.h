//
//  PaymentPasswordAlertVw.h
//  FoodFamily
//
//  Created by tam on 2017/11/16.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLTextField.h"
@interface PaymentPasswordAlertVw : UIView
@property (nonatomic,copy) void (^paymentPasswordAlertCallBackBlock)(NSInteger type);
@property (weak, nonatomic) IBOutlet UIView *backgroundVw;
@property (weak, nonatomic) IBOutlet UILabel *needPayLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UILabel *pirceLabel;


@end
