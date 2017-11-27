//
//  BaseViewModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/13.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//  统一处理数据与模型

import UIKit
import SVProgressHUD
import Alamofire
import MJExtension

enum BaseRequestType{
    case post
    case get
}

class BaseViewModel: NSObject {
   var  baseRequestType = BaseRequestType.post
   lazy var responseData: [ResponseData] = [ResponseData]()
    
    //一般请求的方法 不带模型数组
    class func loadSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping () -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            let responseData = Mapper<ResponseData>().map(JSONObject: json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.message)
                    return
                }
                if showIndicator {
                    SVProgressHUD.showSuccess(withStatus: responseData?.message)
                }
                finishedCallback()
            }
        }) { (error) in
        }
    }
    
    //登录后保存数组模型的方法
    class func loadSuccessfullyLoginData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            let responseData = Mapper<ResponseData>().map(JSONObject: json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.message)
                    return
                }
                if (json["data"] != nil) && String(describing: json["data"]) != "" {
                    let password = UserDefaults.standard.getUserInfo().password
                    let data = json["data"] as![String:AnyObject]
                    let user = data["user"] as![String:AnyObject]
                    UserDefaults.standard.set(true, forKey: R_Theme_isLogin)
                    let userInfo = UserInfo(dict: user as [String : AnyObject])
                    userInfo.password = password
                    UserDefaults.standard.saveCustomObject(customObject: userInfo, key: R_UserInfo)
                }
                finishedCallback()
            }
        }) { (error) in
        }
    }
    
}
