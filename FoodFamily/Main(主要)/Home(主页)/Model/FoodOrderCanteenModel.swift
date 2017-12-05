//
//  FoodVoucherOrderDetailsModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/28.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

//代金券详情
class FoodOrderCanteenListModel: Mappable {
    var address: String?
    var createTime: String?
    var name: String?
    var orderNo: String?
    var orderStatus: NSNumber? //1未支付 2已支付 5未评价 6已评价 7交易完成 8交易关闭
    var payType: NSNumber?
    var remark: String?
    var storeId: NSNumber?
    var storeLogo: String?
    var totalPrice: NSNumber?

    required init?(map: Map) {
        
    }
    
    required init?() {
    }
    
    func mapping(map: Map) {
        address        <- map["address"]
        createTime     <- map["createTime"]
        name           <- map["name"]
        orderNo        <- map["orderNo"]
        orderStatus    <- map["orderStatus"]
        payType        <- map["payType"]
        remark         <- map["remark"]
        
        storeId        <- map["storeId"]
        storeLogo      <- map["storeLogo"]
        totalPrice     <- map["totalPrice"]
    }
}



class FoodOrderCanteenModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: FoodOrderCanteenListModel?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        code        <- map["code"]
        message     <- map["message"]
        data        <- map["data"]
    }
}
