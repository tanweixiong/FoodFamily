//
//  FoodMerchantsListCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/10.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodMerchantsListCell: UITableViewCell {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var checkedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
