//
//  MineCollectionVM.swift
//  FoodFamily
//
//  Created by tam on 2017/11/24.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class MineCollectionVM: NSObject {
    //一般请求的方法 不带模型数组
    lazy var collectionListModel : [MineCollectionDataModel] = [MineCollectionDataModel]()
    var pages = 0
    var pageNum = 0
    func loadSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ isData:Bool) -> ()) {
        if pageNum <= pages {
            NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
                let responseData = Mapper<MineCollectionModel>().map(JSONObject: json)
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
                    array.addObjects(from: self.collectionListModel)
                    array.addObjects(from: (responseData?.data?.list)!)
                    self.collectionListModel = array as! [MineCollectionDataModel]
                    finishedCallback(true)
                }
            }) { (error) in
            }
        }else{
              finishedCallback(false)
        }
    }
    
    func loadSuccessfullyCollectionReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping () -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            let responseData = Mapper<MineCollectionModel>().map(JSONObject: json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.message)
                    return
                }
                if showIndicator {
                    SVProgressHUD.showSuccess(withStatus: responseData?.message)
                }
                finishedCallback()
            }
        }) { (error) in
        }
    }
    
}
