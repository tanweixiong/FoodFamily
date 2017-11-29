//
//  FoodReservationPayVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD

enum FoodPaymentMethodStatus {
    case normalPaymentStatus
    case reservationPaymentStatus
}

class FoodReservationPayVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,InputPaymentPasswordDelegate {
    fileprivate lazy var viewModel : FoodIntegralVM = FoodIntegralVM()
    fileprivate let dataScorce = [[""],["输入消费金额","钱包支付"],["积分券  "]]
    fileprivate let imageArray = [[""],["","ic_home_card"],["ic_home_wechat","ic_home_alipay"],["ic_home_wodejifen"]]
    fileprivate let foodReservationPayCell = "FoodReservationPayCell"
    fileprivate let foodReservationPaymentCardCell = "FoodReservationPaymentCardCell"
    fileprivate let foodReservationPaymentMethodCell = "FoodReservationPaymentMethodCell"
    fileprivate let foodPaymentConsumptionVC = "FoodPaymentConsumptionVC"
    fileprivate var indexPath = IndexPath()
    lazy var detailsModel : RecommendDataModel = RecommendDataModel()!
    var foodPaymentMethod = FoodPaymentMethodStatus.normalPaymentStatus
    var paymentMethod = OrderPaymentMethod.ordinaryPaymentStatus
    var payAppointmentTime = ""
    var payPhone = ""
    var payCode = ""
    var payStoreId = ""
    var payVould = ""
    var mealId = ""
    var payPrice = ""
    
    struct FoodReservationPayUX {
        static let foodReservationPayHeight:CGFloat = 90
        static let foodReservationPaymentMethodHeight:CGFloat = 44
        static let sectionHeight:CGFloat = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if foodPaymentMethod == .normalPaymentStatus {
            self.title = "支付"
        }else{
            self.title = "预约"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.addSubview(confirmBtn)
        self.getData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  dataScorce.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            let array:NSArray = self.dataScorce[section] as NSArray
            return array.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  indexPath.section == 0 ? FoodReservationPayUX.foodReservationPayHeight : FoodReservationPayUX.foodReservationPaymentMethodHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : FoodReservationPayUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodReservationPayUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headingArray = self.dataScorce[indexPath.section] as NSArray
        let imageViewArray = self.imageArray[indexPath.section] as NSArray
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationPayCell, for: indexPath) as! FoodReservationPayCell
            cell.selectionStyle = .none
            var logoUrl = ""
            if detailsModel.logo != nil{
                logoUrl = detailsModel.logo!
            }
     
            cell.iconImageView.sd_setImage(with: NSURL(string: logoUrl)! as URL, placeholderImage: UIImage.init(named: "ic_all_smallImageDefault"))
            cell.priceLabel.text = payPrice
            cell.storeNameLabel.text = self.detailsModel.storeName
            return cell
        }else if indexPath.section == 1 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodPaymentConsumptionVC, for: indexPath) as! FoodPaymentConsumptionVC
            cell.selectionStyle = .none
            cell.textfield.delegate = self
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationPaymentMethodCell, for: indexPath) as! FoodReservationPaymentMethodCell
            cell.chooseBtn.isSelected = (indexPath.section == 1 && indexPath.row == 1) ? true : false
            cell.selectionStyle = .none
            cell.headingLabel.text = headingArray[indexPath.row] as? String
            cell.iconImageView.image = UIImage.init(named: (imageViewArray[indexPath.row] as? String)!)
            if indexPath.section == 3 {
                let heading = headingArray[indexPath.row] as? String
                let newHeading = heading! + "(-10000抵扣100)"
                let priceString = NSMutableAttributedString.init(string: newHeading)
                priceString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSMakeRange((heading?.characters.count)!, newHeading.characters.count - (heading?.characters.count)!))
                cell.headingLabel.attributedText = priceString
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2  {
            let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section))as! FoodReservationPaymentMethodCell
            cell.chooseBtn.isSelected = !cell.chooseBtn.isSelected
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodReservationPayCell", bundle: nil),forCellReuseIdentifier: self.foodReservationPayCell)
        tableView.register(UINib(nibName: "FoodReservationPaymentCardCell", bundle: nil),forCellReuseIdentifier: self.foodReservationPaymentCardCell)
        tableView.register(UINib(nibName: "FoodReservationPaymentMethodCell", bundle: nil),forCellReuseIdentifier: self.foodReservationPaymentMethodCell)
        tableView.register(UINib(nibName: "FoodPaymentConsumptionVC", bundle: nil),forCellReuseIdentifier: self.foodPaymentConsumptionVC)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = R_UISectionLineColor
        tableView.tableFooterView = UIView()
        return tableView
    }()

    lazy var confirmBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect(x: 15, y: YMAKE(392) , width: SCREEN_WIDTH - 30, height: 50)
        btn.addTarget(self, action:  #selector(FoodReservationPayVC.confirmOnClick), for: .touchUpInside)
        btn.setTitle("确定支付 ¥99999.00", for: .normal)
        btn.backgroundColor = UIColor.R_UIRGBColor(red: 211, green: 178, blue: 105, alpha: 1)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        return btn
    }()
    
    func inputPaymentPasswordChangeBankCard() {
        let storeId = (self.detailsModel.storeId?.stringValue)!
        let payAppointmentTime = self.payAppointmentTime
        let payPhone = self.payPhone
        let payCode = self.payCode
        var price = "0"
        if self.detailsModel.reserPrice != nil {
            price = (self.detailsModel.reserPrice?.stringValue)!
        }
        let parameters = ["storeId":storeId,"price":price,"payAppointmentTime":payAppointmentTime,"payPhone":payPhone,"payCode":payCode]
        BaseViewModel.loadSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIOrderAddAppointmentOrderInfo, parameters: parameters, showIndicator: false) {
            SVProgressHUD.showSuccess(withStatus: "支付成功")
            let foodPurchaseSuccessVC = FoodPurchaseSuccessVC()
            self.navigationController?.pushViewController(foodPurchaseSuccessVC, animated: true)
        }
    }
    
    func getData(){
        let parameters = ["vouId":self.payVould,"mealId":self.mealId]
        viewModel.loadSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIUserWalletGetIntegralByUserId, parameters: parameters, showIndicator: false) {
            
        }
    }
    
    @objc func confirmOnClick(){
//        let foodPurchaseSuccessVC = FoodPurchaseSuccessVC()
//        foodPurchaseSuccessVC.paymentMethod = self.paymentMethod
//        self.navigationController?.pushViewController(foodPurchaseSuccessVC, animated: true)
        let view = InputPaymentPasswordVw(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        view?.delegate = self
        view?.setNeedPayPrice("12908")
        view?.setWalletBalance("20010")
        view?.show()
    }
    
}
