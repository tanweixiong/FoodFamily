//
//  ChefPayFinishVC.swift
//  FoodFamily
//
//  Created by tam on 2017/12/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class ChefPayFinishVC: MainViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate let chefHeadCell = "ChefHeadCell"
    fileprivate let mineChefDetailsCell = "MineChefDetailsCell"
    fileprivate let headingArray = [[""],["手机号"],["预约时间"],["预约地址"],["订单编号","下单时间","支付方式"],["预约金额","消费金额","总金额"]]
    
    struct MineChefDetailsUX {
        static let cellHeight:CGFloat = 44
        static let sectionHeight:CGFloat = 102
        static let headHeight:CGFloat = 102
        static let sectionLineHeight:CGFloat = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单详情"
        self.addDefaultButtonTextRight("关闭")
        self.view.addSubview(tableView)
    }
    
    override func rightTextBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headingArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : MineChefDetailsUX.sectionLineHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineChefDetailsUX.sectionLineHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let headingArray = self.headingArray[section] as NSArray
        return headingArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  indexPath.section == 0 ? MineChefDetailsUX.headHeight : MineChefDetailsUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: chefHeadCell, for: indexPath) as! ChefHeadCell
            cell.selectionStyle = .none
            cell.tradingStatusLabel.text = "交易成功"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: mineChefDetailsCell, for: indexPath) as! MineChefDetailsCell
            cell.selectionStyle = .none
            let array = self.headingArray[indexPath.section]
            cell.headingLabel.text = array[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2  {
            let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section))as! FoodReservationPaymentMethodCell
            cell.chooseBtn.isSelected = !cell.chooseBtn.isSelected
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ChefHeadCell", bundle: nil),forCellReuseIdentifier: self.chefHeadCell)
        tableView.register(UINib(nibName: "MineChefDetailsCell", bundle: nil),forCellReuseIdentifier: self.mineChefDetailsCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        return tableView
    }()
}
