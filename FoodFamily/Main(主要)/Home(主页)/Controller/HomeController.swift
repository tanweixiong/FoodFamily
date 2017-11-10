//
//  HomeController.swift
//  FoodFamily
//
//  Created by tam on 2017/11/4.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class HomeController: MainViewController,UITableViewDelegate,UITableViewDataSource {
    
   fileprivate let boutiqueTableViewCell = "BoutiqueTableViewCell"
   fileprivate let topicTableViewCell = "TopicTableViewCell"
   fileprivate let recommendTableViewCell = "RecommendTableViewCell"
    
    struct HomeControllerUX {
        static let boutiqueTableViewCellHeight:CGFloat = 256
        static let topicTableViewCellHeight:CGFloat = 430
        static let recommendTableViewCellHeight:CGFloat = 342.2
        static let sectionHeight:CGFloat = 20
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.filterButton)
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
        let vc = RecommendDetailsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: boutiqueTableViewCell, for: indexPath) as! BoutiqueTableViewCell
            cell.setData()
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: topicTableViewCell, for: indexPath) as! TopicTableViewCell
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: recommendTableViewCell, for: indexPath) as! RecommendTableViewCell
            cell.selectionStyle = .none
            return cell
        }
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
        return tableView
    }()
    
    lazy var filterButton:UIButton = {
        let button =   UIButton(type: .custom)
        button.frame = CGRect(x:0, y:0, width:60, height:50)
        button.setTitle("筛选", for: .normal)
        button.setImage(UIImage.init(named: "ic_nav_right_white"), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, -70);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0)
        button.addTarget(self, action: #selector(rightTextBtn(_:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    override func rightTextBtn(_ sender: UIBarButtonItem) {
        let foodMerchantsVC = FoodMerchantsVC()
        self.navigationController?.pushViewController(foodMerchantsVC, animated: true)
    }
}
