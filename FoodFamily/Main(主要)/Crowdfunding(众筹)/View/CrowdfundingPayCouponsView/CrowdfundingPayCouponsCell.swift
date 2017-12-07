//
//  CrowdfundingPayCouponsCell.swift
//  FoodFamily
//
//  Created by tam on 2017/12/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class CrowdfundingPayCouponsCell: UITableViewCell {
   var crowdfundingPayCouponsBlcok:((UIButton)->())?;
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var pojectButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.buyButton.layer.borderWidth = 1
        self.buyButton.layer.borderColor = R_UIThemeGoldColor.cgColor
    }
    
    func setData(model:CrowdfundingPayCouponsDataModel){
        priceLabel.text = "¥" + (model.price?.stringValue)! + "元/份"
        countLabel.text = "收益权|" + "共\(model.count!)份"
    }

    @IBAction func buyNowClick(_ sender: UIButton) {
        if crowdfundingPayCouponsBlcok != nil {
            crowdfundingPayCouponsBlcok!(sender)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
