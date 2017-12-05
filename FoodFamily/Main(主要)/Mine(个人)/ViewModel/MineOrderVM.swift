//
//  MineOrderVM.swift
//  FoodFamily
//
//  Created by tam on 2017/11/24.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class MineOrderVM: NSObject {
    //一般请求的方法 不带模型数组
    lazy var allOrderModel : [MineOrderDataModel] = [MineOrderDataModel]()
    var allPages = 0
    var allPageNum = 0
    func loadAllOrderSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ hasData: Bool) -> ()) {
         if allPageNum <= allPages {
            NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
                print(json)
                let responseData = Mapper<MineOrderModel>().map(JSONObject: json)
                if let code = responseData?.code {
                    guard  100 == code else {
                        SVProgressHUD.showInfo(withStatus: responseData?.message)
                        return
                    }
                    if showIndicator {
                        SVProgressHUD.showSuccess(withStatus: responseData?.message)
                    }
                    self.allPages = (responseData?.data?.pages)!
                    //当前已经加载了一条 所以在原来基础上+1
                    self.allPageNum = (responseData?.data?.pageNum)! + 1
                    
                    let array = NSMutableArray()
                    array.addObjects(from: self.allOrderModel)
                    array.addObjects(from: (responseData?.data?.list)!)
                    self.allOrderModel = array as! [MineOrderDataModel]
                    
                    finishedCallback(true)
                }
            }) { (error) in
            }
         }else{
             finishedCallback(false)
        }
    }
    
    lazy var unpaidModel : [MineOrderDataModel] = [MineOrderDataModel]()
    var unpaidPages = 0
    var unpaidPageNum = 0
    func loadUnpaidSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ hasData: Bool) -> ()) {
        if unpaidPageNum <= unpaidPages {
            NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
                print(json)
                let responseData = Mapper<MineOrderModel>().map(JSONObject: json)
                if let code = responseData?.code {
                    guard  100 == code else {
                        SVProgressHUD.showInfo(withStatus: responseData?.message)
                        return
                    }
                    if showIndicator {
                        SVProgressHUD.showSuccess(withStatus: responseData?.message)
                    }
                    self.unpaidPages = (responseData?.data?.pages)!
                    //当前已经加载了一条 所以在原来基础上+1
                    self.unpaidPageNum = (responseData?.data?.pageNum)! + 1
                    
                    let array = NSMutableArray()
                    array.addObjects(from: self.unpaidModel)
                    array.addObjects(from: (responseData?.data?.list)!)
                    self.unpaidModel = array as! [MineOrderDataModel]
            
                    finishedCallback(true)
                }
            }) { (error) in
            }
        }else{
            finishedCallback(false)
        }
    }
    
    lazy var finishPayModel : [MineOrderDataModel] = [MineOrderDataModel]()
    var finishPayPages = 0
    var finishPayPageNum = 0
    func loadFinishPaySuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ hasData: Bool) -> ()) {
          if finishPayPageNum <= finishPayPages {
            NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
                print(json)
                let responseData = Mapper<MineOrderModel>().map(JSONObject: json)
                if let code = responseData?.code {
                    guard  100 == code else {
                        SVProgressHUD.showInfo(withStatus: responseData?.message)
                        return
                    }
                    self.finishPayPages = (responseData?.data?.pages)!
                    //当前已经加载了一条 所以在原来基础上+1
                    self.finishPayPageNum = (responseData?.data?.pageNum)! + 1
                    
                    let array = NSMutableArray()
                    array.addObjects(from: self.finishPayModel)
                    array.addObjects(from: (responseData?.data?.list)!)
                    self.finishPayModel = array as! [MineOrderDataModel]
 
                    finishedCallback(true)
                }
            }) { (error) in
            }
          }else{
             finishedCallback(false)
        
          }
    }
    
}
