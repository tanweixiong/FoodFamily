//
//  FoodNormalOrderDetailsModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/23.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodNormalOrderDetailsModel: Mappable {
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
