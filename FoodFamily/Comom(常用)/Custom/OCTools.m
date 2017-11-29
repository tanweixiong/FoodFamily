//
//  WalletOCTools.m
//  Wallet
//
//  Created by tam on 2017/10/24.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

#import "OCTools.h"

@implementation OCTools

+ (UIViewController *)getCurrentVC {

    UIWindow * window = [[UIApplication sharedApplication] keyWindow];

    if (window.windowLevel != UIWindowLevelNormal){

        NSArray *windows = [[UIApplication sharedApplication] windows];

        for(UIWindow * tmpWin in windows){

            if (tmpWin.windowLevel == UIWindowLevelNormal){

                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;

    while (result.presentedViewController) {
        result = result.presentedViewController;
    }

    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];

    }
    return result;
}
    
+(NSDictionary *)getDictionaryFromJSONString:(NSString *)jsonStr{
    NSData * getJsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error = nil;
    NSDictionary * getDict = [NSJSONSerialization JSONObjectWithData:getJsonData options:NSJSONReadingMutableContainers error:&error];
    return  getDict;
}

+(NSString *)getJSONStringFromDictionary:(id)testDict{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:testDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}
 
+(NSMutableDictionary *)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:keyedValues];
    NSArray *valueArray= [dic allKeys];
    for (NSString *key in valueArray) {
        if ([[dic objectForKey:key]isEqual:[NSNull null]]) {
            [dic setObject:@"" forKey:key];
        }
    }
    return dic;
}

NSMutableAttributedString *GetAttributedText(NSString *value) {//这里调整富文本的段落格式
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:value];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:8.0];
    //    [paragraphStyle setParagraphSpacing:11];  //调整段间距
    //    [paragraphStyle setHeadIndent:75.0];//段落整体缩进
    //    [paragraphStyle setFirstLineHeadIndent:.0];//首行缩进
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [value length])];
    return attributedString;
}

+(CGSize)calculateMeaasgeHeightWithText:(NSString *)string andWidth:(CGFloat)width andFont:(UIFont *)font {
    static UILabel *stringLabel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{//生成一个同于计算文本高度的label
        stringLabel = [[UILabel alloc] init];
        stringLabel.numberOfLines = 0;
    });
    stringLabel.font = font;
    stringLabel.attributedText = GetAttributedText(string);
    CGSize size = CGSizeMake([stringLabel sizeThatFits:CGSizeMake(width, MAXFLOAT)].width, [stringLabel sizeThatFits:CGSizeMake(width, MAXFLOAT)].height);
    return size;
}

+(NSArray *)getCurrentNumberDays{
    NSDate * date = [NSDate date];//当前时间
    
    NSMutableArray *dayArray= [[NSMutableArray alloc] init];
    
    NSDate *day = [NSDate dateWithTimeInterval:1*60*60 sinceDate:date];
//    NSString *time = [OCTools timeStringFromFormat:@"yyyy-MM-dd" withDate:day];
//    NSString *week = [OCTools getTheDayOfTheWeekByDateString:time];
    NSString *nowTime = [OCTools timeStringFromFormat:@"MM-dd" withDate:day];
    NSString *nowDay = [NSString stringWithFormat:@"%@ %@",@"今天",nowTime];
    [dayArray addObject:nowDay];
    
    NSDate *day1 = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];
