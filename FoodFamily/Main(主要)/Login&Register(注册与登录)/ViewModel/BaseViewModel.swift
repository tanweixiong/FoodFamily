//
//  BaseViewModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/13.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD

class BaseViewModel: NSObject {

    lazy var responseData: [ResponseData] = [ResponseData]()
    func loadAnchorGroupData(type : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetWorkTool.request(requestType: .post, URLString:ConstAPI.kAPIUserGetPhoneCode, parameters: parameters, showIndicator: true, success: { (json) in
            let responseData = Mapper<ResponseData>().map(JSONObject: json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.msg)
                    return
                }
                finishedCallback()
            }
        }) { (error) in
        }
    }
    
}
