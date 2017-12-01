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
    case voucherPaymentStatus       //代金券支付
    case mealPaymentStatus         //套餐支付
    case reservationPaymentStatus //预约支付
    case immediatelyPaymentStatus //立即支付方式
}

class FoodReservationPayVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,InputPaymentPasswordDelegate {
    
    fileprivate lazy var integralViewModel : FoodIntegralVM = FoodIntegralVM()
    fileprivate lazy var payViewModel : FoodPaymentMethodVM = FoodPaymentMethodVM()
    fileprivate lazy var walletViewModel : MineWalletVM = MineWalletVM()
    fileprivate var dataScorce = [[""],["输入消费金额","钱包支付"],["积分券  "]]
    fileprivate var imageArray = [[""],["","ic_home_card"],["ic_home_wechat","ic_home_alipay"],["ic_home_wodejifen"]]
    fileprivate let foodReservationPayCell = "FoodReservationPayCell"
    fileprivate let foodReservationPaymentCardCell = "FoodReservationPaymentCardCell"
    fileprivate let foodReservationPaymentMethodCell = "FoodReservationPaymentMethodCell"
    fileprivate let foodPaymentConsumptionVC = "FoodPaymentConsumptionVC"
    fileprivate var indexPath = IndexPath()
    fileprivate var totalNumTextField = UITextField()
    fileprivate var currentAmount = ""
    fileprivate var payPassword = ""
    fileprivate var walletPrice = ""
    
    var detailsModel : RecommendDataModel = RecommendDataModel()!
    var mealModel: RecommendMealDataModel = RecommendMealDataModel()!
    var voucherModel: RecommendVoucherDataModel = RecommendVoucherDataModel()!

    var foodPaymentMethod = FoodPaymentMethodStatus.voucherPaymentStatus
//    var paymentMethod = OrderPaymentMethod.ordinaryPaymentStatus
    var payAppointmentTime = ""
    var payAppointmentNum = ""
    var payPhone = ""
    var payCode = ""
    var payStoreId = ""
    var payPrice = ""
    var ecPrice = ""
    
    struct FoodReservationPayUX {
        static let foodReservationPayHeight:CGFloat = 90
        static let foodReservationPaymentMethodHeight:CGFloat = 44
        static let sectionHeight:CGFloat = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.closeKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if foodPaymentMethod == .reservationPaymentStatus {
            self.title = "预约"
        }else{
            self.title = "支付"
        }
        if foodPaymentMethod == .voucherPaymentStatus || foodPaymentMethod == .mealPaymentStatus || foodPaymentMethod == .reservationPaymentStatus {
            self.dataScorce = [[""],["钱包支付"],["积分券  "]]
            self.imageArray = [[""],["ic_home_card"],["ic_home_wodejifen"]]
        }
        //如果代金券和套餐则加载积分
        if foodPaymentMethod == .voucherPaymentStatus || foodPaymentMethod == .mealPaymentStatus {
            self.getConsumptionIntegral()
            //如果立即支付和预约支付则使用钱包
        }else{
            self.getWallet()
        }
        self.indexPath = NSIndexPath(row: 0, section: 2) as IndexPath

        view.addSubview(tableView)
        tableView.addSubview(confirmBtn)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if foodPaymentMethod == .reservationPaymentStatus{
            return dataScorce.count - 1
        }
        //0不能抵扣 1可以抵扣
        if integralViewModel.model.canDe == 0 {
            return dataScorce.count - 1
        }
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
        }else if (indexPath.section == 1 && indexPath.row == 0) && (foodPaymentMethod == .immediatelyPaymentStatus) {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodPaymentConsumptionVC, for: indexPath) as! FoodPaymentConsumptionVC
            cell.selectionStyle = .none
            cell.textfield.delegate = self
            cell.textfield.keyboardType = .numberPad
            totalNumTextField = cell.textfield
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationPaymentMethodCell, for: indexPath) as! FoodReservationPaymentMethodCell
            cell.chooseBtn.isSelected = (indexPath.section == 1 && indexPath.row == 0) ? true : false
            cell.selectionStyle = .none
            cell.headingLabel.text = headingArray[indexPath.row] as? String
            cell.iconImageView.image = UIImage.init(named: (imageViewArray[indexPath.row] as? String)!)
            if indexPath.section == 2 {
                let heading = headingArray[indexPath.row] as? String
                var deduction = heading!
                //获取抵扣金额
                if integralViewModel.model.canDe == 1 && integralViewModel.model.totalPrice != 0 && integralViewModel.model.deduction != 0 {
                    deduction = deduction + "(" + "-" + (integralViewModel.model.totalPrice?.stringValue)! + "抵扣" + (integralViewModel.model.deduction?.stringValue)! + ")"
                }
                let priceString = NSMutableAttributedString.init(string: deduction)
                priceString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSMakeRange((heading?.characters.count)!, deduction.characters.count - (heading?.characters.count)!))
                cell.headingLabel.attributedText = priceString
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2  {
            //观察选项是否能够进行抵扣
            let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section))as! FoodReservationPaymentMethodCell
            cell.chooseBtn.isSelected = !cell.chooseBtn.isSelected
            //观察是否能够选中
