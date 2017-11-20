//
//  UserInfo.swift
//  DHSWallet
//
//  Created by zhengyi on 2017/8/22.
//  Copyright © 2017年 zhengyi. All rights reserved.
//

import UIKit
import MJExtension

class UserInfo: NSObject,NSCoding {
    @objc var acount: AnyObject?
    @objc var age: AnyObject?
    @objc var city: AnyObject?
    @objc var flag: AnyObject?
    @objc var fpassword: AnyObject?
    @objc var fpwd: AnyObject?

    @objc var id: AnyObject?
    @objc var lastTime: AnyObject?

    @objc var nickname: AnyObject?
    @objc var pice: AnyObject?
    
    @objc var province: AnyObject?
    @objc var recommend: AnyObject?
    
    @objc var regTime: AnyObject?
    @objc var sex: AnyObject?
    
    @objc var sign: AnyObject?
    @objc var spassword: AnyObject?
    
    @objc var spwd: AnyObject?
    @objc var star: AnyObject?

    @objc var storeId: AnyObject?
    @objc var type: AnyObject?

    
    //构造方法
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    required override init() {
        super.init()
        acount = "" as AnyObject
        age  = "" as AnyObject
        city = "" as AnyObject
        flag = "" as AnyObject
        fpassword = "" as AnyObject
        fpwd  = "" as AnyObject
        id = "" as AnyObject
        lastTime = "" as AnyObject
        nickname = "" as AnyObject
        pice =  "" as AnyObject
        province = "" as AnyObject
        recommend = "" as AnyObject
        sex = "" as AnyObject
        sign = "" as AnyObject
        spassword = "" as AnyObject
        spwd = "" as AnyObject
        star = "" as AnyObject
        storeId = "" as AnyObject
        type = "" as AnyObject
    }
    
    //    从object解析回来
    required init(coder decoder: NSCoder) {
        self.acount = decoder.decodeObject(forKey: "acount") as AnyObject
        self.age = decoder.decodeObject(forKey: "age") as AnyObject
        self.city = decoder.decodeObject(forKey: "city") as AnyObject
        self.flag = decoder.decodeObject(forKey: "flag") as AnyObject
        self.fpassword = decoder.decodeObject(forKey: "fpassword") as AnyObject
        self.fpwd = decoder.decodeObject(forKey: "fpwd") as AnyObject
        self.id = decoder.decodeObject(forKey: "id") as AnyObject
        self.lastTime = decoder.decodeObject(forKey: "lastTime") as AnyObject
        self.nickname = decoder.decodeObject(forKey: "nickname") as AnyObject
        self.pice = decoder.decodeObject(forKey: "pice") as AnyObject
        self.province = decoder.decodeObject(forKey: "province") as AnyObject
        self.recommend = decoder.decodeObject(forKey: "recommend") as AnyObject
        self.regTime = decoder.decodeObject(forKey: "regTime") as AnyObject
        self.sex = decoder.decodeObject(forKey: "sex") as AnyObject
        self.sign = decoder.decodeObject(forKey: "sign") as AnyObject
        self.spassword = decoder.decodeObject(forKey: "spassword") as AnyObject
        self.spwd = decoder.decodeObject(forKey: "spwd")  as AnyObject
        self.star = decoder.decodeObject(forKey: "star")  as AnyObject
        self.storeId = decoder.decodeObject(forKey: "storeId") as AnyObject
        self.type = decoder.decodeObject(forKey: "type") as AnyObject
    }

    //编码成object
    func encode(with coder: NSCoder) {
        coder.encode(acount, forKey:"acount")
        coder.encode(age, forKey:"age")
        coder.encode(city, forKey:"city")
        coder.encode(flag, forKey:"flag")
        coder.encode(fpassword, forKey:"fpassword")
        coder.encode(fpwd, forKey:"fpwd")
        coder.encode(id, forKey:"id")
        coder.encode(lastTime, forKey:"lastTime")
        coder.encode(nickname, forKey:"nickname")
        coder.encode(pice, forKey:"pice")
        coder.encode(province, forKey:"province")
        coder.encode(recommend, forKey:"recommend")
        coder.encode(regTime, forKey:"regTime")
        coder.encode(sex, forKey:"sex")
        coder.encode(sign, forKey:"sign")
        coder.encode(spassword, forKey:"spassword")
        coder.encode(spwd, forKey:"spwd")
        coder.encode(star, forKey:"star")
        coder.encode(storeId, forKey:"storeId")
        coder.encode(type, forKey:"type")
    }
}





