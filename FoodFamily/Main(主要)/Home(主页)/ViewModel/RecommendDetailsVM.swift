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
    lazy var recommendDataModel : RecommendDataModel = RecommendDataModel()!
    func loadSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping () -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            let responseData = Mapper<RecommendModel>().map(JSONObject: json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.message)
                    return
                }
                if showIndicator {
                    SVProgressHUD.showSuccess(withStatus: responseData?.message)
                }
                if responseData?.data != nil{
                   self.recommendDataModel = (responseData?.data)!
                }
                finishedCallback()
            }
        }) { (error) in
        }
    }
    
    lazy var recommendListModel : [RecommendCommentListDataModel] = [RecommendCommentListDataModel]()
    func loadSuccessfullyCommentReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ noData:Bool) -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            let responseData = Mapper<RecommendCommentModel>().map(JSONObject: json)
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
                    array.addObjects(from: self.recommendListModel)
                    array.addObjects(from: (responseData?.data?.list)!)
                    self.recommendListModel = array as! [RecommendCommentListDataModel]
                     finishedCallback(false)
                }else{
                     finishedCallback(true)
                }
            }
        }) { (error) in
        }
    }
    
}
