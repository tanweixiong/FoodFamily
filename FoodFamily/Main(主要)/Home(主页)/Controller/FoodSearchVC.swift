//
//  FoodSearchVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/28.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJRefresh

class FoodSearchVC: MainViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate {
    fileprivate lazy var viewModel : FoodSearchVM = FoodSearchVM()
    fileprivate let foodSearchCell = "FoodSearchCell"
    fileprivate var pageNum:Int = 0
    fileprivate var searchTextfield = UITextField()
    var latitudeStr = "" //设置广州为默认经纬度
    var longitudeStr = ""
    
    struct FoodSearchUX {
        static let sectionHeight:CGFloat = 15
        static let cellHeight:CGFloat = 280
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let searchBar = self.addSearchBar()
        searchBar.textfield.delegate = self
        searchBar.textfield.placeholder = "搜索商户、类型、厨师"
        searchTextfield = searchBar.textfield
        self.navigationItem.titleView = searchBar.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDefaultButtonTextRight("搜索")
        self.view.addSubview(tableView)
    }
    
    override func rightTextBtn(_ sender: UIBarButtonItem) {
        searchTextfield.resignFirstResponder()
        self.getData()
    }
    
    func getData(){
        let parameters = ["storeName":searchTextfield.text!,"longitude":self.latitudeStr,"latitude":self.longitudeStr,"pageSize":"","pageNum":"\(self.pageNum)"]
        viewModel.loadSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIStoreSelectStoreByStoreName, parameters: parameters, showIndicator: false) { (hasData:Bool) in
            if !hasData {
                 SVProgressHUD.showInfo(withStatus: "暂无数据")
                 self.viewModel.model.removeAll()
             }
                 self.tableView.reloadData()
        }
    }
    
    func refreshData(){
        let parameters = ["storeName":searchTextfield.text!,"longitude":self.latitudeStr,"latitude":self.longitudeStr,"pageSize":"","pageNum":"\(self.pageNum)"]
        viewModel.loadSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIStoreSelectStoreByStoreName, parameters: parameters, showIndicator: false) { (hasData:Bool) in
            self.tableView.reloadData()
            if hasData {
               self.pageNum = self.pageNum + 1
            }else{
               SVProgressHUD.showInfo(withStatus: "暂无数据")
            }
        }
        tableView.mj_footer.endRefreshing()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FoodSearchUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : FoodSearchUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodSearchUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: foodSearchCell, for: indexPath) as! FoodSearchCell
        cell.selectionStyle = .none
        cell.model = self.viewModel.model[indexPath.section]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchTextfield.resignFirstResponder()
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodSearchCell", bundle: nil),forCellReuseIdentifier: self.foodSearchCell)
         tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = R_UISectionLineColor
        tableView.tableFooterView = UIView()
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.refreshData()
        })
        return tableView
    }()

}
