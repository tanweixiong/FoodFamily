//
//  AddBankTextFieldCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/15.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class AddBankTextFieldCell: UITableViewCell {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var textfield: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textfield.textColor = UIColor.R_UIRGBColor(red: 144, green: 144, blue: 144, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
