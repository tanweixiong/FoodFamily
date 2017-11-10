//
//  FoodMerchantsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/9.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodMerchantsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate let foodMerchantsCell = "FoodMerchantsCell"
    struct FoodMerchantsUX {
        static let cellHeight:CGFloat = 100
        static let headHeight:CGFloat = 44
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "商户"
        view.addSubview(tableView)
        view.addSubview(headView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  FoodMerchantsUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: foodMerchantsCell, for: indexPath) as! FoodMerchantsCell
        cell.selectionStyle = .none
        return cell
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: FoodMerchantsUX.headHeight , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE - FoodMerchantsUX.headHeight))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodMerchantsCell", bundle: nil),forCellReuseIdentifier: self.foodMerchantsCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var headView: FoodMerchantsListView = {
        let view = FoodMerchantsListView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodMerchantsUX.headHeight))
        return view
    }()
    
}
