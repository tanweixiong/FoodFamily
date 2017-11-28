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
    var storeId: NSNumber?
    var storeLogo: String?
    var createTime: String?
    var name: String?
    var address: String?
    var orderNo: NSNumber?
    var payType: NSNumber?
    
    var totalPrice: NSNumber?
    var paymentAmount: NSNumber?
    var integral: NSNumber?
    var orderStatus: NSNumber? //1未支付 2已支付 5未评价 6已评价 7交易完成 8交易关闭
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        storeId        <- map["storeId"]
        storeLogo      <- map["storeLogo"]
        createTime     <- map["createTime"]
        name           <- map["name"]
        address        <- map["address"]
        orderNo        <- map["orderNo"]
        payType        <- map["payType"]
        
        totalPrice     <- map["totalPrice"]
        paymentAmount  <- map["paymentAmount"]
        integral       <- map["integral"]
        orderStatus    <- map["orderStatus"]
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
