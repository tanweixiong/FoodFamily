//
//  RecommendDetailsVM.swift
//  FoodFamily
//
//  Created by tam on 2017/11/20.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class RecommendDetailsVM: NSObject {
    
    lazy var homeModel : RecommendModel = RecommendModel()!
    func loadSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping () -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            let responseData = Mapper<RecommendModel>().map(JSONObject: json)
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
