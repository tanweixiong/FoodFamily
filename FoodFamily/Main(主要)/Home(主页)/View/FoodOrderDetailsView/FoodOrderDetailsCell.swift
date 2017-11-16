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
    struct FoodOrderDetailsUX {
        static let titleHeight:CGFloat = 14
        static let backgroundHeight:CGFloat = 38.5
        static let space:CGFloat = 0
    }
    
    var headingContentArray:NSArray = [] {
        didSet{
            if orderPaymentMethod == .ordinaryPaymentStatus {
                headingContentArray = ["订单号码","订单时间","支付方式","积分折扣","消费总额"]
            }else{
                headingContentArray = ["卷码","订单号码","订单时间","支付方式","积分折扣","消费总额"]
            }
        }
    }
    
    var contentArray:NSArray = [] {
        didSet{
            if orderPaymentMethod == .ordinaryPaymentStatus {
                contentArray = ["123123128390","2017-10-27 10:22:41","余额支付","-100（10元）","¥248"]
            }else{
                contentArray = ["123192031239","123192031239","2017-10-27 10:22:41","余额支付","-100（10元）","70"]
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(_ orderPaymentMethod:OrderPaymentMethod){
        self.orderPaymentMethod = orderPaymentMethod
        self.contentView.addSubview(listView)
    }

    lazy var listView: UIView = {
        headingContentArray = NSArray()
        contentArray = NSArray()
        
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
            contentLab.text = contentArray[item] as? String
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
