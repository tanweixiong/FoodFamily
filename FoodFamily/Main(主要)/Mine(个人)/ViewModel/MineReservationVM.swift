//
//  MineReservationVM.swift
//  FoodFamily
//
//  Created by tam on 2017/11/30.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class MineReservationVM: NSObject {
    lazy var finishModel : [MineReservationDataModel] = [MineReservationDataModel]()
    var finishPages = 0
    var finishPageNum = 0
    func loadSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ hasData:Bool) -> ()) {
        if finishPageNum <= finishPages {
            NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
                let responseData = Mapper<MineReservationModel>().map(JSONObject: json)
                if let code = responseData?.code {
                    guard  100 == code else {
                        SVProgressHUD.showInfo(withStatus: responseData?.message)
                        return
                    }
                    if showIndicator {
                        SVProgressHUD.showSuccess(withStatus: responseData?.message)
                    }
                    self.finishPages = (responseData?.data?.pages)!
                    //当前已经加载了一条 所以在原来基础上+1
                    self.finishPageNum = (responseData?.data?.pageNum)! + 1
                    
                    let array = NSMutableArray()
                    array.addObjects(from: self.finishModel)
                    array.addObjects(from: (responseData?.data?.list)!)
                    self.finishModel = array as! [MineReservationDataModel]
                    finishedCallback(true)
                }
            }) { (error) in
            }
        }else{
             finishedCallback(false)
        }
    }
    
    
    lazy var expiredModel : [MineReservationDataModel] = [MineReservationDataModel]()
    var expiredPages = 0
    var expiredPageNum = 0
    func loadExpiredSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ hasData:Bool) -> ()) {
        if expiredPageNum <= expiredPages {
            NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
                let responseData = Mapper<MineReservationModel>().map(JSONObject: json)
                if let code = responseData?.code {
                    guard  100 == code else {
                        SVProgressHUD.showInfo(withStatus: responseData?.message)
                        return
                    }
                    if showIndicator {
                        SVProgressHUD.showSuccess(withStatus: responseData?.message)
                    }
                    
                    self.expiredPages = (responseData?.data?.pages)!
                    //当前已经加载了一条 所以在原来基础上+1
                    self.expiredPageNum = (responseData?.data?.pageNum)! + 1
                    
                    let array = NSMutableArray()
                    array.addObjects(from: self.expiredModel)
                    array.addObjects(from: (responseData?.data?.list)!)
                    self.expiredModel = array as! [MineReservationDataModel]
                    finishedCallback(true)
                }
            }) { (error) in
            }
        }else{
            finishedCallback(false)
        }
    }
    
}
