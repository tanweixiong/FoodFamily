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
    static let kAPIBaseURL: String = "http://47.92.105.209:8080/app/"
//    static let kAPIBaseURL: String = "http://10.0.0.27/app/"
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
    static let kAPIOrderGetOrderInfo = kAPIBaseURL + "order/getOrderInfo" //获取订单详情
    static let kAPIUserSetSpassword = kAPIBaseURL + "user/setSpassword" //设置支付密码
    static let kAPIUserUpdateSpassword = kAPIBaseURL + "user/updateSpassword" //修改支付密码
    static let kAPIUserWalletGetUserWalletList = kAPIBaseURL + "userWallet/getUserWalletList" //我的钱包
    static let kAPIUserUpdateUserInfo = kAPIBaseURL + "user/updateUserInfo" //保存个人信息
    static let kAPIStoreGetNearStoreList = kAPIBaseURL + "store/getNearStoreList" //获取附近的店铺
    static let kAPIStoreSelectStoreByStoreName = kAPIBaseURL + "store/selectStoreByStoreName" //搜索附近的店铺
    static let kAPIOrderAddAppointmentOrderInfo = kAPIBaseURL + "order/addAppointmentOrderInfo" //预约支付
    static let kAPIOrderAddMealOrderInfo = kAPIBaseURL + "order/addMealOrderInfo" //套餐支付
    static let kAPIOrderAddVouOrderInfo = kAPIBaseURL + "order/addVouOrderInfo" //代金券支付
    static let kAPIUserWalletGetIntegralByUserId = kAPIBaseURL + "userWallet/getIntegralByUserId" //获取积分接口
    
}

