//
//  HomeModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/20.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class StoreListModel: Mappable {
    var id: AnyObject?
    var storeName: String?
    var storeType: String?
    var businessHoursStart: String?
    var businessHoursEnd: String?
    var province: String?
    var city: String?
    var area: String?
    var street: String?
    var storeIntroduce: String?
    var certificationId: String?
    var storePhoneId: String?
    var logo: String?
    var perPay: AnyObject?
    var longitude: String?
    var latitude: String?
    var message: String?
    var coverPic: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id      <- map["id"]
        storeName     <- map["storeName"]
        storeType      <- map["storeType"]
        businessHoursStart     <- map["businessHoursStart"]
        businessHoursEnd      <- map["businessHoursEnd"]
        province      <- map["province"]
        city     <- map["city"]
        area      <- map["area"]
        street     <- map["street"]
        storeIntroduce      <- map["storeIntroduce"]
        certificationId     <- map["certificationId"]
        storePhoneId     <- map["storePhoneId"]
        logo     <- map["logo"]
        perPay     <- map["perPay"]
        longitude     <- map["longitude"]
        latitude     <- map["latitude"]
        message     <- map["message"]
        coverPic     <- map["coverPic"]
    }
}

class BannerListModel: Mappable {
    var id: String?
    var bannerImg: String?
    var returnUrl: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id      <- map["id"]
        bannerImg     <- map["bannerImg"]
        returnUrl     <- map["returnUrl"]
    }
}

class CategoryListModel: Mappable {
    var id: String?
    var categoryName: String?
    var depth: String?
    var pid: String?
    var flag: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id      <- map["id"]
        categoryName     <- map["categoryName"]
        depth     <- map["depth"]
        pid      <- map["pid"]
        flag     <- map["flag"]
    }
}


class HomeListModel: Mappable {
    var storeList: StoreListModel?
    var bannerList: [BannerListModel]?
    var categoryList: [CategoryListModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        storeList      <- map["storeList"]
        bannerList     <- map["bannerList"]
        categoryList   <- map["categoryList"]
    }
}

class HomeModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: HomeListModel?
    
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
