//
//  FoodMerchantsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/9.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import MJRefresh

enum FoodMerchantsStatus {
    case merchantsStatus
    case classificationStatus
}

class FoodMerchantsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate lazy var viewModel : FoodMerchantsVM = FoodMerchantsVM()
    fileprivate let foodMerchantsCell = "FoodMerchantsCell"
    var foodMerchantsStatus = FoodMerchantsStatus.merchantsStatus
    var pageNum:Int = 0
    var typeId = ""
    struct FoodMerchantsUX {
        static let cellHeight:CGFloat = 100
        static let headHeight:CGFloat = 44
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "商户"
        view.addSubview(tableView)
        self.getData()
    }
    
    //获取数据
    func getData(){
        if foodMerchantsStatus == .merchantsStatus {
            self.getMerchantsData()
        }else{
            self.getClassificationData()
        }
    }
    
    //获取商户
    func getMerchantsData(){
        let parameters = ["longitude":"113.30764","latitude":"23.1200483"]
        viewModel.loadSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIStoreGetNearStoreList, parameters: parameters, showIndicator: false) {
            self.tableView.reloadData()
        }
         self.tableView.mj_footer.endRefreshing()
    }
    
    //获取店铺分类
    func getClassificationData(){
        let parameters = ["longitude":"113.30764","latitude":"23.1200483","typeId":typeId,"pageNum":"\(pageNum)","pageSize":""]
        viewModel.loadClassificationSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIStoreSelectStoreByStoreType, parameters: parameters, showIndicator: false) {(hasData:Bool) in
            if hasData{
                self.pageNum = self.pageNum + 1
                self.tableView.reloadData()
            }
            self.tableView.mj_footer.endRefreshing()
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if foodMerchantsStatus == .merchantsStatus {
           return self.viewModel.merchantsModel.count
        }else if foodMerchantsStatus == .classificationStatus {
           return self.viewModel.classificationModel.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  FoodMerchantsUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: foodMerchantsCell, for: indexPath) as! FoodMerchantsCell
        cell.selectionStyle = .none
        if foodMerchantsStatus == .merchantsStatus {
           cell.merchantsModel = self.viewModel.merchantsModel[indexPath.section]
        }else{
           cell.classificationModel = self.viewModel.classificationModel[indexPath.section]
        }
        return cell
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodMerchantsCell", bundle: nil),forCellReuseIdentifier: self.foodMerchantsCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.getData()
        })
        return tableView
    }()
    
}
