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
    
    struct FoodPurchaseNotesUX {
        static let startSpace:CGFloat = 30
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
    
    //加载套餐内容的数据
    func setPackageContentData(model:FoodVoucherDataModel){
        headingContentLabel.text = model.content
        let size:CGSize = OCTools.calculateMeaasgeHeight(withText: headingContentLabel.text, andWidth: SCREEN_WIDTH - 60, andFont: UIFont.systemFont(ofSize: 14))
        headingContentLabel.frame = CGRect(x: 30, y: headingLabel.frame.maxY + 15, width: size.width, height: size.height)
        self.addSubview(headingContentLabel)
        UserDefaults.standard.set(headingContentLabel.frame.maxY + 20, forKey: "height")
    }

    //购买需知的数据
    func setBuyNeedKonwData(model:FoodVoucherDataModel){
        self.contentView.addSubview(validityLabel)
        self.contentView.addSubview(usageTimeLabel)
        self.contentView.addSubview(usageRulesLabel)
        
//        validityLabel.text = "有效期：" + model.startTime! + "-" + model.endTime!
        validityLabel.text = "有效期：" + "2017.08.20" + "~" + "2017.08.20"
        usageTimeLabel.text = "8:00-22:00"
        usageRulesLabel.text = "使用规则：" + model.needKnow!
        
        let validitySize:CGSize = OCTools.calculateMeaasgeHeight(withText: validityLabel.text, andWidth: SCREEN_WIDTH - FoodPurchaseNotesUX.startSpace, andFont: validityLabel.font)
        validityLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(headingLabel.snp.bottom).offset(15)
            make.width.equalTo(validitySize.width)
            make.height.equalTo(validitySize.height)
        }
        
        let timeSize:CGSize = OCTools.calculateMeaasgeHeight(withText: usageTimeLabel.text, andWidth: SCREEN_WIDTH - FoodPurchaseNotesUX.startSpace, andFont: usageTimeLabel.font)
        usageTimeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(validityLabel.snp.bottom).offset(FoodPurchaseNotesUX.bottomSpace)
            make.width.equalTo(timeSize.width)
            make.height.equalTo(timeSize.height)
        }
        
        let rulesSize:CGSize = OCTools.calculateMeaasgeHeight(withText: usageRulesLabel.text, andWidth: SCREEN_WIDTH - FoodPurchaseNotesUX.startSpace, andFont: usageRulesLabel.font)
        usageRulesLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(usageTimeLabel.snp.bottom).offset(FoodPurchaseNotesUX.bottomSpace)
            make.width.equalTo(rulesSize.width)
            make.height.equalTo(rulesSize.height)
        }
        
         let sumHeight = validitySize.height +  timeSize.height + rulesSize.height + headingContentLabel.frame.maxY + 15 + FoodPurchaseNotesUX.bottomSpace * 2
         UserDefaults.standard.set(sumHeight + 20, forKey: "height")
    }
    
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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
