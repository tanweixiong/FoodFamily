//
//  MineUsableCoupons.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineUsableCoupons: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    fileprivate let mineUsableCouponsCell = "MineUsableCouponsCell"

    struct MineUsableCouponsUX {
        static let sectionHeight:CGFloat = 20
        static let cellHeight:CGFloat = 100
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
        return  MineUsableCouponsUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineUsableCouponsUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return  MineUsableCouponsUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineUsableCouponsCell, for: indexPath) as! FoodPaymentCardCouponsCell
        cell.selectionStyle = .none
        return cell
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE - 44))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodPaymentCardCouponsCell", bundle: nil),forCellReuseIdentifier: self.mineUsableCouponsCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        return tableView
    }()

}
