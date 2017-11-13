//
//  LoginVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/13.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    struct LoginUX {
        static let textFieldHeight:CGFloat = 40
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var backgorundImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "ic_login_backgroundImageVw")
        return imageView
    }()
    
    lazy var logoImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "ic_login_logoImageView")
        return imageView
    }()
    
    lazy var phoneTextField: InputView = {
        let textField = InputView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: LoginUX.textFieldHeight))
        textField.iconImageView.image = UIImage(named: "login_password")
        textField.AGTextField.placeholder = "密码设置"
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("登录", for: .normal)
        button.backgroundColor = R_UIThemeGoldColor
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        return button
    }()

    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("注册", for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        button.layer.borderColor = UIColor.white.cgColor
        button.clipsToBounds = true
        return button
    }()
    
}
