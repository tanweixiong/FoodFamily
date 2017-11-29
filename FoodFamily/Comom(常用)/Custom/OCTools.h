//
//  WalletOCTools.h
//  Wallet
//
//  Created by tam on 2017/10/24.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OCTools : NSObject
+(UIViewController *)getCurrentVC;
+(NSDictionary *)getDictionaryFromJSONString:(NSString *)jsonStr;
+(NSString *)getJSONStringFromDictionary:(id)testDict;
+(NSDictionary *)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues;
+(CGSize)calculateMeaasgeHeightWithText:(NSString *)string andWidth:(CGFloat)width andFont:(UIFont *)font;
+(NSArray *)getCurrentNumberDays;
@end
