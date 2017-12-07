//
//  CrowdfundingCell.swift
//  FoodFamily
//
//  Created by tam on 2017/12/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class CrowdfundingCell: UITableViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var startPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(model:CrowdfundingDataModel){
        self.contentView.addSubview(crowdfundingNumberAlphView)
        self.contentView.addSubview(crowdfundingNumberView)
        self.contentView.addSubview(crowdfundingNumberLabel)
        
        
        self.backgroundImageView.sd_setImage(with: NSURL(string: (model.img)!)! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
        self.crowdfundingNumberLabel.text = (model.percent?.stringValue)! + "%"
        self.startPriceLabel.text = "起投：" + "¥" + (model.state?.stringValue)!
        self.totalPriceLabel.text = "目标：" + "¥" + (model.totalPrice?.stringValue)!
        self.projectNameLabel.text = model.projectName
        
        
        let size = crowdfundingNumberLabel.getStringSize(text: crowdfundingNumberLabel.text!, size: CGSize(width:SCREEN_WIDTH,height:12), font: 12)
        
        let width = size.width + 10
        crowdfundingNumberView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-30)
            make.width.greaterThanOrEqualTo(width)
            make.height.greaterThanOrEqualTo(width)
        }
        
        let alphWidth = size.width + 13
        crowdfundingNumberAlphView.snp.makeConstraints { (make) in
            make.centerX.equalTo(crowdfundingNumberView.snp.centerX)
            make.centerY.equalTo(crowdfundingNumberView.snp.centerY)
            make.width.greaterThanOrEqualTo(alphWidth)
            make.height.greaterThanOrEqualTo(alphWidth)
        }
        
        crowdfundingNumberLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(crowdfundingNumberView.snp.centerX)
            make.centerY.equalTo(crowdfundingNumberView.snp.centerY)
            make.size.greaterThanOrEqualTo(size)
        }

        crowdfundingNumberView.layer.cornerRadius = width/2
        crowdfundingNumberAlphView.layer.cornerRadius = alphWidth/2
    }
    
    lazy var crowdfundingNumberLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 25, green: 22, blue: 25, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "--%"
        label.textColor = R_UIThemeGoldColor
        return label
    }()
    
    lazy var crowdfundingNumberView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.R_UIRGBColor(red: 255, green: 255, blue: 255, alpha: 0.5).cgColor
        view.layer.borderWidth = 10
        view.clipsToBounds = true
        return view
    }()
    
    lazy var crowdfundingNumberAlphView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.R_UIRGBColor(red: 255, green: 255, blue: 255, alpha: 0.5)
        view.clipsToBounds = true
        return view
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
