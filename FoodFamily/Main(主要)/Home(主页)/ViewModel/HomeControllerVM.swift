//
//  HomeControllerVM.swift
//  FoodFamily
//
//  Created by tam on 2017/11/17.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class HomeControllerVM: NSObject {

    //一般请求的方法 不带模型数组
    lazy var homeModel : HomeModel = HomeModel()!
     func loadSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping () -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            let responseData = Mapper<HomeModel>().map(JSONObject: json)
            print(json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.message)
                    return
                }
                if showIndicator {
                    SVProgressHUD.showSuccess(withStatus: responseData?.message)
                }
                self.homeModel = responseData!
                finishedCallback()
            }
        }) { (error) in
        }
    }
    
}
