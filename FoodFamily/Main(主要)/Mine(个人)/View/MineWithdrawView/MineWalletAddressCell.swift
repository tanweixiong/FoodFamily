//
//  MineWalletAddressCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/15.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineWalletAddressCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var textfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
