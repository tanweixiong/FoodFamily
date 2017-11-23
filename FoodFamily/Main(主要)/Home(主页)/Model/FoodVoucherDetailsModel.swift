//
//  FoodPurchaseNotesModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/23.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodVoucherDataModel: Mappable {
    var content: String?
    var createtime: String?
    var flag: NSNumber?
    var id: NSNumber?
    var lastNum: NSNumber?
    var name: String?
    var needKnow: String?
    var price: NSNumber?
    var remark: String?
    var sellNum: NSNumber?
    var startTime: String?
    var endTime: String?
    var storeId: NSNumber?
    var totalNum: NSNumber?
    var vouPrice: NSNumber?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        content                 <- map["content"]
        createtime            <- map["createtime"]
        endTime              <- map["endTime"]
        flag             <- map["flag"]
        id           <- map["id"]
        lastNum         <- map["lastNum"]
        name         <- map["name"]
        needKnow         <- map["needKnow"]
        price         <- map["price"]
        remark         <- map["remark"]
        sellNum         <- map["sellNum"]
        startTime         <- map["startTime"]
        storeId         <- map["storeId"]
        totalNum         <- map["totalNum"]
        vouPrice         <- map["vouPrice"]
    }
}

class FoodVoucherDetailsModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: FoodVoucherDataModel?
    
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
