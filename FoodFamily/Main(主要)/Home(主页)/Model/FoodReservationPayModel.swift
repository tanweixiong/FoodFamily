//
//  FoodReservationPayModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/23.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodPayDataModel: Mappable {
    var orderNo: String?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        orderNo        <- map["orderNo"]
    }
}

class FoodReservationPayModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: FoodPayDataModel?
    
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
