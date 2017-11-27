//
//  MineSetPayPasswordVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/13.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD

enum MineSetPayPasswordType {
    case setPayPasswordStatus
    case getBackPayPasswordStatus
}
class MineSetPayPasswordVC: MainViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    fileprivate let mineSetPayPasswordCell = "MineSetPayPasswordCell"
    var mineSetPayPasswordType = MineSetPayPasswordType.setPayPasswordStatus
//    fileprivate var setPayPasswordHeadingArray = [["当前密码"],["设置密码","确认密码"]]
//    fileprivate var setPayPasswordHeadingContentArray = [["请输入支付密码"],["输入交易密码","重复输入密码"]]
    fileprivate var getBackPasswordHeadingArray = [["手机号"],["验证码","密码"]]
    fileprivate var getBackPasswordHeadingContentArray = [["手机号"],["请输入验证码","请输入支付密码"]]
    fileprivate var dataSource = NSMutableArray()
    fileprivate var headingContentDataSource = NSMutableArray()
    fileprivate var phoneCell = MineSetPayPasswordCell()
    fileprivate var codeCell = MineSetPayPasswordCell()
    fileprivate var passwordCell = MineSetPayPasswordCell()
    struct MineSetPayPasswordUX {
        static let cellHeight:CGFloat = YMAKE(44)
        static let sectionHeight:CGFloat = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCloseRoundKeyboard()
        self.dataSource.removeAllObjects()
        self.headingContentDataSource.removeAllObjects()
        if mineSetPayPasswordType == .setPayPasswordStatus {
           self.title = "设置支付密码"
            self.dataSource.addObjects(from: getBackPasswordHeadingArray)
            self.headingContentDataSource.addObjects(from: getBackPasswordHeadingContentArray)
        }else{
           self.title = "找回支付密码"
           self.dataSource.addObjects(from: getBackPasswordHeadingArray)
          self.headingContentDataSource.addObjects(from: getBackPasswordHeadingContentArray)
        }
        view.addSubview(tableView)
        self.addDefaultButtonTextRight("完成")
    }
    
    @objc func getCodeClick(_ sender:UIButton){
        let phoneCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))as! MineSetPayPasswordCell
        if Tools.validateMobile(mobile: phoneCell.textfield.text!) {
            let parameters =  ["acount":phoneCell.textfield.text!]
            BaseViewModel.loadSuccessfullyReturnedData(requestType: .post, URLString: ConstAPI.kAPIUserGetPhoneCode, parameters: parameters, showIndicator: false) {
                sender.start(withTime: 60, title: "重新获取", countDownTitle: "s", mainColor: UIColor.clear, count:UIColor.clear)
                SVProgressHUD.showSuccess(withStatus: "验证码发送成功")
            }
        }else{
            SVProgressHUD.showInfo(withStatus: "请输入正确的手机号码")
        }
    }
    
    override func rightTextBtn(_ sender: UIBarButtonItem) {
        if mineSetPayPasswordType == .setPayPasswordStatus  {
            self.setPayPassword()
        }else{
            self.forgotPayPassword()
        }
    }
    
    //设置支付密码
    func setPayPassword(){
       self.phoneCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))as! MineSetPayPasswordCell
       self.codeCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1))as! MineSetPayPasswordCell
       self.passwordCell = tableView.cellForRow(at: IndexPath(row: 1, section: 1))as! MineSetPayPasswordCell
        if checkTheInput() {
            let parameters =  ["spassword":passwordCell.textfield.text!,"code":codeCell.textfield.text!,"acount":phoneCell.textfield.text!]
            BaseViewModel.loadSuccessfullyReturnedData(requestType: .post, URLString: ConstAPI.kAPIUserSetSpassword, parameters: parameters, showIndicator: false) {
                let userInfo = UserDefaults.standard.getUserInfo()
                userInfo.spassword = self.passwordCell.textfield.text! as AnyObject
                UserDefaults.standard.saveCustomObject(customObject: userInfo, key: R_UserInfo)
                SVProgressHUD.showSuccess(withStatus: "已设置支付密码")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    SVProgressHUD.dismiss()
                    self.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
    
    //修改支付密码
    func forgotPayPassword(){
        self.phoneCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))as! MineSetPayPasswordCell
        self.codeCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1))as! MineSetPayPasswordCell
        self.passwordCell = tableView.cellForRow(at: IndexPath(row: 1, section: 1))as! MineSetPayPasswordCell
        if checkTheInput() {
              let parameters =  ["spassword":passwordCell.textfield.text!,"code":codeCell.textfield.text!,"acount":phoneCell.textfield.text!]
            BaseViewModel.loadSuccessfullyReturnedData(requestType: .post, URLString: ConstAPI.kAPIUserSetSpassword, parameters: parameters, showIndicator: false) {
                SVProgressHUD.showSuccess(withStatus: "找回支付密码成功")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    SVProgressHUD.dismiss()
                    self.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
    
    func checkTheInput()->Bool{
        if !Tools.validateMobile(mobile: self.phoneCell.textfield.text!) && !Tools.validateCode(code: self.codeCell.textfield.text!)  && !Tools.validatePassword(password: self.passwordCell.textfield.text!) {
            SVProgressHUD.showInfo(withStatus: "输入不能为空")
            return false
        }
        
        if !Tools.validateMobile(mobile: self.phoneCell.textfield.text!) {
            SVProgressHUD.showInfo(withStatus: "请输入正确的手机号码")
            return false
        }
        
        if !Tools.validateCode(code: self.codeCell.textfield.text!) {
            SVProgressHUD.showInfo(withStatus: "请输入正确的验证码")
            return false
        }
        
        if !Tools.validatePassword(password: self.passwordCell.textfield.text!) {
            SVProgressHUD.showInfo(withStatus: "请输入6-20个字符数组或者字母的密码")
            return false
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength:Int = 0
        self.phoneCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))as! MineSetPayPasswordCell
        self.codeCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1))as! MineSetPayPasswordCell
        self.passwordCell = tableView.cellForRow(at: IndexPath(row: 1, section: 1))as! MineSetPayPasswordCell
        if textField == self.phoneCell.textfield {
            maxLength = 11
        }else if textField == self.codeCell.textfield{
            maxLength = 8
        }else if textField == self.passwordCell.textfield{
            maxLength = 6
        }
        //限制长度
        let proposeLength = (textField.text?.lengthOfBytes(using: String.Encoding.utf8))! - range.length + string.lengthOfBytes(using: String.Encoding.utf8)
        if proposeLength > maxLength { return false }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array:NSArray = dataSource[section] as! NSArray
        return array.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineSetPayPasswordUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : MineSetPayPasswordUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineSetPayPasswordUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineSetPayPasswordCell, for: indexPath) as! MineSetPayPasswordCell
        cell.selectionStyle = .none
        let headingArray:NSArray = self.dataSource[indexPath.section] as! NSArray
        cell.headingLabel.text = headingArray[indexPath.row] as? String
        let headingContentArray:NSArray = self.headingContentDataSource[indexPath.section] as! NSArray
        cell.textfield.placeholder = headingContentArray[indexPath.row] as? String
        cell.textfield.delegate = self
        if indexPath.section == 0{
            cell.contentView.addSubview(self.getCodeButton)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineSetPayPasswordCell", bundle: nil),forCellReuseIdentifier: self.mineSetPayPasswordCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    lazy var getCodeButton: UIButton = {
        let button = UIButton()
        let width:CGFloat = 80
        let height:CGFloat = 28
        button.frame = CGRect(x: SCREEN_WIDTH - 15 - width, y: MineSetPayPasswordUX.cellHeight/2 - height/2, width: width, height: height)
        button.setTitleColor(UIColor.R_UIRGBColor(red: 255, green: 92, blue: 132, alpha: 1), for: .normal)
        button.setTitle("获取验证码", for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1).cgColor
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(getCodeClick(_:)), for: .touchUpInside)
        button.tag = 0
        return button
    }()

}
