//
//  AddBankCardDetailVC.swift
//  AGTMall
//
//  Created by tam on 2017/10/19.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD

class MineAddBankCardDetailVC: MainViewController {
    
    struct AddBankCardDetailUX {
        static let finishBtnHeight:CGFloat = YMAKE(50)
        static let finishBtnFont:CGFloat = 16
        static let finishBtnCorner:CGFloat = 5
        static let getCodeBtnCornerRadius:CGFloat = 5
        static let textFieldHeight:CGFloat  = YMAKE(44)
        static let getCodeBtnWidth:CGFloat = 100
        static let getCodeBtnHeight:CGFloat = YMAKE(30)
        static let getCodeBtnFont:CGFloat = 12
        static let space:CGFloat = 15
        static let textFildWidth:CGFloat = 160
    }

    var time:Int = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = R_UISectionLineColor
        self.title = "银行卡添加"
        self.setCloseRoundKeyboard()
        self.createUI()
    }
    
    func createUI(){
        
        view.addSubview(phoneTextField)
        view.addSubview(codeTextField)
        view.addSubview(getCodeBtn)
        view.addSubview(finishBtn)
        
        phoneTextField.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(0)
            make.left.equalTo(AddBankCardDetailUX.space)
            make.right.equalTo(-AddBankCardDetailUX.space)
            make.height.equalTo(AddBankCardDetailUX.textFieldHeight)
        }
        
        codeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(phoneTextField.snp.bottom).offset(0)
            make.left.equalTo(AddBankCardDetailUX.space)
            make.right.equalTo(-AddBankCardDetailUX.space)
            make.height.equalTo(AddBankCardDetailUX.textFieldHeight)
        }
        
        getCodeBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(phoneTextField.snp.centerY).offset(0)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.width.equalTo(XMAKE(AddBankCardDetailUX.getCodeBtnWidth))
            make.height.equalTo(XMAKE(AddBankCardDetailUX.getCodeBtnHeight))
        }
        
        finishBtn.snp.makeConstraints { (make) in
            make.top.equalTo(codeTextField.snp.bottom).offset(YMAKE(80))
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(SCREEN_WIDTH - AddBankCardDetailUX.space * 2)
            make.height.equalTo(AddBankCardDetailUX.finishBtnHeight)
        }
        
    }
    
    @objc func finish(_ sender:UIButton){
        self.navigationController?.pushViewController(MineAddBankCardFinishVC(), animated: true)
    }
    
    @objc func getCode(_ sender:UIButton){
        self.getCodeBtn.isEnabled = false;
          sender.start(withTime: 60, title: "重新获取", countDownTitle: "s", mainColor: UIColor.clear, count:   UIColor.R_UIRGBColor(red: 207, green: 207, blue: 207, alpha: 1))
    }
    
    func checkInput() -> Bool{
        
        if !Tools.validateMobile(mobile: phoneTextField.AGTextField.text!) && codeTextField.AGTextField.text!.characters.count == 0{
            SVProgressHUD.showInfo(withStatus: "输入不能为空")
            return false
        }
        
        if !Tools.validateMobile(mobile: phoneTextField.AGTextField.text!) {
             SVProgressHUD.showInfo(withStatus: "请输入正确的手机号")
            return false
        }

        if codeTextField.AGTextField.text!.characters.count == 0 {
             SVProgressHUD.showInfo(withStatus: "请输入正确的验证码")
            return false
        }

        return true
    }
    
    lazy var phoneTextField: InputView = {
        let textField = InputView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - AddBankCardDetailUX.space * 2, height: AddBankCardDetailUX.textFieldHeight))
        textField.iconImageView.image = UIImage(named: "login_password")
        textField.AGTextField.placeholder = "密码设置"
        textField.AGTextField.textColor = UIColor.R_UIRGBColor(red: 144, green: 144, blue: 144, alpha: 1)
        textField.AGTextField.frame.size.width = AddBankCardDetailUX.textFildWidth
        return textField
    }()
    
    lazy var codeTextField: InputView = {
        let textField = InputView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - AddBankCardDetailUX.space * 2, height: AddBankCardDetailUX.textFieldHeight))
        textField.iconImageView.image = UIImage(named: "login_phone")
        textField.AGTextField.placeholder = "请输入手机号"
        textField.AGTextField.keyboardType = .phonePad
        textField.AGTextField.textColor = UIColor.R_UIRGBColor(red: 144, green: 144, blue: 144, alpha: 1)
        textField.AGTextField.frame.size.width = AddBankCardDetailUX.textFildWidth
        return textField
    }()
    
    lazy var getCodeBtn: UIButton = {
        let button = UIButton()
        button.setTitle("获取验证码", for: .normal)
        button.setTitleColor(UIColor.R_UIColorFromRGB(color: 0x333333), for: .normal)
        button.layer.cornerRadius = AddBankCardDetailUX.getCodeBtnCornerRadius
        button.layer.borderColor = UIColor.R_UIColorFromRGB(color: 0x333333).cgColor
        button.layer.borderWidth = 0.5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(getCode(_:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: AddBankCardDetailUX.getCodeBtnFont)
        return button
    }()
    
    lazy var finishBtn: UIButton = {
        let btn = UIButton.setBtnBoarderCorner(radius: AddBankCardDetailUX.finishBtnCorner)
        btn.backgroundColor = UIColor.clear
        btn.setTitle("完成", for: UIControlState.normal)
        btn.setTitleColor(R_UIThemeGoldColor, for: UIControlState.normal)
        btn.setTitleColor(UIColor.R_UIRGBColor(red: 144, green: 144, blue: 144, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: AddBankCardDetailUX.finishBtnFont)
        btn.layer.borderColor = R_UIThemeGoldColor.cgColor
        btn.clipsToBounds = true
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(finish(_:)), for: .touchUpInside)
        return btn
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
