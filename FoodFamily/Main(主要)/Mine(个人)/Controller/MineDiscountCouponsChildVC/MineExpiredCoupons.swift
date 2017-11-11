//
//  MineExpiredCoupons.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineExpiredCoupons: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    fileprivate let mineExpiredCouponsCell = "MineExpiredCouponsCell"
    
    struct MineExpiredCouponsUX {
        static let sectionHeight:CGFloat = 20
        static let cellHeight:CGFloat = 100
        static let textColor = UIColor.R_UIRGBColor(red: 155, green: 155, blue: 155, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineExpiredCouponsUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineExpiredCouponsUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  MineExpiredCouponsUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineExpiredCouponsCell, for: indexPath) as! FoodPaymentCardCouponsCell
        cell.selectionStyle = .none
        cell.couponsBackgroundImg.image = UIImage.init(named: "mine_combined_shapecopy")
        cell.headingLabel.textColor = MineExpiredCouponsUX.textColor
        cell.validityLabel.textColor = MineExpiredCouponsUX.textColor
        cell.priceLabel.textColor = MineExpiredCouponsUX.textColor
        cell.scopeLabel.textColor = MineExpiredCouponsUX.textColor
        return cell
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE - 44))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodPaymentCardCouponsCell", bundle: nil),forCellReuseIdentifier: self.mineExpiredCouponsCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        return tableView
    }()
}
