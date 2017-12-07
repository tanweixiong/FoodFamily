//
//  CrowdfundingModel.swift
//  FoodFamily
//
//  Created by tam on 2017/12/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class CrowdfundingDataModel: Mappable {
    var address: String?
    var img: String?
    var percent: NSNumber?
    var pointPrice: NSNumber?
    var projectId: NSNumber?
    var projectName: String?
    var startPrice: NSNumber?
    var state: NSNumber?
    var totalPrice: NSNumber?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        address        <- map["address"]
        img            <- map["img"]
        percent        <- map["percent"]
        pointPrice     <- map["pointPrice"]
        projectId      <- map["projectId"]
        projectName    <- map["projectName"]
        startPrice     <- map["startPrice"]
        state          <- map["state"]
        totalPrice     <- map["totalPrice"]
    }
}

class CrowdfundingListModel: Mappable {
    var list: [CrowdfundingDataModel]?
    var pageNum: Int?
    var pages: Int?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        list        <- map["list"]
        pageNum     <- map["pageNum"]
        pages       <- map["pages"]
    }
}

class CrowdfundingModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: CrowdfundingListModel?
    
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