//    NSString *time1 = [OCTools timeStringFromFormat:@"yyyy-MM-dd" withDate:day1];
//    NSString *week1 = [OCTools getTheDayOfTheWeekByDateString:time1];
    NSString *nowTime1 = [OCTools timeStringFromFormat:@"MM-dd" withDate:day1];
    NSString *nowDay1 = [NSString stringWithFormat:@"%@ %@",@"明天",nowTime1];
    [dayArray addObject:nowDay1];
    
    NSDate *day2 = [NSDate dateWithTimeInterval:48*60*60 sinceDate:date];
    NSString *time2 = [OCTools timeStringFromFormat:@"yyyy-MM-dd" withDate:day2];
    NSString *week2 = [OCTools getTheDayOfTheWeekByDateString:time2];
    NSString *nowTime2 = [OCTools timeStringFromFormat:@"MM-dd" withDate:day2];
    NSString *nowDay2 = [NSString stringWithFormat:@"%@ %@",week2,nowTime2];
    [dayArray addObject:nowDay2];
    
    NSDate *day3 = [NSDate dateWithTimeInterval:72*60*60 sinceDate:date];
    NSString *time3 = [OCTools timeStringFromFormat:@"yyyy-MM-dd" withDate:day3];
    NSString *week3 = [OCTools getTheDayOfTheWeekByDateString:time3];
    NSString *nowTime3 = [OCTools timeStringFromFormat:@"MM-dd" withDate:day3];
    NSString *nowDay3 = [NSString stringWithFormat:@"%@ %@",week3,nowTime3];
    [dayArray addObject:nowDay3];
    
    NSDate *day4 = [NSDate dateWithTimeInterval:96*60*60 sinceDate:date];
    NSString *time4 = [OCTools timeStringFromFormat:@"yyyy-MM-dd" withDate:day4];
    NSString *week4 = [OCTools getTheDayOfTheWeekByDateString:time4];
    NSString *nowTime4 = [OCTools timeStringFromFormat:@"MM-dd" withDate:day4];
    NSString *nowDay4 = [NSString stringWithFormat:@"%@ %@",week4,nowTime4];
    [dayArray addObject:nowDay4];
    
    NSDate *day5 = [NSDate dateWithTimeInterval:120*60*60 sinceDate:date];
    NSString *time5 = [OCTools timeStringFromFormat:@"yyyy-MM-dd" withDate:day5];
    NSString *week5 = [OCTools getTheDayOfTheWeekByDateString:time5];
    NSString *nowTime5 = [OCTools timeStringFromFormat:@"MM-dd" withDate:day5];
    NSString *nowDay5 = [NSString stringWithFormat:@"%@ %@",week5,nowTime5];
    [dayArray addObject:nowDay5];
    
    NSDate *day6 = [NSDate dateWithTimeInterval:144*60*60 sinceDate:date];
    NSString *time6 = [OCTools timeStringFromFormat:@"yyyy-MM-dd" withDate:day6];
    NSString *week6 = [OCTools getTheDayOfTheWeekByDateString:time6];
    NSString *nowTime6 = [OCTools timeStringFromFormat:@"MM-dd" withDate:day6];
    NSString *nowDay6 = [NSString stringWithFormat:@"%@ %@",week6,nowTime6];
    [dayArray addObject:nowDay6];
    
    NSArray *data = dayArray;
    return data;
}

+(NSString *)timeStringFromFormat:(NSString *)format withDate:(NSDate *)data{
    NSString *strDiff = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:format];
    strDiff = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:data]];
    return  strDiff;
}

///根据用户输入的时间(dateString)确定当天是星期几,输入的时间格式 yyyy-MM-dd ,如 2015-12-18
+(NSString *)getTheDayOfTheWeekByDateString:(NSString *)dateString{
    NSDateFormatter *inputFormatter=[[NSDateFormatter alloc]init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *formatterDate=[inputFormatter dateFromString:dateString];
    NSDateFormatter *outputFormatter=[[NSDateFormatter alloc]init];
    [outputFormatter setDateFormat:@"EEEE-MMMM-d"];
    NSString *outputDateStr=[outputFormatter stringFromDate:formatterDate];
    NSArray *weekArray=[outputDateStr componentsSeparatedByString:@"-"];
    return [weekArray objectAtIndex:0];
}

//- (NSData *)toJSONData:(id)theData{
//    
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:&error];
//    
//    if ([jsonData length] > 0 && error == nil){
//        return jsonData;
//    }else{
//        return nil;
//    }
//}

//func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
//    
//    let jsonData:Data = jsonString.data(using: .utf8)!
//    
//    let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//    if dict != nil {
//        return dict as! NSDictionary
//    }
//    return NSDictionary()
//    
//    
//}
//
//func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
//    if (!JSONSerialization.isValidJSONObject(dictionary)) {
//        print("无法解析出JSONString")
//        return ""
//    }
//    let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
//    let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
//    return JSONString! as String
//    
//}

@end
