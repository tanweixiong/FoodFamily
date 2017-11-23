//
//  RecommendModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/20.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RecommendFoodDataModel: Mappable {
    var createDate: String?
    var flag: NSNumber?
    var foodImg: String?
    var foodName: String?
    var id: NSNumber?
    var storeId: NSNumber?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        createDate                <- map["createDate"]
        flag                      <- map["flag"]
        foodImg                   <- map["foodImg"]
        foodName                  <- map["foodName"]
        id                        <- map["id"]
        storeId                   <- map["storeId"]
    }
}

class RecommendMealDataModel: Mappable {
    var cycle: String?
    var id: NSNumber?
    var marketPrice: NSNumber?
    var mealEndDate: NSNumber?
    var mealImgDetail: String?
    var mealIntroduction: String?
    var mealStartDate: NSNumber?
    var mealType: NSNumber?
    var price: NSNumber?
    var remark: String?
    var sale: NSNumber?
    var storeId: NSNumber?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        cycle                   <- map["cycle"]
        id                      <- map["id"]
        marketPrice             <- map["marketPrice"]
        mealEndDate             <- map["mealEndDate"]
        mealImgDetail           <- map["mealImgDetail"]
        mealIntroduction        <- map["mealIntroduction"]
        mealStartDate           <- map["mealStartDate"]
        mealType                <- map["mealType"]
        price                   <- map["price"]
        remark                  <- map["remark"]
        sale                    <- map["sale"]
        storeId                 <- map["storeId"]
    }
}

class RecommendVoucherDataModel: Mappable {
    var content: String?
    var price: NSNumber?
    var voucherId: NSNumber?
    var vouPrice: NSNumber?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        content          <- map["content"]
        price            <- map["price"]
        voucherId        <- map["voucherId"]
        vouPrice         <- map["vouPrice"]
    }
}


class RecommendDataModel: Mappable {
    var address: String?
    var coverPic: NSArray?
    var detailedAddress: String?
    var isCollection: NSNumber?
    var logo: String?
    var message: String?
    var perPay: AnyObject?
    var storeName: String?
    var storeType: String?
    var food: [RecommendFoodDataModel]?
    var meal: [RecommendMealDataModel]?
    var voucher: [RecommendVoucherDataModel]?
    
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
        food                   <- map["food"]
        meal                   <- map["meal"]
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
