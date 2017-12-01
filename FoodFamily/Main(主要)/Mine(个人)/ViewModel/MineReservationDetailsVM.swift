//
//  MineReservationDetailsVM.swift
//  FoodFamily
//
//  Created by tam on 2017/12/1.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class MineReservationDetailsVM: NSObject {
    lazy var model : MineReservationDetailsDataModel = MineReservationDetailsDataModel()!
    func loadSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping () -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            let responseData = Mapper<MineReservationDetailsModel>().map(JSONObject: json)
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
