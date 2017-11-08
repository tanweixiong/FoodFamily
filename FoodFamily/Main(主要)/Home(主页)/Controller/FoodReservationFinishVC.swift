//
//  FoodReservationFinishVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/8.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodReservationFinishVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    fileprivate let foodReservationFinishHeadCell = "FoodReservationFinishHeadCell"
    fileprivate let foodReservationFinishListCell = "FoodReservationFinishListCell"
    fileprivate let headingContentArray = [["喜贺极上烤肉（花城汇店）"],["手机号"],["预约人数","预约时间"],["订单编号","下单时间","支付方式"]]
    fileprivate let informationContent =  [["预约成功"],["13255122763"],["3人","2017.10.10 12:30"],["32617836217863127631","2017.10.10 08:10","余额支付"]]
    
    struct FoodReservationFinishUX {
        static let sectionHeight:CGFloat = 20
        static let cellHeight:CGFloat = 44
        static let headHeight:CGFloat = 90
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "预约"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array:NSArray = informationContent[section] as NSArray
        return array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  indexPath.section == 0 ? FoodReservationFinishUX.headHeight : FoodReservationFinishUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodReservationFinishUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headingContentArray = self.headingContentArray[indexPath.section]
        let informationContent = self.informationContent[indexPath.section]
        let headingText = headingContentArray[indexPath.row]
        let informationText = informationContent[indexPath.row]
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationFinishHeadCell, for: indexPath) as! FoodReservationFinishHeadCell
            cell.selectionStyle = .none
            cell.headingLabel.text = headingText
            cell.informationContentLabel.text = informationText
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationFinishListCell, for: indexPath) as! FoodReservationFinishListCell
            cell.selectionStyle = .none
            cell.headingLabel.text = headingText
            cell.informationContentLabel.text = informationText
            return cell
        }
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodReservationFinishHeadCell", bundle: nil),forCellReuseIdentifier: self.foodReservationFinishHeadCell)
        tableView.register(UINib(nibName: "FoodReservationFinishListCell", bundle: nil),forCellReuseIdentifier: self.foodReservationFinishListCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        return tableView
    }()

}
