//
//  FoodOrderDetailsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/8.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD

class FoodVoucherOrderDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate lazy var viewModel : FoodOrderDetailsVM = FoodOrderDetailsVM()
    fileprivate let foodOrderDetailsHeadCell = "FoodOrderDetailsHeadCell"
    fileprivate let foodOrderDetailsEvaluationCell = "FoodOrderDetailsEvaluationCell"
    fileprivate let recommendNaviCell = "RecommendNaviCell"
    fileprivate let foodOrderDetailsCell = "FoodOrderDetailsCell"
    fileprivate let foodOrderPackageCell = "FoodOrderPackageCell"
    var orderNo = ""
    
    struct FoodVoucherOrderDetailsUX {
        static let headHeight:CGFloat = 83
        static let evaluationHeight:CGFloat = 44
        static let naviHeight:CGFloat = 50
        static let sectionHeight:CGFloat = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单详情"
        view.addSubview(tableView)
        self.getData()
    }
    
    func getData(){
        let parameters = ["orderNo":self.orderNo]
        SVProgressHUD.show(withStatus: "请稍等")
        viewModel.loadSuccessfullyReturnedData(requestType:.get, URLString: ConstAPI.kAPIOrderGetOrderInfo, type:.voucherModel, parameters: parameters, showIndicator: false) {
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if self.viewModel.voucherModel.storeId == nil {
            return 0
        }
        return  5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return FoodVoucherOrderDetailsUX.headHeight
        }else if indexPath.section == 1 {
            return FoodVoucherOrderDetailsUX.evaluationHeight
        }else if indexPath.section == 2 {
            return FoodVoucherOrderDetailsUX.naviHeight
        }else {
           return  UserDefaults.standard.object(forKey: "height") != nil ? UserDefaults.standard.object(forKey: "height") as! CGFloat : 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : FoodVoucherOrderDetailsUX.sectionHeight
    }
     
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodVoucherOrderDetailsUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodOrderDetailsHeadCell, for: indexPath) as! FoodOrderDetailsHeadCell
            cell.selectionStyle = .none
            cell.voucherModel = self.viewModel.voucherModel
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodOrderDetailsEvaluationCell, for: indexPath) as! FoodOrderDetailsEvaluationCell
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: recommendNaviCell, for: indexPath) as! RecommendNaviCell
            cell.selectionStyle = .none
            cell.voucherModel = self.viewModel.voucherModel
            return cell
        }else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodOrderDetailsCell, for: indexPath) as! FoodOrderDetailsCell
            cell.selectionStyle = .none
            cell.voucherModel = self.viewModel.voucherModel
            cell.setData()
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: foodOrderPackageCell, for: indexPath) as! FoodOrderPackageCell
            cell.selectionStyle = .none
            cell.voucherModel = self.viewModel.voucherModel
            cell.setData(type: .voucherModel)
            return cell
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodOrderDetailsHeadCell", bundle: nil),forCellReuseIdentifier: self.foodOrderDetailsHeadCell)
        tableView.register(UINib(nibName: "FoodOrderDetailsEvaluationCell", bundle: nil),forCellReuseIdentifier: self.foodOrderDetailsEvaluationCell)
        tableView.register(UINib(nibName: "RecommendNaviCell", bundle: nil),forCellReuseIdentifier: self.recommendNaviCell)
        tableView.register(UINib(nibName: "FoodOrderDetailsCell", bundle: nil),forCellReuseIdentifier: self.foodOrderDetailsCell)
        tableView.register(UINib(nibName: "FoodOrderPackageCell", bundle: nil),forCellReuseIdentifier: self.foodOrderPackageCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        return tableView
    }()

}
