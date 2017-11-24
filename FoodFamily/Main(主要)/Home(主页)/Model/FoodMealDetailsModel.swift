//
//  FoodMealDetailsModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/24.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

class FoodMealDetailsDataModel: Mappable {
    var mealId: NSNumber?
    var mealImgDetail: String?
    var mealIntroduction: String?
    var mealMarketPrice: NSNumber?
    var mealPrice: NSNumber?

    
    required init?(map: Map) {
        
    }
    
    required init?() {
        mealId = 0
        mealImgDetail = "--"
        mealIntroduction = "--"
        mealMarketPrice = 0
        mealPrice = 0

    }
    
    func mapping(map: Map) {
        mealId              <- map["mealId"]
        mealImgDetail       <- map["mealImgDetail"]
        mealIntroduction    <- map["mealIntroduction"]
        mealMarketPrice     <- map["mealMarketPrice"]
        mealPrice           <- map["mealPrice"]
    }
}

class FoodMealDetailsModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: FoodMealDetailsDataModel?
    
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
