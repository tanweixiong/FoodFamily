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
    lazy var scoreModel : MineScoresListModel = MineScoresListModel()!
    lazy var allModel : [MineScoresDataModel] = [MineScoresDataModel]()
    lazy var incomeModel : [MineScoresDataModel] = [MineScoresDataModel]()
    lazy var expenditureModel : [MineScoresDataModel] = [MineScoresDataModel]()
    
    var allPages = 0
    var allPageNum = 0
    func loadAllSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ hasData:Bool) -> ()) {
        if allPageNum <= allPages {
            NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
                let responseData = Mapper<MineScoresModel>().map(JSONObject: json)
                if let code = responseData?.code {
                    guard  100 == code else {
                        SVProgressHUD.showInfo(withStatus: responseData?.message)
                        return
                    }
                    if showIndicator {
                        SVProgressHUD.showSuccess(withStatus: responseData?.message)
                    }
                    self.scoreModel = (responseData?.data)!
                    
                    self.allPages = (responseData?.data?.pages)!
                    //当前已经加载了一条 所以在原来基础上+1
                    self.allPageNum = (responseData?.data?.pageNum)! + 1
                    
                    let array = NSMutableArray()
                    array.addObjects(from: self.allModel)
                    array.addObjects(from: (responseData?.data?.detaiList)!)
                    self.allModel = array as! [MineScoresDataModel]
                    finishedCallback(true)
                }
            }) { (error) in
            }
        }else{
            finishedCallback(false)
        }
    }
    
    var incomePages = 0
    var incomePageNum = 0
    func loadIncomeSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ hasData:Bool) -> ()) {
        if incomePageNum <= incomePages {
            NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
                let responseData = Mapper<MineScoresModel>().map(JSONObject: json)
                if let code = responseData?.code {
                    guard  100 == code else {
                        SVProgressHUD.showInfo(withStatus: responseData?.message)
                        return
                    }
                    if showIndicator {
                        SVProgressHUD.showSuccess(withStatus: responseData?.message)
                    }
                    self.incomePages = (responseData?.data?.pages)!
                    //当前已经加载了一条 所以在原来基础上+1
                    self.incomePageNum = (responseData?.data?.pageNum)! + 1
                    let array = NSMutableArray()
                    array.addObjects(from: self.incomeModel)
                    array.addObjects(from: (responseData?.data?.detaiList)!)
                    self.incomeModel = array as! [MineScoresDataModel]
                    finishedCallback(true)
                }
            }) { (error) in
            }
        }else{
            finishedCallback(false)
        }
    }
    
    var expenditurePages = 0
    var expenditurePageNum = 0
    func loadExpenditureSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ hasData:Bool) -> ()) {
        if expenditurePageNum <= expenditurePages {
            NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
                let responseData = Mapper<MineScoresModel>().map(JSONObject: json)
                if let code = responseData?.code {
                    guard  100 == code else {
                        SVProgressHUD.showInfo(withStatus: responseData?.message)
                        return
                    }
                    if showIndicator {
                        SVProgressHUD.showSuccess(withStatus: responseData?.message)
                    }
                    
                    self.expenditurePages = (responseData?.data?.pages)!
                    //当前已经加载了一条 所以在原来基础上+1
                    self.expenditurePageNum = (responseData?.data?.pageNum)! + 1
                    
                    let array = NSMutableArray()
                    array.addObjects(from: self.expenditureModel)
                    array.addObjects(from: (responseData?.data?.detaiList)!)
                    self.expenditureModel = array as! [MineScoresDataModel]
                    finishedCallback(true)
                }
            }) { (error) in
            }
        }else{
             finishedCallback(false)
        }
        
    }
    
}
