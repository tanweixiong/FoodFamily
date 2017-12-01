//
//  FoodMerchantsVM.swift
//  FoodFamily
//
//  Created by tam on 2017/11/28.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class FoodMerchantsVM: NSObject {
    //一般请求的方法 不带模型数组
    lazy var merchantsModel : [FoodMerchantsDataModel] = [FoodMerchantsDataModel]()
    func loadSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping () -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            let responseData = Mapper<FoodMerchantsModel>().map(JSONObject: json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.message)
                    return
                }
                if showIndicator {
                    SVProgressHUD.showSuccess(withStatus: responseData?.message)
                }
                self.merchantsModel = (responseData?.data)!
                finishedCallback()
            }
        }) { (error) in
        }
    }
    
    //获取分类
    lazy var classificationModel : [FoodSearchDataModel] = [FoodSearchDataModel]()
    func loadClassificationSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ hasData:Bool) -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            print(json)
            let responseData = Mapper<FoodSearchModel>().map(JSONObject: json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.message)
                    return
                }
                if showIndicator {
                    SVProgressHUD.showSuccess(withStatus: responseData?.message)
                }
                if responseData?.data?.list?.count != 0 {
                    let array = NSMutableArray()
                    array.addObjects(from: self.classificationModel)
                    array.addObjects(from: (responseData?.data?.list)!)
                    self.classificationModel = array as! [FoodSearchDataModel]
                    finishedCallback(true)
                }else{
                    finishedCallback(false)
                }
            }
        }) { (error) in
        }
    }
    
}
