//
//  MineOrderUseVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJRefresh

class MineOrderUseVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    fileprivate let mineOrderUseCell = "MineOrderUseCell"
    fileprivate lazy var viewModel : MineOrderVM = MineOrderVM()
    fileprivate var pageNum:Int = 1
    fileprivate var isFirstLoad:Bool = true
    
    struct MineOrderUseUX {
        static let cellHeight:CGFloat = 121
        static let sectionHeight:CGFloat = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        self.getData()
    }
    
    func getData(){
        let parameters = ["type":"2","pageSize":"","pageNum":"\(self.pageNum)"]
        if isFirstLoad {
            SVProgressHUD.show(withStatus: "请稍等")
            isFirstLoad = false
        }
        viewModel.loadFinishPaySuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIOrderGetOrderList, parameters: parameters, showIndicator: false) {(hasData:Bool) in 
            self.pageNum = self.pageNum + 1
            SVProgressHUD.dismiss()
            if hasData{
                self.tableView.reloadData()
            }
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  self.viewModel.finishPayModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineOrderUseUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineOrderUseCell, for: indexPath) as! MineExpensesRecordCell
        cell.selectionStyle = .none
        cell.orderModel = self.viewModel.finishPayModel[indexPath.section]
        let model = self.viewModel.finishPayModel[indexPath.section]
        var type = ""
        if model.type == 1 {
            type = "套餐"
        }else if model.type == 2 {
            type = "代金券"
        }else if model.type == 4 {
            type = "立即支付"
        }
        cell.typeLabel.text = type + " "
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MineOrderUseUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineOrderUseUX.sectionHeight))
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
        let model = self.viewModel.finishPayModel[indexPath.section]
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
            //立即支付类型
        }else if model.type == 4 {
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
        tableView.register(UINib(nibName: "MineExpensesRecordCell", bundle: nil),forCellReuseIdentifier: self.mineOrderUseCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.getData()
        })
        return tableView
    }()


}
