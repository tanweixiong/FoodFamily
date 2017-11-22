//
//  RecommendNaviCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RecommendNaviCell: UITableViewCell {
    
     var recommendDataModel : RecommendDataModel = RecommendDataModel()!{
        didSet{
           self.detailsAddressLabel.text = recommendDataModel.detailedAddress
        }
     }
    @IBOutlet weak var detailsAddressLabel: UILabel!
    
    @IBOutlet weak var naviButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        naviButton.layer.borderColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1).cgColor
        naviButton.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
