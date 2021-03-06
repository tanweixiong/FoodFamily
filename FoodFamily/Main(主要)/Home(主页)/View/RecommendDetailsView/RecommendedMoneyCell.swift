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
            self.pricelabel.text = "¥" + (moneyDataModel.price?.stringValue)! + "代" + (moneyDataModel.vouPrice?.stringValue)! + "元"
        }
    }
    @IBOutlet weak var pricelabel: UILabel!
    var recommendedMoneyCallBack:((RecommendVoucherDataModel)->())?;
    @IBOutlet weak var buyButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buyButton.layer.borderColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1).cgColor
        buyButton.layer.borderWidth = 1
    }
    @IBAction func buyNowClick(_ sender: UIButton) {
        if recommendedMoneyCallBack != nil {
            recommendedMoneyCallBack!(self.moneyDataModel)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
