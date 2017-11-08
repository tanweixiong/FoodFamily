//
//  FoodReservationFinishHeadCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/8.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodReservationFinishHeadCell: UITableViewCell {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet{
            iconImageView.layer.borderColor = UIColor.R_UIRGBColor(red: 211, green: 178, blue: 105, alpha: 1).cgColor
            iconImageView.layer.borderWidth = 2
        }
    }
    @IBOutlet weak var informationContentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
