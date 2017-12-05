//
//  FoodVoucherOrderDetailsVM.swift
//  FoodFamily
//
//  Created by tam on 2017/11/28.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

enum FoodOrderDetailsVMType{
    case canteenModel
    case voucherModel
    case packageModel
}

class FoodOrderDetailsVM: NSObject {
    //堂吃 预约
    lazy var canteenModel : FoodOrderCanteenListModel = FoodOrderCanteenListModel()!
    //代金券
    lazy var voucherModel : FoodOrderVoucherListModel = FoodOrderVoucherListModel()!
    //套餐
    lazy var packageModel : FoodOrderPackageListModel = FoodOrderPackageListModel()!
    
    func loadSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String,type: FoodOrderDetailsVMType ,parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping () -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            let responseData = Mapper<ResponseData>().map(JSONObject: json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.message)
                    return
                }
                if type == .canteenModel {
                   let responseData = Mapper<FoodOrderCanteenModel>().map(JSONObject: json)
                    self.canteenModel = (responseData?.data)!
                }else if type == .voucherModel {
                   let responseData = Mapper<FoodOrderVoucherModel>().map(JSONObject: json)
                    self.voucherModel = (responseData?.data)!
                }else{
                    let responseData = Mapper<FoodOrderPackageModel>().map(JSONObject: json)
                    self.packageModel = (responseData?.data)!
                }
                finishedCallback()
            }
        }) { (error) in
        }
    }
}
