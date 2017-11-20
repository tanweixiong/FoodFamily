//
//  RegisterVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/13.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD

enum RegisterAndForgetPsdType {
    case registerStatus
    case forgetPsdStatus
}

protocol RegisterAndForgetPsdDeleagte {
    func registerAndForgetPsdFinish(account:String,password:String)
}
class RegisterAndForgetPsdVC: MainViewController,UITextFieldDelegate {
    var registerAndForgetPsdType = RegisterAndForgetPsdType.registerStatus
    var delegate:RegisterAndForgetPsdDeleagte?
    struct RegisterAndForgetPsdUX {
        static let registerViewHeight:CGFloat = SCREEN_HEIGHT
    }

    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "注册"
         self.setCloseRoundKeyboard()
         self.createUI()
        if registerAndForgetPsdType == .forgetPsdStatus{
            self.addDefaultButtonTextRight("确定")
            self.registerView.finishButton.isHidden = true
            self.registerView.recommendView.isHidden = true
        }
    }
    
    func createUI(){
        view.backgroundColor = R_UISectionLineColor
        view.addSubview(registerView)
        view.addSubview(codeView)
        codeView.addSubview(getCodeButton)
        
        codeView.snp.makeConstraints { (make) in
            make.centerY.equalTo(registerView.firstView.snp.centerY)
            make.right.equalTo(registerView.firstView.snp.right).offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(registerView.firstView.frame.height)
        }
        
        getCodeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(codeView.snp.centerY)
            make.centerX.equalTo(codeView.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(registerView.firstView.frame.height - 10)
        }
    }
    
    //获取验证码
    @objc func getCodeClick(_ sender:UIButton){
        if Tools.validateMobile(mobile: registerView.phoneTextField.text!) {
            let parameters =  ["acount":registerView.phoneTextField.text!]
            BaseViewModel.loadSuccessfullyReturnedData(requestType: .post, URLString: ConstAPI.kAPIUserGetPhoneCode, parameters: parameters, showIndicator: false) {
                sender.start(withTime: 60, title: "重新获取", countDownTitle: "s", mainColor: UIColor.clear, count:UIColor.clear)
                SVProgressHUD.showSuccess(withStatus: "验证码发送成功")
            }
        }else{
            SVProgressHUD.showInfo(withStatus: "请输入正确的手机号码")
        }
    }
    
    //忘记密码
    override func rightTextBtn(_ sender: UIBarButtonItem) {
        if checkTheInput() {
     let parameters =  ["acount":registerView.phoneTextField.text!,"code":registerView.codeTextField.text!,"password":registerView.passwordTextField.text!]
            BaseViewModel.loadSuccessfullyReturnedData(requestType: .post, URLString: ConstAPI.kAPIUserForgetPassword, parameters: parameters, showIndicator: false) {
                SVProgressHUD.showSuccess(withStatus: "找回密码成功,请直接登录")
                self.delegate?.registerAndForgetPsdFinish(account: self.registerView.phoneTextField.text!,password: self.registerView.passwordTextField.text!)
                 self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    //注册账号
    func registerOnClick(){
        if checkTheInput() {
           let parameters =  ["acount":registerView.phoneTextField.text!,"code":registerView.codeTextField.text!,"password":registerView.passwordTextField.text!,"type":"1","recommend":registerView.recommendTextField.text!]
            BaseViewModel.loadSuccessfullyReturnedData(requestType: .post, URLString: ConstAPI.kAPIUserRegister, parameters: parameters, showIndicator: false) {
                SVProgressHUD.show(withStatus: "注册成功")
                self.delegate?.registerAndForgetPsdFinish(account: self.registerView.phoneTextField.text!,password: self.registerView.passwordTextField.text!)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                    SVProgressHUD.dismiss()
                    self.navigationController?.popViewController(animated: true)
                })
   
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength:Int = 0
        if textField == registerView.phoneTextField {
            maxLength = 11
        }else if textField == registerView.codeTextField{
            maxLength = 8
        }else if textField == registerView.passwordTextField{
            maxLength = 20
        }
        //限制长度
        let proposeLength = (textField.text?.lengthOfBytes(using: String.Encoding.utf8))! - range.length + string.lengthOfBytes(using: String.Encoding.utf8)
        if proposeLength > maxLength { return false }
        return true
    }
    
    func checkTheInput()->Bool{

        if !Tools.validateMobile(mobile: registerView.phoneTextField.text!) && !Tools.validateCode(code: registerView.codeTextField.text!)  && !Tools.validatePassword(password: registerView.passwordTextField.text!) {
            SVProgressHUD.showInfo(withStatus: "输入不能为空")
            return false
        }
        
        if !Tools.validateMobile(mobile: registerView.phoneTextField.text!) {
            SVProgressHUD.showInfo(withStatus: "请输入正确的手机号码")
            return false
        }
        
        if !Tools.validateCode(code: registerView.codeTextField.text!) {
            SVProgressHUD.showInfo(withStatus: "请输入正确的验证码")
            return false
        }
        
        if !Tools.validatePassword(password: registerView.passwordTextField.text!) {
            SVProgressHUD.showInfo(withStatus: "请输入6-20个字符数组或者字母的密码")
            return false
        }
        return true
    }

    lazy var registerView: RegisterView = {
        let view = Bundle.main.loadNibNamed("RegisterView", owner: nil, options: nil)?.last as! RegisterView
        view.frame = CGRect(x: 0, y:0, width: SCREEN_WIDTH, height: RegisterAndForgetPsdUX.registerViewHeight)
        view.registerViewFinishCallBack = { () in
            self.registerOnClick()
        }
        view.phoneTextField.delegate = self
        view.phoneTextField.keyboardType = .phonePad
        
        view.codeTextField.keyboardType = .numberPad
        view.codeTextField.delegate = self
        
        view.passwordTextField.delegate = self
        return view
    }()
    
    lazy var getCodeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.R_UIRGBColor(red: 43, green: 43, blue: 43, alpha: 1), for: .normal)
        button.setTitle("获取验证码", for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.R_UIRGBColor(red: 244, green: 244, blue: 244, alpha: 1).cgColor
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(getCodeClick(_:)), for: .touchUpInside)
        button.tag = 0
        return button
    }()
    
    lazy var codeView: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor.orange
        return view
    }()
}
