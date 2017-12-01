//
//  MineAllOrderVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineAllOrderVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    fileprivate let mineAllOrderCell = "MineAllOrderCell"
    fileprivate lazy var viewModel : MineOrderVM = MineOrderVM()
    
    struct MineAllOrderUX {
        static let cellHeight:CGFloat = 121
        static let sectionHeight:CGFloat = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        self.getData()
    }
    
    func getData(){
        let parameters = ["type":"0"]
        viewModel.loadAllOrderSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIOrderGetOrderList, parameters: parameters, showIndicator: false) {
             self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  self.viewModel.allOrderModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineAllOrderUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineAllOrderCell, for: indexPath) as! MineExpensesRecordCell
        cell.selectionStyle = .none
        cell.orderModel = self.viewModel.allOrderModel[indexPath.section]
        let model = self.viewModel.allOrderModel[indexPath.section]
        var type = ""
        if model.type == 1 {
            type = "套餐"
        }else if model.type == 2 {
            type = "代金券"
        }else if model.type == 3 {
            type = "预约"
        }
        cell.typeLabel.text = type + " "
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MineAllOrderUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineAllOrderUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderHeight:CGFloat = 20
        if scrollView == self.tableView {
            if scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 20 {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            }else if scrollView.contentOffset.y >= sectionHeaderHeight {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let model = self.viewModel.allOrderModel[indexPath.section]
        //套餐类型
        if model.type == 1 {
            let foodPackageOrderDetailsVC = FoodPackageOrderDetailsVC()
            foodPackageOrderDetailsVC.orderNo = model.orderNo!
            self.navigationController?.pushViewController(foodPackageOrderDetailsVC, animated: true)
        //代金券类型
        }else if model.type == 2 {
            let foodVoucherOrderDetailsVC = FoodVoucherOrderDetailsVC()
            foodVoucherOrderDetailsVC.orderNo = model.orderNo!
            self.navigationController?.pushViewController(foodVoucherOrderDetailsVC, animated: true)
        //预约类型
        }else if model.type == 3 {
            let foodCanteenOrderDetailsVC = FoodCanteenOrderDetailsVC()
            foodCanteenOrderDetailsVC.orderNo = model.orderNo!
            self.navigationController?.pushViewController(foodCanteenOrderDetailsVC, animated: true)
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE - 44))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineExpensesRecordCell", bundle: nil),forCellReuseIdentifier: self.mineAllOrderCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        return tableView
    }()

}
