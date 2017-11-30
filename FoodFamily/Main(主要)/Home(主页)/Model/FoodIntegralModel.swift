//
//  FoodIntegralModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/29.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodIntegralDataModel: Mappable {
    var NoChangeEcPrice: NSNumber?
    var canDe: NSNumber?
    var canPay: NSNumber?
    var ECPrice: NSNumber?
    var deduction: NSNumber?
    var totalPrice: NSNumber?
    var price: NSNumber?
    var changeEcPrice: NSNumber?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        NoChangeEcPrice = 0
        canDe = 0
        canPay = 0
        ECPrice = 0
        deduction = 0
        totalPrice = 0
        price = 0
        changeEcPrice = 0
    }
    
    func mapping(map: Map) {
        NoChangeEcPrice   <- map["NoChangeEcPrice"]
        canDe             <- map["canDe"]
        canPay            <- map["canPay"]
        ECPrice           <- map["ECPrice"]
        deduction         <- map["deduction"]
        totalPrice        <- map["totalPrice"]
        price             <- map["price"]
        changeEcPrice     <- map["changeEcPrice"]
    }
}

class FoodIntegralModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: FoodIntegralDataModel?
    
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
