//
//  FoodReservationFilliCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodReservationFilliCell: UITableViewCell,UITextFieldDelegate {
    var foodReservationFillTextFiledCallBack:((String)->())?;
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField!{
        didSet {
            codeTextField.placeholder = "请输入验证码"
            codeTextField.setValue(UIColor.R_UIRGBColor(red: 155, green: 155, blue: 155, alpha: 1), forKeyPath: "_placeholderLabel.textColor")
            codeTextField.textAlignment = .right;
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if  self.foodReservationFillTextFiledCallBack != nil {
            self.foodReservationFillTextFiledCallBack!(textField.text!)
        }
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
