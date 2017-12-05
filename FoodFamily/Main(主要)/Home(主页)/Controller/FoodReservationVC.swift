//
//  FoodReservationVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD

class FoodReservationVC: UIViewController,UITableViewDelegate,UITableViewDataSource,FoodSelectNumberReservationsDelegate,FoodSelectNumberPeopleDelegate,UITextFieldDelegate {
    var detailsModel : RecommendDataModel = RecommendDataModel()!
    fileprivate lazy var viewModel : FoodReservationVM = FoodReservationVM()
    fileprivate let dataScore:NSArray = ["预约人数","预约时间","请手机号输入","验证码填写","需支付预金"]
    fileprivate let foodReservationCell = "FoodReservationCell"
    fileprivate let foodReservationCodeCell = "FoodReservationCodeCell"
    fileprivate let foodReservationFilliCell = "FoodReservationFilliCell"
    fileprivate var foodReservationCodeText = ""
    fileprivate var reservationsTime = ""
    fileprivate var reservationsNumber = ""
    fileprivate var reserPrice = "0"
    fileprivate var codeTextField = UITextField()
    fileprivate var phoneTextField = UITextField()
    fileprivate var dayIndexPath = NSIndexPath(row: 0, section: 0)
    fileprivate var timeIndexPath = NSIndexPath(row: 0, section: 0)
    
    struct FoodReservationUX {
        static let rowHeight:CGFloat = 44
        static let sectionHeight:CGFloat = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.alpha = 1
        self.title = "预约"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.addSubview(nextBtn)
        print(detailsModel.storeName!);
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FoodReservationUX.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? FoodReservationUX.sectionHeight/2 : FoodReservationUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodReservationUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let foodSelectNumberPeopleVw = FoodSelectNumberPeopleVw(frame: CGRect(x: 0, y: 0, width: (UIApplication.shared.keyWindow?.bounds.width)!, height: (UIApplication.shared.keyWindow?.bounds.height)!))
            foodSelectNumberPeopleVw.delegate = self
            UIApplication.shared.keyWindow?.addSubview(foodSelectNumberPeopleVw)
        }else if indexPath.section == 1 {
            let view = FoodSelectNumberReservationsVw(frame: CGRect(x: 0, y: 0, width: (UIApplication.shared.keyWindow?.bounds.width)!, height: (UIApplication.shared.keyWindow?.bounds.height)!),day: dayIndexPath,time: timeIndexPath)
            view.delegate = self
            UIApplication.shared.keyWindow?.addSubview(view)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.closeKeyboard()
    }
    
