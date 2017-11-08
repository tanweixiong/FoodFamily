//
//  FoodFeaturesDetailVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/8.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodFeaturesDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "特色菜"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


//    lazy var tableView: UITableView = {
//        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
//        tableView.showsVerticalScrollIndicator = false
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UINib(nibName: "FoodReservationFinishHeadCell", bundle: nil),forCellReuseIdentifier: self.foodReservationFinishHeadCell)
//        tableView.register(UINib(nibName: "FoodReservationFinishListCell", bundle: nil),forCellReuseIdentifier: self.foodReservationFinishListCell)
//        tableView.backgroundColor = R_UISectionLineColor
//        tableView.separatorColor = UIColor.clear
//        tableView.tableFooterView = UIView()
//        return tableView
//    }()

}