//            if cell.chooseBtn.isSelected {
//                self.currentAmount = (self.integralViewModel.model.price?.stringValue)!
//                self.confirmBtn.setTitle(self.currentAmount, for: .normal)
//            }else{
//                self.currentAmount = self.payPrice
//                self.confirmBtn.setTitle(self.currentAmount, for: .normal)
//            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == totalNumTextField {
//            let num = Int(self.totalNumTextField.text!)! * Int(self.currentAmount)!
//            let str = "\(num)"
//            self.confirmBtn.setTitle(str, for: .normal)
//        }
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
        btn.setTitle("确定支付", for: .normal)
        btn.backgroundColor = UIColor.R_UIRGBColor(red: 211, green: 178, blue: 105, alpha: 1)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        return btn
    }()
    
    func inputPaymentPasswordChangeBankCard() {
        
    }
    
    //操作成功返回
    func inputPaymentPassword(_ pwd: String!) -> String! {
        self.payPassword = pwd
        if foodPaymentMethod == .mealPaymentStatus {
            self.mealPayment()
        }else if foodPaymentMethod == .voucherPaymentStatus {
            self.vouchersPayment()
        }else if foodPaymentMethod == .reservationPaymentStatus {
            self.reservationPayment()
        }else if foodPaymentMethod == .immediatelyPaymentStatus {
            
        }
        return pwd
    }
    
    //预约支付
    func reservationPayment(){
        let spassword = self.payPassword
        let storeId = (self.detailsModel.storeId?.stringValue)!
        var reserPrice = ""
        let appointmentNum = self.payAppointmentNum
        let appointmentTime = self.payAppointmentTime
        let payPhone = self.payPhone
        let payCode = self.payCode
        if self.detailsModel.reserPrice != nil {
            reserPrice = (self.detailsModel.reserPrice?.stringValue)!
        }
        let parameters = ["spassword":spassword,"storeId":storeId,"reserPrice":reserPrice,"appointmentNum":appointmentNum,"appointmentTime":appointmentTime,"phone":payPhone,"code":payCode]
        SVProgressHUD.show(withStatus: "请稍等")
        payViewModel.loadReservationPaySuccessfullyReturnedData(requestType: .post, URLString: ConstAPI.kAPIOrderAddAppointmentOrderInfo, parameters: parameters, showIndicator: false) {
            SVProgressHUD.showSuccess(withStatus: "支付成功")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                let foodPurchaseSuccessVC = FoodPurchaseSuccessVC()
                foodPurchaseSuccessVC.ecPrice = reserPrice
                foodPurchaseSuccessVC.paymentMethod = .reservationPaymentStatus
                self.navigationController?.pushViewController(foodPurchaseSuccessVC, animated: true)
            })
        }
    }

    //套餐支付
    func mealPayment(){
        let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section))as! FoodReservationPaymentMethodCell
        let mealId = (self.mealModel.mealId?.stringValue)!
        let storeId = (self.detailsModel.storeId?.stringValue)!
        let spassword = self.payPassword
        let point = cell.chooseBtn.isSelected ? (integralViewModel.model.totalPrice?.stringValue)! : "0"
        let parameters = ["mealId":mealId,"storeId":storeId,"point":point,"spassword":spassword]
        SVProgressHUD.show(withStatus: "请稍等")
        payViewModel.loadMealPaySuccessfullyReturnedData(requestType: .post, URLString: ConstAPI.kAPIOrderAddMealOrderInfo, parameters: parameters, showIndicator: false) {
            SVProgressHUD.showSuccess(withStatus: "支付成功")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                let foodPurchaseSuccessVC = FoodPurchaseSuccessVC()
                foodPurchaseSuccessVC.ecPrice = self.ecPrice
                foodPurchaseSuccessVC.paymentMethod = .mealPaymentStatus
                self.navigationController?.pushViewController(foodPurchaseSuccessVC, animated: true)
            })
        }
    }
    
    //代金券支付
    func vouchersPayment(){
        let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section))as! FoodReservationPaymentMethodCell
        let vouId = (self.voucherModel.voucherId?.stringValue)!
        let storeId = (self.detailsModel.storeId?.stringValue)!
        let spassword = self.payPassword
        let point = cell.chooseBtn.isSelected ? (integralViewModel.model.totalPrice?.stringValue)! : "0"
        let parameters = ["vouId":vouId,"storeId":storeId,"point":point,"spassword":spassword]
        SVProgressHUD.show(withStatus: "请稍等")
        payViewModel.loadMealPaySuccessfullyReturnedData(requestType: .post, URLString: ConstAPI.kAPIOrderAddVouOrderInfo, parameters: parameters, showIndicator: false) {
            SVProgressHUD.showSuccess(withStatus: "支付成功")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                let foodPurchaseSuccessVC = FoodPurchaseSuccessVC()
                foodPurchaseSuccessVC.ecPrice = self.ecPrice
                foodPurchaseSuccessVC.paymentMethod = .voucherPaymentStatus
                self.navigationController?.pushViewController(foodPurchaseSuccessVC, animated: true)
              })
        }
    }
    
    //现金支付
    func immediatelyPaymentStatusPayment(){
        let storeId = (self.detailsModel.storeId?.stringValue)!
        let price = self.totalNumTextField.text!
        let point = "0"
        let parameters = ["storeId":storeId,"price":price,"point":point]
        SVProgressHUD.show(withStatus: "请稍等")
        payViewModel.loadMealPaySuccessfullyReturnedData(requestType: .post, URLString: ConstAPI.kAPIOrderAddCashOrderInfo, parameters: parameters, showIndicator: false) {
            SVProgressHUD.showSuccess(withStatus: "支付成功")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                let foodPurchaseSuccessVC = FoodPurchaseSuccessVC()
                foodPurchaseSuccessVC.ecPrice = self.ecPrice
                foodPurchaseSuccessVC.paymentMethod = .immediatelyPaymentStatus
                self.navigationController?.pushViewController(foodPurchaseSuccessVC, animated: true)
            })
        }
    }
    
    //获取消费积分
    func getConsumptionIntegral(){
        var vouId = ""
        if self.voucherModel.voucherId != nil {
            vouId = (self.voucherModel.voucherId?.stringValue)!
        }
        var mealId = ""
        if self.mealModel.mealId != nil {
            mealId = (self.mealModel.mealId?.stringValue)!
        }
        let parameters = ["vouId":vouId,"mealId":mealId]
        SVProgressHUD.show(withStatus: "请稍等")
        integralViewModel.loadSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIUserWalletGetIntegralByUserId, parameters: parameters, showIndicator: false) {
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }
    }
    
    //获取钱包
    func getWallet(){
        let parameters = ["pageNum":"0","pageSize":""]
        SVProgressHUD.show(withStatus: "请稍等")
        walletViewModel.loadSuccessfullyReturnedData(requestType: .get, URLString:  ConstAPI.kAPIUserWalletGetUserWalletList, parameters: parameters, showIndicator: false) {
            SVProgressHUD.dismiss()
            self.walletPrice = (self.walletViewModel.walletPirceModel.price?.stringValue)!
            self.tableView.reloadData()
        }
    }
    
    @objc func confirmOnClick(){
        var walletPrice =  ""
        var needPay = ""
        
        if self.foodPaymentMethod == .voucherPaymentStatus || foodPaymentMethod == .mealPaymentStatus{
            walletPrice = self.setVoucherAndMealPrice().walletBalance
            needPay = self.setVoucherAndMealPrice().needPay
            ecPrice = walletPrice
        }
        
        if  self.foodPaymentMethod == .reservationPaymentStatus {
            needPay = self.walletPrice
            walletPrice = self.payPrice
            ecPrice = self.payPrice
        }
        
        if self.foodPaymentMethod == .immediatelyPaymentStatus {
            if self.totalNumTextField.text == "" {
                SVProgressHUD.showInfo(withStatus: "请入支付金额")
                needPay = self.walletPrice
                walletPrice = self.totalNumTextField.text!
                ecPrice = self.totalNumTextField.text!
            }
        }
        
        let view = InputPaymentPasswordVw(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        view?.delegate = self
        view?.setNeedPayPrice(needPay)
        view?.setWalletBalance(walletPrice)
        view?.show()
    }
    
    //设置 代金券金额
    func setVoucherAndMealPrice()->(needPay:String,walletBalance:String){
        var walletBalance =  ""
        var needPay = ""
        if self.integralViewModel.model.canDe == 1 {
            let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section))as! FoodReservationPaymentMethodCell
            if cell.chooseBtn.isSelected {
                needPay = (self.integralViewModel.model.changeEcPrice?.stringValue)!
            }else{
                needPay = (self.integralViewModel.model.NoChangeEcPrice?.stringValue)!
            }
            
        }else{
            needPay = (self.integralViewModel.model.NoChangeEcPrice?.stringValue)!
        }
        walletBalance = (self.integralViewModel.model.ECPrice?.stringValue)!
        return (walletBalance,needPay)
    }
}
