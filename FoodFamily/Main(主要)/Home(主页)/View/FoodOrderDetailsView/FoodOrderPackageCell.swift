//
//  FoodOrderPackageCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/9.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodOrderPackageCell: UITableViewCell {
    var headingContentArray = NSArray()
    var headingContentDataArray = NSArray()
    var type = FoodOrderDetailsVMType.canteenModel
    
    struct FoodOrderPackageUX {
        static let backgroundHeight:CGFloat = 38.5
        static let space:CGFloat = 15
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //堂吃 预约
    var canteenModel : FoodOrderCanteenListModel = FoodOrderCanteenListModel()!{
        didSet{
            headingContentArray = ["消费金额","积分抵扣","实际付费"]
            let totalPrice = canteenModel.totalPrice?.stringValue
            let integral = "-" + (canteenModel.integral!)
            let paymentAmount = canteenModel.paymentAmount?.stringValue
            headingContentDataArray = [totalPrice!,integral,paymentAmount!]
        }
    }
    
    //代金券
    var voucherModel : FoodOrderVoucherListModel = FoodOrderVoucherListModel()!{
        didSet{
            let voucherPrice = "¥" + (voucherModel.voucherPrice?.stringValue)!
            let orderMsg = voucherModel.orderMsg
            headingContentArray = ["套餐内容",orderMsg!,"使用范围："]
            headingContentDataArray = ["",voucherPrice,""]
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(type:FoodOrderDetailsVMType){
        self.type = type
        self.contentView.addSubview(listView)
        
        if type == .voucherModel {
            conventionContentLabel.text = self.voucherModel.content
            self.contentView.addSubview(conventionContentLabel)
            let size:CGSize = OCTools.calculateMeaasgeHeight(withText: conventionContentLabel.text, andWidth: SCREEN_WIDTH - 60, andFont: UIFont.systemFont(ofSize: 14))
            conventionContentLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.top.equalTo(listView.snp.bottom).offset(0)
                make.width.greaterThanOrEqualTo(size.width)
                make.height.greaterThanOrEqualTo(size.height)
            }
            UserDefaults.standard.set(listView.frame.size.height + size.height + FoodOrderPackageUX.space, forKey: "height")
        }
    }
    
    lazy var listView: UIView = {
        let view = UIView()
        for item in 0...headingContentArray.count - 1 {
            let backgroundVw = UIView()
            let backgroundHeight:CGFloat = FoodOrderPackageUX.backgroundHeight
            backgroundVw.frame = CGRect(x: 0 , y:CGFloat(Int(FoodOrderPackageUX.backgroundHeight) * item) , width: SCREEN_WIDTH , height: backgroundHeight)
            backgroundVw.tag = item + 1
            view.addSubview(backgroundVw)
            
            let heading = headingContentArray[item] as? String
            let headingLab = UILabel()
            headingLab.text = heading
            headingLab.font = UIFont.systemFont(ofSize: 14)
            headingLab.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
            headingLab.textAlignment = .left
            backgroundVw.addSubview(headingLab)
            let size:CGSize = headingLab.getStringSize(text: heading!, size: CGSize(width:SCREEN_WIDTH - 30,height:backgroundVw.frame.size.height), font: 14)
            headingLab.frame = CGRect(x: 15, y: 0, width: size.width, height: backgroundVw.frame.size.height)
        
            if item == 1  && self.type == .voucherModel{
                //字体变色
                let priceString = NSMutableAttributedString.init(string: heading!)
                priceString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.R_UIRGBColor(red: 155, green: 155, blue: 155, alpha: 1),range: NSMakeRange(3, 4))
                headingLab.attributedText = priceString
            }
            
            //内容
            let contentLab = UILabel()
            contentLab.text = headingContentDataArray[item] as? String
            contentLab.font = UIFont.systemFont(ofSize: 16)
            let x =  headingLab.frame.maxX + 5
            contentLab.frame = CGRect(x: x, y: 0, width:SCREEN_WIDTH - x - 15, height:backgroundVw.frame.size.height)
            contentLab.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
            contentLab.textAlignment = .right
            backgroundVw.addSubview(contentLab)
            
        }
        let tagView = view.viewWithTag(headingContentArray.count)!
        view.frame = CGRect(x: 0, y:0, width: SCREEN_HEIGHT, height: tagView.frame.maxY)
        UserDefaults.standard.set(view.frame.maxY + FoodOrderPackageUX.space, forKey: "height")
        return view
    }()
    
    lazy var conventionContentLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        return label
    }()
}
