//
//  LoginModel.swift
//  FoodFamily
//
//  Created by tam on 2017/11/17.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class LoginUserModel: Mappable{
    
    var acount: String?
    var age: String?
    var city: String?
    var flag: String?
    var fpassword: String?
    var fpwd: String?
    var id: String?
    var lastTime: String?
    var nickname: String?
    var pice: String?
    var province: String?
    var recommend: String?
    var sex: String?
    var sign: String?
    var spassword: String?
    var spwd: String?
    var star: String?
    var storeId: String?
    var type: String?
    
    required init?(map: Map) {
        
    }
    
    required init?() {

    }
    
    func mapping(map: Map) {
        acount <- map["acount"]
        age  <- map["age"]
        city <- map["city"]
        flag <- map["flag"]
        fpassword <- map["fpassword"]
        fpwd  <- map["fpwd"]
         id <- map["id"]
        lastTime <- map["lastTime"]
        nickname <- map["nickname"]
        pice <- map["pice"]
        province <- map["province"]
        recommend <- map["recommend"]
        sex <- map["sex"]
        sign <- map["sign"]
        spassword <- map["spassword"]
        spwd <- map["spwd"]
        star <- map["star"]
        storeId <- map["storeId"]
        type <- map["type"]
        
    }
}

class LoginDataModel: Mappable {
    
    var user: LoginUserModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        user        <- map["user"]
    }
}


class LoginModel: Mappable {
    var code: NSNumber?
    var message: String?
    var data: LoginDataModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code        <- map["code"]
        message     <- map["message"]
        data        <- map["data"]
    }
}
