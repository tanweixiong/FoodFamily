//
//  MyScoresVM.swift
//  FoodFamily
//
//  Created by tam on 2017/12/1.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

enum MineScoresStatus {
    case allStatus
    case incomeStatus
    case expenditureStatus
}

class MineScoresVM: NSObject {
    lazy var allModel : [MineScoresDataModel] = [MineScoresDataModel]()
    lazy var incomeModel : [MineScoresDataModel] = [MineScoresDataModel]()
    lazy var expenditureModel : [MineScoresDataModel] = [MineScoresDataModel]()
    
    func loadAllSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ hasData:Bool) -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            print(json)
            let responseData = Mapper<MineScoresModel>().map(JSONObject: json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.message)
                    return
                }
                if showIndicator {
                    SVProgressHUD.showSuccess(withStatus: responseData?.message)
                }

                if responseData?.data?.detaiList?.count != 0 {
                    let array = NSMutableArray()
                    array.addObjects(from: self.allModel)
                    array.addObjects(from: (responseData?.data?.detaiList)!)
                    self.allModel = array as! [MineScoresDataModel]
                    finishedCallback(true)
                }else{
                    finishedCallback(false)
                }
            }
        }) { (error) in
        }
    }
    
    func loadIncomeSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ hasData:Bool) -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            print(json)
            let responseData = Mapper<MineScoresModel>().map(JSONObject: json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.message)
                    return
                }
                if showIndicator {
                    SVProgressHUD.showSuccess(withStatus: responseData?.message)
                }
                if responseData?.data?.detaiList?.count != 0 {
                    let array = NSMutableArray()
                    array.addObjects(from: self.incomeModel)
                    array.addObjects(from: (responseData?.data?.detaiList)!)
                    self.incomeModel = array as! [MineScoresDataModel]
                    finishedCallback(true)
                }else{
                    finishedCallback(false)
                }
            }
        }) { (error) in
        }
    }
    
    func loadExpenditureSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ hasData:Bool) -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            print(json)
            let responseData = Mapper<MineScoresModel>().map(JSONObject: json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.message)
                    return
                }
                if showIndicator {
                    SVProgressHUD.showSuccess(withStatus: responseData?.message)
                }
                
                if responseData?.data?.detaiList?.count != 0 {
                    let array = NSMutableArray()
                    array.addObjects(from: self.expenditureModel)
                    array.addObjects(from: (responseData?.data?.detaiList)!)
                    self.expenditureModel = array as! [MineScoresDataModel]
                    finishedCallback(true)
                }else{
                    finishedCallback(false)
                }
            }
        }) { (error) in
        }
    }
    
    
}
