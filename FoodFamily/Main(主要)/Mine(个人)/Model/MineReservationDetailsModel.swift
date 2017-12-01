//
//  MineReservationDetailsModel.swift
//  FoodFamily
//
//  Created by tam on 2017/12/1.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineReservationDetailsDataModel: Mappable {
    var logo: String?
    var storeName: String?
    var expired: String?
    var phone: String?
    var appointmentNum: String?
    var appointmentTime: String?
    var orderNo: String?
    var orderTime: String?
    var payType: String?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        logo = ""
        storeName = ""
        expired = ""
        phone = ""
        appointmentNum = ""
        appointmentTime = ""
        orderNo = ""
        orderTime = ""
        payType = ""
    }
    
    func mapping(map: Map) {
        logo        <- map["logo"]
        storeName   <- map["storeName"]
        expired     <- map["expired"]
        phone       <- map["phone"]
        appointmentNum      <- map["appointmentNum"]
        appointmentTime     <- map["appointmentTime"]
        orderNo             <- map["orderNo"]
        orderTime           <- map["orderTime"]
        payType             <- map["payType"]
    }
}

class MineReservationDetailsModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: MineReservationDetailsDataModel?
    
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
