//
//  RecommendedListMoneyCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/22.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RecommendedListMoneyCell: UITableViewCell {
    var moneyDataModel : RecommendVoucherDataModel = RecommendVoucherDataModel()!{
        didSet{
            self.pircelabel.text = "¥" + (moneyDataModel.price?.stringValue)! + "代" + (moneyDataModel.vouPrice?.stringValue)! + "元"
//            self.buyButton.tag = moneyDataModel.id?.stringVale
        }
    }
    @IBOutlet weak var pircelabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    var recommendedMoneyCallBack:((RecommendVoucherDataModel)->())?;
    override func awakeFromNib() {
        super.awakeFromNib()
        buyButton.layer.borderColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1).cgColor
        buyButton.layer.borderWidth = 1
    }
    
    @IBAction func OnClick(_ sender: UIButton) {
        if recommendedMoneyCallBack != nil {
            recommendedMoneyCallBack!(self.moneyDataModel)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
