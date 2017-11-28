//
//  FoodMerchantsModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/28.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodMerchantsDataModel: Mappable {
    var area: String?
    var businessHoursEnd: String?
    var businessHoursStart: String?
    var certificationId: NSNumber?
    var city: String?
    var coverPic: String?
    var distance: NSNumber?
    var id: NSNumber?
    var latitude: NSNumber?
    var logo: String?
    var longitude: NSNumber?
    var message: String?
    var perPay: NSNumber?
    var province: String?
    var storeIntroduce: String?
    var storeName: String?
    var storePhoneId: NSNumber?
    var storeType: NSNumber?
    var street: String?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        area                 <- map["area"]
        businessHoursEnd     <- map["businessHoursEnd"]
        businessHoursStart   <- map["businessHoursStart"]
        certificationId      <- map["certificationId"]
        city                 <- map["city"]
        coverPic             <- map["coverPic"]
        distance             <- map["distance"]
        id                   <- map["id"]
        latitude             <- map["latitude"]
        logo                 <- map["logo"]
        longitude            <- map["longitude"]
        message              <- map["message"]
        perPay               <- map["perPay"]
        province             <- map["province"]
        storeIntroduce       <- map["storeIntroduce"]
        storeName            <- map["storeName"]
        storePhoneId         <- map["storePhoneId"]
        storeType            <- map["storeType"]
        street               <- map["street"]
    }
}

class FoodMerchantsModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: [FoodMerchantsDataModel]?
    
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
