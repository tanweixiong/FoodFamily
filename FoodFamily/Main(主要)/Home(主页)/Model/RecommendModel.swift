//
//  RecommendModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/20.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RecommendDataModel: Mappable {
    var address: String?
    var coverPic: NSArray?
    var detailedAddress: String?
    var isCollection: NSNumber?
    var logo: String?
    var message: String?
    var perPay: AnyObject?
    var storeName: String?
    var voucher: NSArray?
    var storeType: String?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        address                <- map["address"]
        coverPic               <- map["coverPic"]
        detailedAddress        <- map["detailedAddress"]
        isCollection           <- map["isCollection"]
        logo                   <- map["logo"]
        message                <- map["message"]
        perPay                 <- map["perPay"]
        storeName              <- map["storeName"]
        voucher                <- map["voucher"]
        storeType              <- map["storeType"]
    }
}

class RecommendModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: RecommendDataModel?
    
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
