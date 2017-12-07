//
//  FoodVolumeCodeCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/16.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodVolumeCodeCell: UITableViewCell {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var headingContentLabel: UILabel!
    
    //代金券
    var voucherModel : FoodOrderVoucherListModel = FoodOrderVoucherListModel()!{
        didSet{
            self.headingContentLabel.text = voucherModel.vouNum!
        }
    }
    
    //套餐
    var packageModel : FoodOrderPackageListModel = FoodOrderPackageListModel()!{
        didSet{
            self.headingContentLabel.text = packageModel.vouNum!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
