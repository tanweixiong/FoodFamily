//
//  MineCollectionVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineCollectionVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    fileprivate let mineCollectionCell = "MineCollectionCell"
    
    struct MineCollectionUX {
        static let cellHeight:CGFloat = 74.5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的收藏"
        view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineCollectionUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineCollectionCell, for: indexPath) as! MineCollectionCell
        cell.selectionStyle = .none
        return cell
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineCollectionCell", bundle: nil),forCellReuseIdentifier: self.mineCollectionCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        return tableView
    }()
}
