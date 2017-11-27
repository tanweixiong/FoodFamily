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
    static let kAPIBaseURL: String = "http://10.0.0.27/app/"
    static let kAPIUserGetPhoneCode = kAPIBaseURL + "user/getPhoneCode" //注册
    static let kAPIUserLogin = kAPIBaseURL + "user/login" //登录
    static let kAPIUserForgetPassword = kAPIBaseURL + "user/forgetPassword" //忘记密码
    static let kAPIUserRegister = kAPIBaseURL + "user/register" //忘记密码
    static let kAPIAppIndex = kAPIBaseURL + "index" //首页
    static let kAPIStoreGetStoreInfo = kAPIBaseURL + "store/getStoreInfo" //首页详情
    static let kAPIAssessGetAssessList = kAPIBaseURL + "assess/getAssessList" //首页详情评论列表
    static let kAPIVouchersGetVoucherById = kAPIBaseURL + "vouchers/getVoucherById" //首页详情代金券
    static let kAPIMealGetMealInfoById = kAPIBaseURL + "meal/getMealInfoById" //首页详情套餐
    static let kAPIStoreCollectionStore = kAPIBaseURL + "store/collectionStore" //首页详情收藏店铺
    static let kAPIStoreCancelCollection = kAPIBaseURL + "store/cancelCollection" //首页详情取消收藏店铺
    static let kAPICollectionGetCollectionList = kAPIBaseURL + "collection/getCollectionList" //获取收藏列表
    static let kAPIUserCouponBuyCoupon = kAPIBaseURL + "userCoupon/buyCoupon" //首页详情优惠券
    static let kAPIUserCouponGetUserCouponList = kAPIBaseURL + "userCoupon/getUserCouponList" //首页购买优惠券
    static let kAPIOrderGetOrderList = kAPIBaseURL + "order/getOrderList" //获取订单列表
    
}

