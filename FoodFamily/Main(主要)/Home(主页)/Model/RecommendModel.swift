//
//  RecommendModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/20.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RecommendFoodDataModel: Mappable {
    var foodId: NSNumber?
    var foodImg: String?
    var foodName: String?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        foodId                    <- map["foodId"]
        foodImg                   <- map["foodImg"]
        foodName                  <- map["foodName"]
    }
}

class RecommendMealDataModel: Mappable {
    var mealId: NSNumber?
    var mealImgDetail: String?
    var mealIntroduction: String?
    var mealMarketPrice: NSNumber?
    var mealPrice: NSNumber?
    var remark: String?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        mealId                  <- map["mealId"]
        mealImgDetail           <- map["mealImgDetail"]
        mealIntroduction        <- map["mealIntroduction"]
        mealMarketPrice         <- map["mealMarketPrice"]
        mealPrice               <- map["mealPrice"]
        remark                  <- map["remark"]
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


class RecommendVouchersModel: Mappable {
    var voucher: RecommendVoucherDataModel?
    required init?(map: Map) {
    }
    required init?() {
    }
    func mapping(map: Map) {
      voucher     <- map["voucher"]
    }
}

//class RecommendFoodsModel: Mappable {
//    var food: RecommendFoodDataModel?
//    required init?(map: Map) {
//    }
//    required init?() {
//    }
//    func mapping(map: Map) {
//        food     <- map["food"]
//    }
//}

class RecommendMealsModel: Mappable {
    var meal: RecommendMealDataModel?
    required init?(map: Map) {
    }
    required init?() {
    }
    func mapping(map: Map) {
        meal     <- map["meal"]
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
    var reserPrice:NSNumber?
    var foodList: [RecommendFoodDataModel]?
    var mealList: [RecommendMealsModel]?
    var voucherList: [RecommendVouchersModel]?
    var storeId: NSNumber?
    
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
        storeType              <- map["storeType"]
        foodList               <- map["foodList"]
        mealList               <- map["mealList"]
        voucherList            <- map["voucherList"]
        reserPrice             <- map["reserPrice"]
        storeId                <- map["storeId"]
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
