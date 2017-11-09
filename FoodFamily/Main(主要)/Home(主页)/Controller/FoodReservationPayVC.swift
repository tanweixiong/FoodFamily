//
//  FoodReservationPayVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

enum FoodPaymentMethodStatus {
    case normalPaymentStatus
    case reservationPaymentStatus
}

class FoodReservationPayVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate let dataScorce = ["使用卡券","钱包支付","微信支付","支付宝支付"]
    fileprivate let imageArray = ["ic_home_card","ic_home_card","ic_home_wechat","ic_home_alipay"]
    fileprivate let foodReservationPayCell = "FoodReservationPayCell"
    fileprivate let foodReservationPaymentCardCell = "FoodReservationPaymentCardCell"
    fileprivate let foodReservationPaymentMethodCell = "FoodReservationPaymentMethodCell"
    fileprivate var indexPath = IndexPath()
    
    var foodPaymentMethod = FoodPaymentMethodStatus.normalPaymentStatus
    var paymentMethod = OrderPaymentMethod.ordinaryPaymentStatus
    
    struct FoodReservationPayUX {
        static let foodReservationPayHeight:CGFloat = 90
        static let foodReservationPaymentMethodHeight:CGFloat = 44
        static let sectionHeight:CGFloat = 20
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
         self.indexPath = NSIndexPath(row: 0, section: 2) as IndexPath
        view.addSubview(tableView)
        tableView.addSubview(confirmBtn)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationPayCell, for: indexPath) as! FoodReservationPayCell
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationPaymentCardCell, for: indexPath) as! FoodReservationPaymentCardCell
            cell.selectionStyle = .none
            cell.headingLabel.text = self.dataScorce[indexPath.section - 1]
            cell.iconImageView.image = UIImage.init(named: self.imageArray[indexPath.section - 1])
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationPaymentMethodCell, for: indexPath) as! FoodReservationPaymentMethodCell
            cell.chooseBtn.isSelected = indexPath.section == 2 ? true : false
            cell.selectionStyle = .none
            cell.headingLabel.text = self.dataScorce[indexPath.section - 1]
            cell.iconImageView.image = UIImage.init(named: self.imageArray[indexPath.section - 1])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0  {return}
        if indexPath.section == 1 {
            let foodPaymentCardCouponsVC = FoodPaymentCardCouponsVC()
            self.navigationController?.pushViewController(foodPaymentCardCouponsVC, animated: true)
            return}
        let selectedCell = tableView.cellForRow(at: IndexPath(row: 0, section: indexPath.section))as! FoodReservationPaymentMethodCell
        selectedCell.chooseBtn.isSelected = true
        let restoreCell = tableView.cellForRow(at: self.indexPath as IndexPath) as! FoodReservationPaymentMethodCell
        restoreCell.chooseBtn.isSelected = false
        self.indexPath  = NSIndexPath(row: 0, section: indexPath.section) as IndexPath
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodReservationPayCell", bundle: nil),forCellReuseIdentifier: self.foodReservationPayCell)
        tableView.register(UINib(nibName: "FoodReservationPaymentCardCell", bundle: nil),forCellReuseIdentifier: self.foodReservationPaymentCardCell)
        tableView.register(UINib(nibName: "FoodReservationPaymentMethodCell", bundle: nil),forCellReuseIdentifier: self.foodReservationPaymentMethodCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        return tableView
    }()

    lazy var confirmBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect(x: 15, y: YMAKE(392) , width: SCREEN_WIDTH - 30, height: 50)
        btn.addTarget(self, action:  #selector(FoodReservationPayVC.confirmOnClick), for: .touchUpInside)
        btn.setTitle("确认支付 ¥99999.00", for: .normal)
        btn.backgroundColor = UIColor.R_UIRGBColor(red: 211, green: 178, blue: 105, alpha: 1)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        return btn
    }()
    
    @objc func confirmOnClick(){
        let foodPurchaseSuccessVC = FoodPurchaseSuccessVC()
        foodPurchaseSuccessVC.paymentMethod = self.paymentMethod
        self.navigationController?.pushViewController(foodPurchaseSuccessVC, animated: true)
    }
    
}
