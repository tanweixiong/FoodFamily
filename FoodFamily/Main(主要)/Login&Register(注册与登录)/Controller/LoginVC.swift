//
//  LoginVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/13.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginVC: UIViewController,RegisterAndForgetPsdDeleagte {
    
    struct LoginUX {
        static let textFieldHeight:CGFloat = YMAKE(30)
        static let logoSize:CGSize = CGSize(width: XMAKE(50), height: XMAKE(50))
        static let buttonHeight:CGFloat = YMAKE(40)
        static let textFieldSpace:CGFloat = 40
        static let textFieldWidth:CGFloat = SCREEN_WIDTH - textFieldSpace * 2
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setColor(UIColor.clear)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.alpha = 0
        self.title = "登录"
        self.setCloseRoundKeyboard()
        self.createUI()
        
        self.phoneTextField.AGTextField.text = "17876489900"
        self.passwordTextField.AGTextField.text = "123456"
    }
    
    func loginOnClick(){
        if checkTheInput() {
            let parameters = ["acount":self.phoneTextField.AGTextField.text!,"password":self.passwordTextField.AGTextField.text!]
            SVProgressHUD.show(withStatus: "请稍等")
            BaseViewModel.loadSuccessfullyLoginData(requestType: .post, URLString: ConstAPI.kAPIUserLogin, parameters: parameters, finishedCallback: {
                SVProgressHUD.showSuccess(withStatus: "登录成功")
                SVProgressHUD.dismiss()
                let tab = MainTabBarController()
                UIApplication.shared.keyWindow?.rootViewController = tab
            })
        }
    }
    
    func checkTheInput()->Bool{
        if !Tools.validateMobile(mobile:self.phoneTextField.AGTextField.text!){
            SVProgressHUD.showInfo(withStatus: "请输入正确的手机号码")
            return false
        }
        if !Tools.validatePassword(password:self.passwordTextField.AGTextField.text!){
            SVProgressHUD.showInfo(withStatus: "请输入正确的密码")
            return false
        }
        return true
    }
    
    func registerAndForgetPsdFinish(account:String,password:String){
        self.phoneTextField.AGTextField.text = account
        self.passwordTextField.AGTextField.text = password
    }

    func createUI(){
        view.addSubview(backgorundImageView)
        view.addSubview(logoImageView)
        view.addSubview(phoneTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgetButton)
        view.addSubview(loginButton)
        view.addSubview(registerButton)

        backgorundImageView.snp.makeConstraints { (make) in
            make.top.equalTo(-YMAKE(64))
            make.bottom.equalTo(self.view.snp.bottom)
            make.left.equalTo(0)
            make.width.equalTo(SCREEN_WIDTH)
        }

        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(backgorundImageView.snp.top).offset(YMAKE(70) + YMAKE(64))
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.greaterThanOrEqualTo(LoginUX.logoSize.width)
            make.height.greaterThanOrEqualTo(LoginUX.logoSize.height)
        }

        phoneTextField.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(YMAKE(60))
            make.height.equalTo(LoginUX.textFieldHeight)
            make.left.equalTo(self.view.snp.left).offset(LoginUX.textFieldSpace)
            make.right.equalTo(self.view.snp.right).offset(-LoginUX.textFieldSpace)
        }

        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(phoneTextField.snp.bottom).offset(YMAKE(15))
            make.height.equalTo(LoginUX.textFieldHeight)
            make.left.equalTo(self.view.snp.left).offset(LoginUX.textFieldSpace)
            make.right.equalTo(self.view.snp.right).offset(-LoginUX.textFieldSpace)
        }
        
        forgetButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(YMAKE(10))
            make.height.equalTo(forgetButton.frame.size.height)
            make.right.equalTo(passwordTextField.snp.right).offset(5)
            make.width.greaterThanOrEqualTo(forgetButton.frame.size.width)
        }

        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(forgetButton.snp.bottom).offset(YMAKE(40))
            make.height.equalTo(LoginUX.buttonHeight)
            make.left.equalTo(self.view.snp.left).offset(LoginUX.textFieldSpace)
            make.right.equalTo(self.view.snp.right).offset(-LoginUX.textFieldSpace)
        }

        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(YMAKE(20))
            make.height.equalTo(LoginUX.buttonHeight)
            make.left.equalTo(self.view.snp.left).offset(LoginUX.textFieldSpace)
            make.right.equalTo(self.view.snp.right).offset(-LoginUX.textFieldSpace)
        }

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
        let textField = InputView(frame: CGRect(x: LoginUX.textFieldSpace, y:0, width: LoginUX.textFieldWidth, height: LoginUX.textFieldHeight))
        let text = NSMutableAttributedString.init(string: "输入手机号")
        text.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.R_UIRGBColor(red: 144, green: 144, blue: 144, alpha: 1), range: NSMakeRange(0, text.length))
        textField.AGTextField.attributedPlaceholder = text
        textField.AGTextField.backgroundColor = UIColor.clear
        return textField
    }()
    
    lazy var passwordTextField: InputView = {
         let textField = InputView(frame: CGRect(x: LoginUX.textFieldSpace, y:0, width: LoginUX.textFieldWidth, height: LoginUX.textFieldHeight))
        let text = NSMutableAttributedString.init(string: "密码")
        text.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.R_UIRGBColor(red: 144, green: 144, blue: 144, alpha: 1), range: NSMakeRange(0, text.length))
        textField.AGTextField.attributedPlaceholder = text
        textField.AGTextField.backgroundColor = UIColor.clear
        textField.AGTextField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("登录", for: .normal)
        button.backgroundColor = R_UIThemeGoldColor
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        button.tag = 0
        return button
    }()

    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("注册", for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        button.layer.borderColor = UIColor.R_UIRGBColor(red: 150, green: 150, blue: 150, alpha: 1).cgColor
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    lazy var forgetButton: UIButton = {
        let button = UIButton()
        let str:String = "忘记密码?"
        let size:CGSize = (button.titleLabel?.getStringSize(text: str, size:CGSize(width:SCREEN_WIDTH,height:14), font: 14))!
        button.setTitleColor(UIColor.R_UIRGBColor(red: 255, green: 255, blue: 255, alpha: 1), for: .normal)
        button.setTitle(str, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.frame = CGRect(x: 0, y: 0, width: size.width, height:14)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    
    @objc func onClick(_ sender:UIButton){
        switch sender.tag {
        case 0:
            self.loginOnClick()
            break
        case 1:
            let registerAndForgetPsdVC = RegisterAndForgetPsdVC()
            registerAndForgetPsdVC.registerAndForgetPsdType = .registerStatus
            registerAndForgetPsdVC.delegate = self
            self.navigationController?.pushViewController(registerAndForgetPsdVC, animated: true)
            break
        case 2:
            let registerAndForgetPsdVC = RegisterAndForgetPsdVC()
            registerAndForgetPsdVC.registerAndForgetPsdType = .forgetPsdStatus
            self.navigationController?.pushViewController(registerAndForgetPsdVC, animated: true)
            break
        default:
            break
        }
    }
    
}
