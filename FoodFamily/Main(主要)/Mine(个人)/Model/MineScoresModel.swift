//
//  MyScoresModel.swift
//  FoodFamily
//
//  Created by tam on 2017/12/1.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineScoresDataModel: Mappable {
    var price: String?
    var detailType: NSNumber?
    var createTime: String?
    var storeName: String?
    var logo: String?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        price        <- map["price"]
        detailType   <- map["detailType"]
        createTime   <- map["createTime"]
        storeName    <- map["storeName"]
        logo         <- map["logo"]

    }
}

class MineScoresPriceModel: Mappable {
    var price: NSNumber?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        price           <- map["price"]
    }
}

class MineScoresListModel: Mappable {
    var detaiList: [MineScoresDataModel]?
    var wallet : MineScoresPriceModel?
    var pages: Int?
    var pageNum: Int?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        detaiList        <- map["detaiList"]
        wallet           <- map["wallet"]
        pages       <- map["pages"]
        pageNum     <- map["pageNum"]
    }
}

class MineScoresModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: MineScoresListModel?
    
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
