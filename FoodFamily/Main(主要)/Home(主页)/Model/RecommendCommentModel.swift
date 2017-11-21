//
//  RecommendCommentModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/21.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RecommendCommentListDataModel: Mappable {
    var createTime: String?
    var context: String?
    var assessId: NSNumber?
    var assessPic: NSArray?
    var nickname: String?
    var userHead: String?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        createTime        <- map["createTime"]
        context           <- map["context"]
        assessId          <- map["assessId"]
        assessPic         <- map["assessPic"]
        nickname          <- map["nickname"]
        userHead          <- map["userHead"]
    }
}

class RecommendCommentListModel: Mappable {
    var list: [RecommendCommentListDataModel]?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        list        <- map["list"]
    }
}

class RecommendCommentModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: RecommendCommentListModel?
    
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
