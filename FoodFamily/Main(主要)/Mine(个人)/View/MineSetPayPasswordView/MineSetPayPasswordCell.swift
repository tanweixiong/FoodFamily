//
//  MineSetPayPasswordCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/13.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineSetPayPasswordCell: UITableViewCell {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var textfield: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(){
        textfield.setValue(UIColor.R_UIRGBColor(red: 146, green: 146, blue: 146, alpha: 1), forKeyPath: "_placeholderLabel.textColor")
        textfield.font = UIFont.systemFont(ofSize: CGFloat(14))
        textfield.textColor = UIColor.R_UIRGBColor(red: 146, green: 146, blue: 146, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
