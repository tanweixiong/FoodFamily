//
//  FoodReservationPayCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodReservationPayCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.layer.borderWidth = 2
            iconImageView.layer.borderColor = UIColor.R_UIRGBColor(red: 211, green: 178, blue: 105, alpha: 1).cgColor
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
