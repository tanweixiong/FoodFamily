//
//  FoodNormalOrderDetailsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/9.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//  套餐类型

import UIKit

class FoodCanteenOrderDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate lazy var viewModel : FoodOrderDetailsVM = FoodOrderDetailsVM()
    fileprivate let foodOrderPackageCell = "FoodOrderPackageCell"
    fileprivate let foodOrderDetailsHeadCell = "FoodOrderDetailsHeadCell"
    fileprivate let foodOrderDetailsEvaluationCell = "FoodOrderDetailsEvaluationCell"
    fileprivate let recommendNaviCell = "RecommendNaviCell"
    fileprivate let foodOrderDetailsCell = "FoodOrderDetailsCell"
    fileprivate let foodVolumeCodeCell = "FoodVolumeCodeCell"
    var orderNo = ""
    
    struct FoodNormalOrderDetailsUX {
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
        viewModel.loadSuccessfullyReturnedData(requestType:.post, URLString: ConstAPI.kAPIOrderGetOrderInfo, type: .canteenModel, parameters: parameters, showIndicator: false) {
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return FoodNormalOrderDetailsUX.headHeight
        }else if indexPath.section == 1 {
            return FoodNormalOrderDetailsUX.evaluationHeight
        }else if indexPath.section == 2 {
            return FoodNormalOrderDetailsUX.naviHeight
        }else if indexPath.section == 3 {
            return FoodNormalOrderDetailsUX.naviHeight
        }else {
            return  UserDefaults.standard.object(forKey: "height") != nil ? UserDefaults.standard.object(forKey: "height") as! CGFloat : 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let foodEvaluationVC = FoodEvaluationVC()
            self.navigationController?.pushViewController(foodEvaluationVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : FoodNormalOrderDetailsUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodNormalOrderDetailsUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodOrderDetailsHeadCell, for: indexPath) as! FoodOrderDetailsHeadCell
            cell.selectionStyle = .none
            cell.canteenModel = self.viewModel.canteenModel
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodOrderDetailsEvaluationCell, for: indexPath) as! FoodOrderDetailsEvaluationCell
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: recommendNaviCell, for: indexPath) as! RecommendNaviCell
            cell.selectionStyle = .none
            cell.canteenModel = self.viewModel.canteenModel
            return cell
        }else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodOrderDetailsCell, for: indexPath) as! FoodOrderDetailsCell
            cell.selectionStyle = .none
            cell.canteenModel = self.viewModel.canteenModel
            cell.setData()
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: foodOrderPackageCell, for: indexPath) as! FoodOrderPackageCell
            cell.selectionStyle = .none
            cell.canteenModel = self.viewModel.canteenModel
            cell.setData(type: .canteenModel)
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
        tableView.register(UINib(nibName: "FoodVolumeCodeCell", bundle: nil),forCellReuseIdentifier: self.foodVolumeCodeCell)
        tableView.register(UINib(nibName: "FoodOrderPackageCell", bundle: nil),forCellReuseIdentifier: self.foodOrderPackageCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
}