    func foodSelectNumberReservationsChoose(_ day: String, _ time: String, _ dayIndexPath: NSIndexPath, _ timeIndexPath: NSIndexPath) {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1))as! FoodReservationCell
        var newDay = day
        let range = newDay.index(newDay.endIndex, offsetBy: -3)..<newDay.index(newDay.endIndex, offsetBy: -2)
        newDay.replaceSubrange(range, with: "月")
        newDay = newDay + "日" + " " + time
        reservationsTime = newDay
        cell.dataLabel.text = newDay
        self.timeIndexPath = timeIndexPath
        self.dayIndexPath = dayIndexPath
    }
    
    //选择预约人数
    func foodSelectNumberPeopleChoose(_ data:String){
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))as! FoodReservationCell
        reservationsNumber = data
        cell.dataLabel.text = reservationsNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationCell, for: indexPath) as! FoodReservationCell
            cell.selectionStyle = .none
            cell.chooseView.isHidden = indexPath.section == 0 || indexPath.section == 1 ? false : true
            cell.priceLabel.isHidden = indexPath.section == 4 ? false : true
            reserPrice = "0"
            if self.detailsModel.reserPrice != nil{
                reserPrice = (self.detailsModel.reserPrice?.stringValue)!
            }
            cell.priceLabel.text = "¥" + reserPrice
            cell.headingLabel.text = self.dataScore[indexPath.section] as? String
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationCodeCell, for: indexPath) as! FoodReservationCodeCell
            cell.phoneTextField.delegate = self
            phoneTextField = cell.phoneTextField
            cell.contentView.addSubview(getCodeButton)
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationFilliCell, for: indexPath) as! FoodReservationFilliCell
            cell.selectionStyle = .none
            cell.headingLabel.text = self.dataScore[indexPath.section] as? String
            cell.codeTextField.delegate = self
            codeTextField = cell.codeTextField
            cell.foodReservationFillTextFiledCallBack = { (codeStr:String) in
                self.foodReservationCodeText = codeStr
            }
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //去除section移动
        let sectionHeaderHeight:CGFloat = FoodReservationUX.sectionHeight
        if scrollView == self.tableView {
            if scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0 {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            }else if scrollView.contentOffset.y >= FoodReservationUX.sectionHeight {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength:Int = 0
        if textField == self.phoneTextField {
            maxLength = 11
        }else if textField == self.codeTextField{
            maxLength = 8
        }
        //限制长度
        let proposeLength = (textField.text?.lengthOfBytes(using: String.Encoding.utf8))! - range.length + string.lengthOfBytes(using: String.Encoding.utf8)
        if proposeLength > maxLength { return false }
        return true
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodReservationCell", bundle: nil),forCellReuseIdentifier: self.foodReservationCell)
        tableView.register(UINib(nibName: "FoodReservationCodeCell", bundle: nil),forCellReuseIdentifier: self.foodReservationCodeCell)
        tableView.register(UINib(nibName: "FoodReservationFilliCell", bundle: nil),forCellReuseIdentifier: self.foodReservationFilliCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var nextBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect(x: 15, y: YMAKE(370) , width: SCREEN_WIDTH - 30, height: 50)
        btn.addTarget(self, action:  #selector(FoodReservationVC.nextOnClick), for: .touchUpInside)
        btn.setTitle("下一步", for: .normal)
        btn.backgroundColor = UIColor.R_UIRGBColor(red: 211, green: 178, blue: 105, alpha: 1)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        return btn
    }()
    
    lazy var getCodeButton: UIButton = {
        let button = UIButton()
        let width:CGFloat = 80
        let height:CGFloat = 28
        button.frame = CGRect(x: SCREEN_WIDTH - 15 - width, y: FoodReservationUX.rowHeight/2 - height/2, width: width, height: height)
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
    
    @objc func nextOnClick(){
        if checkInpunt() {
            let vc = FoodReservationPayVC()
            vc.foodPaymentMethod = .reservationPaymentStatus
            vc.payStoreId = (self.detailsModel.storeId?.stringValue)!
            vc.payPrice = self.reserPrice
            vc.payAppointmentNum = reservationsNumber
            vc.payAppointmentTime = reservationsTime
            vc.payPhone = phoneTextField.text!
            vc.payCode = codeTextField.text!
            vc.detailsModel = self.detailsModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //获取验证码
    @objc func getCodeClick(_ sender:UIButton){
        if Tools.validateMobile(mobile:phoneTextField.text!) {
            let parameters =  ["acount":phoneTextField.text!]
            BaseViewModel.loadSuccessfullyReturnedData(requestType: .post, URLString: ConstAPI.kAPIUserGetPhoneCode, parameters: parameters, showIndicator: false) {
                sender.start(withTime: 60, title: "重新获取", countDownTitle: "s", mainColor: UIColor.clear, count:UIColor.clear)
                SVProgressHUD.showSuccess(withStatus: "验证码发送成功")
            }
        }else{
            SVProgressHUD.showInfo(withStatus: "请输入正确的手机号码")
        }
    }
    
    func checkInpunt()->Bool{
        if reservationsNumber.characters.count == 0 && reservationsTime.characters.count == 0 && !Tools.validateMobile(mobile: phoneTextField.text!) && !Tools.validateCode(code: codeTextField.text!) {
            SVProgressHUD.showInfo(withStatus: "输入不能为空")
            return false
        }
        
        if reservationsNumber.characters.count == 0 {
            SVProgressHUD.showInfo(withStatus: "请输入预约人数")
            return false
        }
        
        if reservationsTime.characters.count == 0 {
            SVProgressHUD.showInfo(withStatus: "请输入预约时间")
            return false
        }
        
        if !Tools.validateMobile(mobile: phoneTextField.text!) {
            SVProgressHUD.showInfo(withStatus: "请输入正确的手机号码")
            return false
        }
        
        if !Tools.validateCode(code: codeTextField.text!) {
            SVProgressHUD.showInfo(withStatus: "请输入正确的验证码")
            return false
        }
        return true
    }
    
}
