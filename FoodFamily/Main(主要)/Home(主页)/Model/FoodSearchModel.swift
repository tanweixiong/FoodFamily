//
//  FoodSearchModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/28.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodSearchDataModel: Mappable {
    var address: String?
    var coverPic: String?
    var distance: NSNumber?
    var id: NSNumber?
    var logo: String?
    var perPay: NSNumber?
    var storeName: String?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        address        <- map["address"]
        coverPic       <- map["coverPic"]
        distance       <- map["distance"]
        id             <- map["id"]
        logo           <- map["logo"]
        perPay         <- map["perPay"]
        storeName      <- map["storeName"]
    }
}

class FoodSearchListModel: Mappable {
    var list: [FoodSearchDataModel]?
    var pages: Int?
    var pageNum: Int?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        list        <- map["list"]
        pages       <- map["pages"]
        pageNum     <- map["pageNum"]
    }
}

class FoodSearchModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: FoodSearchListModel?
    
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
