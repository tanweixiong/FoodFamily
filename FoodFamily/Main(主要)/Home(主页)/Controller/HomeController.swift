//
//  HomeController.swift
//  FoodFamily
//
//  Created by tam on 2017/11/4.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import MJRefresh

class HomeController: MainViewController,UITableViewDelegate,UITableViewDataSource,LocationDelegate,UITextFieldDelegate {
    
   fileprivate lazy var homeVM : HomeControllerVM = HomeControllerVM()
   fileprivate let boutiqueTableViewCell = "BoutiqueTableViewCell"
   fileprivate let topicTableViewCell = "TopicTableViewCell"
   fileprivate let recommendTableViewCell = "RecommendTableViewCell"
   fileprivate var latitudeStr = "23.171962"
   fileprivate var longitudeStr = "113.461113"
    
    struct HomeControllerUX {
        static let boutiqueTableViewCellHeight:CGFloat = 256
        static let topicTableViewCellHeight:CGFloat = 252.5
        static let recommendTableViewCellHeight:CGFloat = 304
        static let sectionHeight:CGFloat = 20
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let searchBar = self.addSearchBar()
        searchBar.textfield.delegate = self
        self.navigationItem.titleView = searchBar.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        self.getTargetingData()
        self.view.addSubview(tableView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.filterButton)
    }
    
    func getTargetingData() {
        LocationViewController.shareManager().startLocation();
        LocationViewController.shareManager().delegate = self
    }
    
    //传默认经纬度
    func getData(){
        let parameters = ["lat":self.latitudeStr,"lng":self.longitudeStr]
        homeVM.loadSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIAppIndex, parameters: parameters, showIndicator: false) {
            self.tableView.reloadData()
        }
         self.tableView.mj_header.endRefreshing()
    }
    
    //上传经纬度
    func locationCallBackDataLatitude(_ latitude: CGFloat, longitude: CGFloat) {
        self.latitudeStr = "\(latitude)"
        self.longitudeStr = "\(longitude)"
        let parameters = ["lat":self.latitudeStr,"lng":self.longitudeStr]
        homeVM.loadSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIAppIndex, parameters: parameters, showIndicator: false) {
             self.tableView.reloadData()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return  3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return HomeControllerUX.boutiqueTableViewCellHeight
        }else if indexPath.section == 1{
            return HomeControllerUX.topicTableViewCellHeight
        }else{
            return HomeControllerUX.recommendTableViewCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : HomeControllerUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: HomeControllerUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if self.homeVM.homeModel.data != nil{
                let vc = RecommendDetailsVC()
                vc.storeID = ((self.homeVM.homeModel.data?.storeList?.id)?.stringValue)!
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: boutiqueTableViewCell, for: indexPath) as! BoutiqueTableViewCell
            if self.homeVM.homeModel.data != nil{
                cell.setData((self.homeVM.homeModel.data?.categoryList)!, (self.homeVM.homeModel.data?.bannerList)!)
            }
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: topicTableViewCell, for: indexPath) as! TopicTableViewCell
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: recommendTableViewCell, for: indexPath) as! RecommendTableViewCell
            if self.homeVM.homeModel.data != nil{
                cell.setData((self.homeVM.homeModel.data?.storeList)!)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //当断即textField进行跳转
        let foodSearchVC = FoodSearchVC()
        foodSearchVC.longitudeStr = self.longitudeStr
        foodSearchVC.latitudeStr = self.latitudeStr
        self.navigationController?.pushViewController(foodSearchVC, animated: true)
        return false
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "BoutiqueTableViewCell", bundle: nil),forCellReuseIdentifier: self.boutiqueTableViewCell)
         tableView.register(UINib(nibName: "TopicTableViewCell", bundle: nil),forCellReuseIdentifier: self.topicTableViewCell)
         tableView.register(UINib(nibName: "RecommendTableViewCell", bundle: nil),forCellReuseIdentifier: self.recommendTableViewCell)
        tableView.backgroundColor = R_UIThemeBackgroundColor
        tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        tableView.tableFooterView = UIView()
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.getData()
        })
//        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
//             self.getData()
//        })
        return tableView
    }()
    
    lazy var filterButton:UIButton = {
        let button =   UIButton(type: .custom)
        button.frame = CGRect(x:0, y:0, width:60, height:50)
        button.setTitle("附近", for: .normal)
        button.setImage(UIImage.init(named: "ic_home_anyMore"), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, -70);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 0)
        button.addTarget(self, action: #selector(rightTextBtn(_:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()

    
    override func rightTextBtn(_ sender: UIBarButtonItem) {
        let foodMerchantsVC = FoodMerchantsVC()
        self.navigationController?.pushViewController(foodMerchantsVC, animated: true)
    }
}
