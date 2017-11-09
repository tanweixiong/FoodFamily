//
//  FoodRecommendDetailVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/8.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//  推荐详情

import UIKit

class FoodRecommendDetailVC: MainViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate let foodRecommendDetailCell = "FoodRecommendDetailCell"
    
    struct FoodRecommendDetailUX {
        static let cellHeight:CGFloat = 180
        static let sectionHeight:CGFloat = 15
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "推荐菜"
        addDefaultButtonImageLeft("")
        addDefaultButtonTextRight("关闭")
        view.addSubview(tableView)
    }
    
    override func rightTextBtn(_ sender:UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func leftImageBtn(_ sender:UIBarButtonItem) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UserDefaults.standard.object(forKey: "height") != nil ? UserDefaults.standard.object(forKey: "height") as! CGFloat : 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? FoodRecommendDetailUX.sectionHeight : FoodRecommendDetailUX.sectionHeight + 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodRecommendDetailUX.sectionHeight))
        view.backgroundColor = UIColor.white
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: foodRecommendDetailCell, for: indexPath) as! FoodRecommendDetailCell
        cell.setData()
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
