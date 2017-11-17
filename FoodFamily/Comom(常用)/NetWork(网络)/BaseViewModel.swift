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
                SVProgressHUD.showSuccess(withStatus: responseData?.message)
                finishedCallback()
            }
        }) { (error) in
        }
    }
    
}
