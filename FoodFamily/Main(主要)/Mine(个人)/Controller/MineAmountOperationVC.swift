//
//  WithdrawalAndRechargeDetailsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/15.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

enum MineAmountOperationType {
    case cashOperationStatus //提现操作
    case rechargeOperationStatus //充值操作
}

class MineAmountOperationVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    struct MineAmountOperationUX {
        static let rowHeight:CGFloat = 44
        static let sectionHeight:CGFloat = 15
    }
    var operationType = MineAmountOperationType.cashOperationStatus
    fileprivate let mineAmountOperationCell = "MineAmountOperationCell"
    fileprivate let cashOperationContentArray = [["银行卡","服务费","处理进度","提现到"],["订单号","类型","时间","提现金额"]]
    fileprivate let rechargeOperationContentArray = [["流水号","类型","支付方式","时间","充值金额"]]
    fileprivate let dataSource = NSMutableArray()
    fileprivate let headingContentArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.operationType == .cashOperationStatus {
            self.title  = "提现详情"
            self.dataSource.addObjects(from: cashOperationContentArray)
        }else{
            self.title = "充值详情"
           self.dataSource.addObjects(from: rechargeOperationContentArray)
        }
        self.view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array:NSArray = dataSource[section] as! NSArray
        return array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MineAmountOperationUX.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MineAmountOperationUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineAmountOperationUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineAmountOperationCell, for: indexPath) as! MineAmountOperationCell
        cell.selectionStyle = .none
        let array:NSArray = self.dataSource[indexPath.section] as! NSArray
        cell.headingLabel.text = array[indexPath.row] as? String
        return cell
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineAmountOperationCell", bundle: nil),forCellReuseIdentifier: self.mineAmountOperationCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        tableView.separatorColor = R_UISectionLineColor
        tableView.isScrollEnabled = false
        return tableView
    }()

}
