//
//  FoodIntegralVM.swift
//  FoodFamily
//
//  Created by tam on 2017/11/29.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import  Alamofire
import SVProgressHUD

class FoodIntegralVM: NSObject {
    lazy var model : FoodIntegralDataModel = FoodIntegralDataModel()!
    func loadSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool ,finishedCallback : @escaping () -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            print(json)
            let responseData = Mapper<FoodIntegralModel>().map(JSONObject: json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.message)
                    return
                }
                if showIndicator {
                    SVProgressHUD.showSuccess(withStatus: responseData?.message)
                }
                self.model = (responseData?.data)!
                finishedCallback()
            }
        }) { (error) in
        }
    }
}
