//
//  FoodRecommendDetailVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/8.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//  推荐详情

import UIKit

class FoodRecommendDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate let foodRecommendDetailCell = "FoodRecommendDetailCell"
    
    struct FoodRecommendDetailUX {
        static let cellHeight:CGFloat = 180
        static let sectionHeight:CGFloat = 20
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "推荐菜"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  FoodRecommendDetailUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return FoodRecommendDetailUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodRecommendDetailUX.sectionHeight))
        view.backgroundColor = UIColor.white
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: foodRecommendDetailCell, for: indexPath) as! FoodRecommendDetailCell
        cell.selectionStyle = .none
        return cell
    }
 
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodRecommendDetailCell", bundle: nil),forCellReuseIdentifier: self.foodRecommendDetailCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        return tableView
    }()

}
