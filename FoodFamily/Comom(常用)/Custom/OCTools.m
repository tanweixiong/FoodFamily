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
