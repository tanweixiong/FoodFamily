//
//  MineWalletVM.swift
//  FoodFamily
//
//  Created by tam on 2017/11/27.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class MineWalletVM: NSObject {
    lazy var walletModel : [MineWalletDataModel] = [MineWalletDataModel]()
    lazy var walletPirceModel : MineWalletPriceModel = MineWalletPriceModel()!
    var pages = 0
    var pageNum = 0
    func loadSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping (_ hasData:Bool) -> ()) {
        if pageNum <= pages {
            NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
                let responseData = Mapper<MineWalletModel>().map(JSONObject: json)
                if let code = responseData?.code {
                    guard  100 == code else {
                        SVProgressHUD.showInfo(withStatus: responseData?.message)
                        return
                    }
                    if showIndicator {
                        SVProgressHUD.showSuccess(withStatus: responseData?.message)
                    }
                    self.walletPirceModel =  (responseData?.data?.wallet)!
                    self.pages = (responseData?.data?.pages)!
                    //当前已经加载了一条 所以在原来基础上+1
                    self.pageNum = (responseData?.data?.pageNum)! + 1
                    let array = NSMutableArray()
                    array.addObjects(from: self.walletModel)
                    array.addObjects(from: (responseData?.data?.detaiList)!)
                    self.walletModel = array as! [MineWalletDataModel]
                    finishedCallback(true)
                }
            }) { (error) in
            }
        }else{
            finishedCallback(false)
        }
    }
}
