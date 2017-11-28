//
//  MineOrderModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/24.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineOrderDataModel: Mappable {
    var logo: String?
    var orderNo: String?
    var orderStatus: NSNumber?
    var orderTime: String?
    var payType: NSNumber?
    var storeName: String?
    var totalPrice: NSNumber?
    var type: NSNumber?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        logo          <- map["logo"]
        orderNo       <- map["orderNo"]
        orderStatus   <- map["orderStatus"]
        orderTime     <- map["orderTime"]
        payType       <- map["payType"]
        storeName     <- map["storeName"]
        totalPrice    <- map["totalPrice"]
        type          <- map["type"]
    }
}

class MineOrderListModel: Mappable {
    var list: [MineOrderDataModel]?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        list        <- map["list"]
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
