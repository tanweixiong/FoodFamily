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
    @IBOutlet weak var recommendTextField: UITextField!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var recommendView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       finishButton.layer.borderColor = UIColor.lightGray.cgColor
       finishButton.layer.borderWidth = 1
       finishButton.backgroundColor = UIColor.R_UIRGBColor(red: 251, green: 251, blue: 251, alpha: 1)
    }

    @IBAction func onClick(_ sender: UIButton) {
        if registerViewFinishCallBack != nil {
            registerViewFinishCallBack!()
        }
    }
}
