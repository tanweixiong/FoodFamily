//
//  CrowdfundingPayCouponsModel.swift
//  FoodFamily
//
//  Created by tam on 2017/12/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class CrowdfundingPayCouponsDataModel: Mappable {
    var count: NSNumber?
    var crowdId: NSNumber?
    var data:String?
    var id:NSNumber?
    var price:NSNumber?
    var total:NSNumber?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        count        <- map["count"]
        crowdId      <- map["crowdId"]
        data         <- map["data"]
        id           <- map["id"]
        price        <- map["price"]
        total        <- map["total"]
    }
}

class CrowdfundingPayCouponsModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: [CrowdfundingPayCouponsDataModel]?
    
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

