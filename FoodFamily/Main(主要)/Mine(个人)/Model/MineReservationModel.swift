//
//  MineReservationModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/30.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineReservationDataModel: Mappable {
    var orderNo: String?
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

class MineReservationListModel: Mappable {
    var list: [MineReservationDataModel]?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        list                <- map["list"]
    }
}

class MineReservationModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: MineReservationListModel?
    
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
