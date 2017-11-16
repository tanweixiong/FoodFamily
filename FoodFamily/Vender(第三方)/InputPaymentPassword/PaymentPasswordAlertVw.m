//
//  PaymentPasswordAlertVw.m
//  FoodFamily
//
//  Created by tam on 2017/11/16.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

#import "PaymentPasswordAlertVw.h"

@implementation PaymentPasswordAlertVw

-(void)layoutSubviews{
    [super layoutSubviews];
    self.changeButton.layer.borderWidth = 1;
    self.changeButton.layer.borderColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1].CGColor;
}

@end
