//
//  MineReservationModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/30.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineReservationDataModel: Mappable {
    var orderNo: NSNumber?
    var logo: String?
    var storeName: String?
    var appointmentTime: String?

    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        orderNo                <- map["orderNo"]
        logo                   <- map["logo"]
        storeName              <- map["storeName"]
        appointmentTime        <- map["appointmentTime"]
    }
}


class MineReservationModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: [MineReservationDataModel]?
    
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
