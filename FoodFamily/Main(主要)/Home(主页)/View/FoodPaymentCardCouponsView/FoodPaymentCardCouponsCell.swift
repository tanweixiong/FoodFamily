//
//  FoodPaymentCardCouponsCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/8.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodPaymentCardCouponsCell: UITableViewCell {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var couponsBackgroundImg: UIImageView!
    @IBOutlet weak var validityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var scopeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
