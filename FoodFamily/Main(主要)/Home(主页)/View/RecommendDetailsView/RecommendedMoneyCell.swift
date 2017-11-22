//
//  RecommendedMoneyCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RecommendedMoneyCell: UITableViewCell {
    var moneyDataModel : RecommendVoucherDataModel = RecommendVoucherDataModel()!{
        didSet{
            
        }
    }
   var recommendedMoneyCallBack:((UIButton)->())?;
    @IBOutlet weak var buyButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buyButton.layer.borderColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1).cgColor
        buyButton.layer.borderWidth = 1
    }
    @IBAction func buyNowClick(_ sender: UIButton) {
        if recommendedMoneyCallBack != nil {
            recommendedMoneyCallBack!(sender)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
