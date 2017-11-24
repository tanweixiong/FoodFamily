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
    var endTime: String?
    var id: NSNumber?
    var name: String?
    var needKnow: String?
    var price: NSNumber?
    var startTime: String?
    var useTime: String?
    var vouPrice: NSNumber?

    
    required init?(map: Map) {
        
    }
    
    required init?() {
         content = "--"
         id = 0
         name = "--"
         needKnow = "--"
         price = 0
         startTime = "--"
         endTime = "--"
         useTime = "--"
         vouPrice = 0
    }
    
    func mapping(map: Map) {
        content              <- map["content"]
        id                   <- map["id"]
        name                 <- map["name"]
        needKnow             <- map["needKnow"]
        price                <- map["price"]
        startTime            <- map["startTime"]
        endTime              <- map["endTime"]
        useTime              <- map["useTime"]
        vouPrice             <- map["vouPrice"]
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
