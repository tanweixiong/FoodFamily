//
//  MineChefVC.swift
//  FoodFamily
//
//  Created by tam on 2017/12/5.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineChefVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate let mineChefDetailsCell = "MineChefDetailsCell"
    fileprivate let mineChefDetailsHeadCell = "MineChefDetailsHeadCell"
    fileprivate let headingArray = [[""],["手机号"],["预约时间"],["预约地址"],["订单编号","下单时间","支付方式"],["预约金额","消费金额","总金额"]]
    
    struct MineChefDetailsUX {
        static let cellHeight:CGFloat = 44
        static let sectionHeight:CGFloat = 102
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let headingArray = self.headingArray[section] as NSArray
        return headingArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: mineChefDetailsCell, for: indexPath) as! MineChefDetailsCell
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: mineChefDetailsCell, for: indexPath) as! MineChefDetailsCell
            cell.selectionStyle = .none
            let array = self.headingArray[indexPath.section]
            cell.headingLabel.text = array[indexPath.row]
            return cell
        }
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineChefDetailsHeadCell", bundle: nil),forCellReuseIdentifier: self.mineChefDetailsHeadCell)
        tableView.register(UINib(nibName: "MineChefDetailsCell", bundle: nil),forCellReuseIdentifier: self.mineChefDetailsCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.mj_footer.isAutomaticallyHidden = true
        return tableView
    }()
}
