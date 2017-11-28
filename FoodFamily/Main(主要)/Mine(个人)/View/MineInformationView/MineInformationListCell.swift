//
//  MineInformationListCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineInformationListCell: UITableViewCell {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var textfieldButton: UIButton!
    var mineInformationListCallBack:((UIButton)->())?;
    override func awakeFromNib() {
        super.awakeFromNib()
        textfield.setValue(UIColor.R_UIRGBColor(red: 146, green: 146, blue: 146, alpha: 1), forKeyPath: "_placeholderLabel.textColor")
        textfield.font = UIFont.systemFont(ofSize: CGFloat(14))
        textfield.textColor = UIColor.R_UIRGBColor(red: 146, green: 146, blue: 146, alpha: 1)
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        if self.mineInformationListCallBack != nil {
            self.mineInformationListCallBack!(sender)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
