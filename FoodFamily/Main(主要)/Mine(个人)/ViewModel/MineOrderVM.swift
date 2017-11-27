//
//  MineOrderVM.swift
//  FoodFamily
//
//  Created by tam on 2017/11/24.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class MineOrderVM: NSObject {
    //一般请求的方法 不带模型数组
    lazy var orderModel : [MineOrderDataModel] = [MineOrderDataModel]()
    func loadSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping () -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            let responseData = Mapper<MineOrderModel>().map(JSONObject: json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.message)
                    return
                }
                if showIndicator {
                    SVProgressHUD.showSuccess(withStatus: responseData?.message)
                }
                self.orderModel = (responseData?.data?.orderList)!
                finishedCallback()
            }
        }) { (error) in
        }
    }
}
