//
//  MineWalletCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/27.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineWalletCell: UITableViewCell {
    @IBOutlet weak var detailTypeLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var detailPriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
