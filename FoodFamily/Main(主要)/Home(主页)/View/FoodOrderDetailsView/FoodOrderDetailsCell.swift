//
//  FoodOrderDetailsCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/9.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodOrderDetailsCell: UITableViewCell {
    var orderPaymentMethod = OrderPaymentMethod.ordinaryPaymentStatus
    var headingContentArray = NSArray()
    var headingContentDataArray = NSArray()
    struct FoodOrderDetailsUX {
        static let titleHeight:CGFloat = 14
        static let backgroundHeight:CGFloat = 38.5
        static let space:CGFloat = 0
    }
    
    
    //堂吃 预约
    var canteenModel : FoodOrderCanteenListModel = FoodOrderCanteenListModel()!{
        didSet{
            headingContentArray = ["订单号码","订单时间","支付方式"]
            let orderNo = canteenModel.orderNo
            let createTime = canteenModel.createTime
            var payType = ""
            if canteenModel.payType == 1 {
                payType = "余额支付"
            }else if canteenModel.payType == 2 {
                payType = "微信支付"
            }else if canteenModel.payType == 3 {
                payType = "支付宝支付"
            }
            headingContentDataArray = [orderNo!,createTime!,payType]
        }
    }
    //代金券
    var voucherModel : FoodOrderVoucherListModel = FoodOrderVoucherListModel()!{
        didSet{
           headingContentArray = ["卷码","订单号码","订单时间","支付方式"]
            let vouNum = voucherModel.vouNum!
            let orderNo = voucherModel.orderNo!
            let createTime = voucherModel.createTime
            var payType = ""
            if voucherModel.payType == 1 {
                payType = "余额支付"
            }else if voucherModel.payType == 2 {
                payType = "微信支付"
            }else if voucherModel.payType == 3 {
                payType = "支付宝支付"
            }
            headingContentDataArray = [vouNum,orderNo,createTime!,payType]
        }
    }
    //套餐
    var packageModel : FoodOrderPackageListModel = FoodOrderPackageListModel()!{
        didSet{
            headingContentArray = ["订单号码","订单时间","支付方式","积分折扣","消费总额"]
            let orderNo = packageModel.orderNo!
            let createTime = packageModel.createTime
            var orderStatus = ""
            if packageModel.orderStatus == 1{
                orderStatus = "未支付"
            }else if packageModel.orderStatus == 2 {
                orderStatus = "已支付"
            }else if packageModel.orderStatus == 5 {
                orderStatus = "未评价"
            }else if packageModel.orderStatus == 6 {
                orderStatus = "已评价"
            }else if packageModel.orderStatus == 7 {
                orderStatus = "交易完成"
            }else if packageModel.orderStatus == 8 {
                orderStatus = "交易关闭"
            }
            let integral = packageModel.integral!
            let paymentAmount = packageModel.paymentAmount?.stringValue
            headingContentDataArray = [orderNo,createTime!,orderStatus,integral,paymentAmount!]
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(){
        self.contentView.addSubview(listView)
    }

    lazy var listView: UIView = {
        let view = UIView()
        for item in 0...headingContentArray.count - 1 {
            let backgroundVw = UIView()
            let backgroundHeight:CGFloat = FoodOrderDetailsUX.backgroundHeight
            backgroundVw.frame = CGRect(x: 0 , y:CGFloat(Int(FoodOrderDetailsUX.backgroundHeight) * item) , width: SCREEN_WIDTH , height: backgroundHeight)
            backgroundVw.tag = item + 1
            view.addSubview(backgroundVw)
            
            let headingLab = UILabel()
            headingLab.text = headingContentArray[item] as? String
            headingLab.font = UIFont.systemFont(ofSize: 14)
            headingLab.frame = CGRect(x: 15, y: 0, width: 60, height:backgroundVw.frame.size.height)
            headingLab.textColor = UIColor.R_UIRGBColor(red: 155, green: 155, blue: 155, alpha: 1)
            headingLab.textAlignment = .left
            backgroundVw.addSubview(headingLab)
            
            let contentLab = UILabel()
            contentLab.text = headingContentDataArray[item] as? String
            contentLab.font = UIFont.systemFont(ofSize: 14)
            let x = headingLab.frame.maxX + 15
            contentLab.frame = CGRect(x: x, y: 0, width:SCREEN_WIDTH - x - 15, height:backgroundVw.frame.size.height)
            contentLab.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
            contentLab.textAlignment = .left
            backgroundVw.addSubview(contentLab)
        }
        let tagView = view.viewWithTag(headingContentArray.count)!
        view.frame = CGRect(x: 0, y:0, width: SCREEN_HEIGHT, height: tagView.frame.maxY + FoodOrderDetailsUX.space)
        UserDefaults.standard.set(view.frame.maxY, forKey: "height")
        return view
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
