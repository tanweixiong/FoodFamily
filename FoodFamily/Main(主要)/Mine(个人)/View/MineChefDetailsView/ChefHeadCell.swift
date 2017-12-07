//
//  MineChefDetailsHeadCell.swift
//  FoodFamily
//
//  Created by tam on 2017/12/5.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class ChefHeadCell: UITableViewCell {
    @IBOutlet weak var backGroundVw: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tradingStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
