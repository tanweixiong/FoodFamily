//
//  CrowdfundingVM.swift
//  FoodFamily
//
//  Created by tam on 2017/12/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class CrowdfundingVM: NSObject {
    //一般请求的方法 不带模型数组
    lazy var model : [CrowdfundingDataModel] = [CrowdfundingDataModel]()
    var pages = 0
    var pageNum = 0
    func loadSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ hasData:Bool) -> ()) {
        if pageNum <= pages {
            NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
                let responseData = Mapper<CrowdfundingModel>().map(JSONObject: json)
                if let code = responseData?.code {
                    guard  100 == code else {
                        SVProgressHUD.showInfo(withStatus: responseData?.message)
                        return
                    }
                    self.pages = (responseData?.data?.pages)!
                    //当前已经加载了一条 所以在原来基础上+1
                    self.pageNum = (responseData?.data?.pageNum)! + 1
                    let array = NSMutableArray()
                    array.addObjects(from: self.model)
                    array.addObjects(from: (responseData?.data?.list)!)
                    self.model = array as! [CrowdfundingDataModel]
                    finishedCallback(true)
                }
            }) { (error) in
            }
        }else{
            finishedCallback(false)
        }
    }
    
    
    //一般请求的方法 不带模型数组
    lazy var couponsModel : [CrowdfundingPayCouponsDataModel] = [CrowdfundingPayCouponsDataModel]()
    func loadCouponsSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ hasData:Bool) -> ()) {
        if pageNum <= pages {
            NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
                print(json)
                let responseData = Mapper<CrowdfundingPayCouponsModel>().map(JSONObject: json)
                if let code = responseData?.code {
                    guard  100 == code else {
                        SVProgressHUD.showInfo(withStatus: responseData?.message)
                        return
                    }
                    self.couponsModel = (responseData?.data)!
                }
                finishedCallback(true)
            }) { (error) in
            }
        }else{
            finishedCallback(false)
        }
    }
    
}
