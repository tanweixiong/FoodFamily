//
//  ConstAPIURL.swift
//  DHSWallet
//
//  Created by zhengyi on 2017/8/16.
//  Copyright © 2017年 zhengyi. All rights reserved.
//

import UIKit

struct ConstAPI {
    //正式
    static let kAPIBaseURL: String = "http://10.0.0.3/app/"
    static let kAPIUserGetPhoneCode = kAPIBaseURL + "user/getPhoneCode" //注册
    static let kAPIUserLogin = kAPIBaseURL + "user/login" //登录
    static let kAPIUserForgetPassword = kAPIBaseURL + "user/forgetPassword" //忘记密码
    static let kAPIUserRegister = kAPIBaseURL + "user/register" //忘记密码
}

