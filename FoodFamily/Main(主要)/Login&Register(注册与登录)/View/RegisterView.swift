//
//  RegisterView.swift
//  FoodFamily
//
//  Created by tam on 2017/11/13.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RegisterView: UIView {
   var registerViewFinishCallBack:(()->())?;
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
       finishButton.layer.borderColor = UIColor.R_UIRGBColor(red: 155, green: 155, blue: 155, alpha: 1).cgColor
       finishButton.layer.borderWidth = 1
    }

    @IBAction func onClick(_ sender: UIButton) {
        if registerViewFinishCallBack != nil {
            registerViewFinishCallBack!()
        }
    }
}
