//
//  CrowdfundingPayVC.swift
//  FoodFamily
//
//  Created by tam on 2017/12/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class CrowdfundingPayVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    fileprivate let foodReservationPaymentMethodCell = "FoodReservationPaymentMethodCell"
    fileprivate let crowdfundingPricePayCell = "CrowdfundingPricePayCell"
    fileprivate let crowdfundingPriceAgreementCell = "CrowdfundingPriceAgreementCell"
    
    struct CrowdfundingPayCouponsUX {
        static let cellHeight:CGFloat =  44
        static let sectionLineHeight:CGFloat = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "购买积分券"
    }
    
    func getData(){
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CrowdfundingPayCouponsUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : CrowdfundingPayCouponsUX.sectionLineHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: CrowdfundingPayCouponsUX.sectionLineHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationPaymentMethodCell, for: indexPath) as! FoodReservationPaymentMethodCell
            cell.selectionStyle = .none
            return cell
        }else{
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: crowdfundingPricePayCell, for: indexPath) as! CrowdfundingPricePayCell
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: crowdfundingPriceAgreementCell, for: indexPath) as! CrowdfundingPriceAgreementCell
                cell.selectionStyle = .none
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
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

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodReservationPaymentMethodCell", bundle: nil),forCellReuseIdentifier: self.foodReservationPaymentMethodCell)
        tableView.register(UINib(nibName: "CrowdfundingPricePayCell", bundle: nil),forCellReuseIdentifier: self.crowdfundingPricePayCell)
        tableView.register(UINib(nibName: "CrowdfundingPriceAgreementCell", bundle: nil),forCellReuseIdentifier: self.crowdfundingPriceAgreementCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = R_UISectionLineColor
        tableView.tableFooterView = UIView()
        return tableView
    }()

}
