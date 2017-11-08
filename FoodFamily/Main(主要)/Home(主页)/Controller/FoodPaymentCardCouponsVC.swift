//
//  FoodPaymentCardCouponsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/8.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

protocol FoodPaymentCardCouponsDelegate {
    func foodPaymentCardCouponsChoose()
}

class FoodPaymentCardCouponsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    fileprivate let foodPaymentCardCouponsCell = "FoodPaymentCardCouponsCell"
    var delegate:FoodPaymentCardCouponsDelegate?

    struct FoodPaymentCardCouponsUX {
        static let sectionHeight:CGFloat = 20
        static let cellHeight:CGFloat = 100
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "优惠卡券"
        view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  FoodPaymentCardCouponsUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodPaymentCardCouponsUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  section == 0 ? FoodPaymentCardCouponsUX.sectionHeight/2 : FoodPaymentCardCouponsUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: foodPaymentCardCouponsCell, for: indexPath) as! FoodPaymentCardCouponsCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.foodPaymentCardCouponsChoose()
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodPaymentCardCouponsCell", bundle: nil),forCellReuseIdentifier: self.foodPaymentCardCouponsCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        return tableView
    }()

}
