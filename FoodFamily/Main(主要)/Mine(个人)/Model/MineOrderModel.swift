//
//  MineOrderModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/24.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineOrderDataModel: Mappable {
    var appointmentNum: NSNumber?
    var appointmentTime: String?
    var buyId: NSNumber?
    var finalyTime: String?
    var flag: NSNumber?
    var id: NSNumber?
    var mealId: NSNumber?
    var mealName: String?
    var orderNo: NSNumber?
    var orderPassword: NSNumber?
    var orderStatus: NSNumber?
    var orderTime: String?
    var payStatus: NSNumber?
    var payType: NSNumber?
    var paymentAmount: NSNumber?
    var storeId: NSNumber?
    var totalNum: NSNumber?
    var totalPrice: NSNumber?
    var type: NSNumber?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        appointmentNum        <- map["appointmentNum"]
        appointmentTime       <- map["appointmentTime"]
        buyId                 <- map["buyId"]
        finalyTime            <- map["finalyTime"]
        flag                  <- map["flag"]
        id                    <- map["id"]
        mealId                <- map["mealId"]
        mealName              <- map["mealName"]
        orderNo               <- map["orderNo"]
        orderPassword         <- map["orderPassword"]
        orderStatus           <- map["orderStatus"]
        orderTime             <- map["orderTime"]
        payStatus             <- map["payStatus"]
        payType               <- map["payType"]
        paymentAmount         <- map["paymentAmount"]
        storeId               <- map["storeId"]
        totalNum              <- map["totalNum"]
        totalPrice            <- map["totalPrice"]
        type                  <- map["type"]
    }
}

class MineOrderListModel: Mappable {
    var orderList: [MineOrderDataModel]?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        orderList        <- map["orderList"]
    }
}

class MineOrderModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: MineOrderListModel?
    
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
