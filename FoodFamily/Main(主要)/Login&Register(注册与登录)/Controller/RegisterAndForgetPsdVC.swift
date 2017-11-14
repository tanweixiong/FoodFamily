//
//  RegisterVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/13.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

enum RegisterAndForgetPsdType {
    case registerStatus
    case forgetPsdStatus
}

class RegisterAndForgetPsdVC: MainViewController {
    var registerAndForgetPsdType = RegisterAndForgetPsdType.registerStatus
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
            self.getCodeButton.isHidden = true
        }
    }
    
    func createUI(){
        view.backgroundColor = R_UISectionLineColor
        view.addSubview(registerView)
        view.addSubview(getCodeButton)
        getCodeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(registerView.firstView.snp.centerY)
            make.right.equalTo(registerView.firstView.snp.right).offset(-15)
            make.width.equalTo(80)
            make.height.equalTo(28)
        }
    }
    
    @objc func getCodeClick(_ sender:UIButton){
//        let parameters = ["acount":"17876489945"]
          sender.start(withTime: 60, title: "重新获取", countDownTitle: "s", mainColor: UIColor.clear, count:   UIColor.R_UIRGBColor(red: 207, green: 207, blue: 207, alpha: 1))
    }
    
    //忘记密码
    override func rightTextBtn(_ sender: UIBarButtonItem) {

    }

    lazy var registerView: RegisterView = {
        let view = Bundle.main.loadNibNamed("RegisterView", owner: nil, options: nil)?.last as! RegisterView
        view.frame = CGRect(x: 0, y:0, width: SCREEN_WIDTH, height: RegisterAndForgetPsdUX.registerViewHeight)
        view.registerViewFinishCallBack = { () in
            let rigisterFinshVC = RigisterFinshVC()
            self.navigationController?.pushViewController(rigisterFinshVC, animated: true)
        }
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
}
