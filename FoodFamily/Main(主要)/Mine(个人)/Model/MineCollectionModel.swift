//
//  MineCollectionModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/24.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineCollectionDataModel: Mappable {
    var logo: String?
    var storeId: NSNumber?
    var storeName: String?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        logo        <- map["logo"]
        storeId     <- map["storeId"]
        storeName   <- map["storeName"]
    }
}

class MineCollectionListModel: Mappable {
    var list: [MineCollectionDataModel]?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        list        <- map["list"]
    }
}


class MineCollectionModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: MineCollectionListModel?
    
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
