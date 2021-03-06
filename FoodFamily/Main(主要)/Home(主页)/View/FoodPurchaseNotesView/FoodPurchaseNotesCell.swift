//
//  FoodPurchaseNotesCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodPurchaseNotesCell: UITableViewCell {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var headingImageView: UIImageView!
    
    struct FoodPurchaseNotesUX {
        static let startSpace:CGFloat = 60
        static let bottomSpace:CGFloat = 10
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(model:FoodVoucherDataModel,index:NSInteger){
        if index == 0 {
            self.setPackageContentData(model: model)
        }else{
            self.setBuyNeedKonwData(model: model)
        }
    }
    
    //加载套餐内容的数据 优惠券
    func setPackageContentData(model:FoodVoucherDataModel){
        self.addSubview(headingContentLabel)
        
        headingContentLabel.text = model.content
        let size:CGSize = OCTools.calculateMeaasgeHeight(withText: headingContentLabel.text, andWidth: SCREEN_WIDTH - FoodPurchaseNotesUX.startSpace, andFont: UIFont.systemFont(ofSize: 14))
        headingContentLabel.snp.updateConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.greaterThanOrEqualTo(headingLabel.frame.maxY + 15)
            make.width.equalTo(size.width)
            make.height.equalTo(size.height)
        }
        let sum = headingLabel.frame.maxY + 15 + size.height
        UserDefaults.standard.set(sum + 20, forKey: "height")
    }

    //购买需知的数据 优惠券
    func setBuyNeedKonwData(model:FoodVoucherDataModel){
        self.contentView.addSubview(validityLabel)
        self.contentView.addSubview(usageTimeLabel)
        self.contentView.addSubview(usageRulesLabel)
        
        validityLabel.text = "有效期：" + model.startTime! + "~" + model.endTime!
        usageTimeLabel.text = "使用时间：" + model.useTime!
        let needKnow = ((model.needKnow) != nil) ? model.needKnow! : ""
        usageRulesLabel.text = "使用规则：" + needKnow

        let validitySize:CGSize = OCTools.calculateMeaasgeHeight(withText: validityLabel.text!, andWidth: SCREEN_WIDTH - FoodPurchaseNotesUX.startSpace, andFont: validityLabel.font)
        validityLabel.snp.updateConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(headingLabel.snp.bottom).offset(15)
            make.width.equalTo(validitySize.width)
            make.height.equalTo(validitySize.height)
        }

        let timeSize:CGSize = OCTools.calculateMeaasgeHeight(withText: usageTimeLabel.text!, andWidth: SCREEN_WIDTH - FoodPurchaseNotesUX.startSpace, andFont: usageTimeLabel.font)
        usageTimeLabel.snp.updateConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(validityLabel.snp.bottom).offset(FoodPurchaseNotesUX.bottomSpace)
            make.width.equalTo(timeSize.width)
            make.height.equalTo(timeSize.height)
        }
        
        let rulesSize:CGSize = OCTools.calculateMeaasgeHeight(withText: usageRulesLabel.text!, andWidth: SCREEN_WIDTH - FoodPurchaseNotesUX.startSpace, andFont: usageRulesLabel.font)
        usageRulesLabel.snp.updateConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(usageTimeLabel.snp.bottom).offset(FoodPurchaseNotesUX.bottomSpace)
            make.width.equalTo(rulesSize.width)
            make.height.equalTo(rulesSize.height)
        }
        
         let sumHeight = headingLabel.frame.maxY + 15 + validitySize.height +  timeSize.height + rulesSize.height +  FoodPurchaseNotesUX.bottomSpace * 2
         UserDefaults.standard.set(sumHeight + 20, forKey: "height")
    }
    
    //加载套餐的内容
    func setPackageDetails(model:FoodMealDetailsDataModel){
        self.headingLabel.isHidden = true
        self.headingImageView.isHidden = true
        self.contentView.addSubview(self.webView)
//        self.contentView.addSubview(conventionContentLabel)

//        conventionContentLabel.text = model.mealIntroduction!
//        let size:CGSize = OCTools.calculateMeaasgeHeight(withText: conventionContentLabel.text, andWidth: SCREEN_WIDTH - 60, andFont: UIFont.systemFont(ofSize: 14))
//        conventionContentLabel.snp.updateConstraints { (make) in
//            make.centerX.equalTo(contentView.snp.centerX)
//            make.top.greaterThanOrEqualTo(20)
//            make.width.equalTo(size.width)
//            make.height.equalTo(size.height)
//        }

//        let webView = UIWebView(frame: CGRect(x: 30, y: 20, width: SCREEN_WIDTH - 60, height: 100))
//        webView.delegate = self
//        self.contentView.addSubview(webView)
        
        
        
//        let sum = 20 + size.height
//        UserDefaults.standard.set(sum + 20, forKey: "height")
    }
    
    lazy var  webView:UIWebView = {
        let vw = UIWebView(frame: CGRect(x: 30, y: 20, width: SCREEN_WIDTH - 60, height: 100))
        vw.scrollView.bounces = false
        return vw
    }()
    
    lazy var headingContentLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        return label
    }()
    
    //有效期
    lazy var validityLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        return label
    }()
    
    //使用时间
    lazy var usageTimeLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        return label
    }()
    
    //使用规则
    lazy var usageRulesLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        return label
    }()
    
    //套餐详情
    lazy var conventionContentLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
