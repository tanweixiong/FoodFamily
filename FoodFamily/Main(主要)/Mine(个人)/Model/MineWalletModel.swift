//
//  MineWalletModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/27.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineWalletDataModel: Mappable {
    var contact: String?
    var createTime: String?
    var detailPrice: NSNumber?
    var detailRemark: String?
    var detailType: NSNumber?
    var orderType:NSNumber?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        contact        <- map["contact"]
        createTime     <- map["createTime"]
        detailPrice    <- map["detailPrice"]
        detailRemark   <- map["detailRemark"]
        detailType     <- map["detailType"]
        orderType      <- map["orderType"]
    }
}

class MineWalletPriceModel: Mappable {
    var price: NSNumber?
    var type: String?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        price        <- map["price"]
        type         <- map["type"]
    }
}

class MineWalletDetaiListModel: Mappable {
    var detaiList: [MineWalletDataModel]?
    var wallet: MineWalletPriceModel?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        detaiList        <- map["detaiList"]
        wallet       <- map["wallet"]
    }
}

class MineWalletModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: MineWalletDetaiListModel?
    
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
