//
//  FoodSearchVM.swift
//  FoodFamily
//
//  Created by tam on 2017/11/28.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class FoodSearchVM: NSObject {
    lazy var model : [FoodSearchDataModel] = [FoodSearchDataModel]()
    var pages = 0
    var pageNum = 0
    func loadSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool ,finishedCallback : @escaping (_ hasData: Bool) -> ()) {
        if pageNum <= pages {
            NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
                let responseData = Mapper<FoodSearchModel>().map(JSONObject: json)
                if let code = responseData?.code {
                    guard  100 == code else {
                        SVProgressHUD.showInfo(withStatus: responseData?.message)
                        return
                    }
                    if showIndicator {
                        SVProgressHUD.showSuccess(withStatus: responseData?.message)
                    }
                    self.pages = (responseData?.data?.pages)!
                    //当前已经加载了一条 所以在原来基础上+1
                    self.pageNum = (responseData?.data?.pageNum)! + 1
                    
                    let array = NSMutableArray()
                    array.addObjects(from: self.model)
                    array.addObjects(from: (responseData?.data?.list)!)
                    self.model = array as! [FoodSearchDataModel]
                    finishedCallback(true)
                }
            }) { (error) in
            }
        }else{
              finishedCallback(false)
        }

    }
}
