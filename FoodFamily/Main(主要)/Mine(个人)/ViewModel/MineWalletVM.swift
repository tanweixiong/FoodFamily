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
    func loadSuccessfullyReturnedData(requestType: HTTPMethod, URLString : String, parameters : [String : Any]? = nil, showIndicator: Bool,finishedCallback : @escaping () -> ()) {
        NetWorkTool.request(requestType: requestType, URLString:URLString, parameters: parameters, showIndicator: true, success: { (json) in
            print(json)
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
                if responseData?.data?.detaiList?.count != 0 {
                    let array = NSMutableArray()
                    array.addObjects(from: self.walletModel)
                    array.addObjects(from: (responseData?.data?.detaiList)!)
                    self.walletModel = array as! [MineWalletDataModel]
                }
                finishedCallback()
            }
        }) { (error) in
        }
    }
}
