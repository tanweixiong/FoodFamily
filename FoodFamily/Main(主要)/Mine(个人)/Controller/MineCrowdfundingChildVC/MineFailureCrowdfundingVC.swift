//
//  MineFailureCrowdfundingVC.swift
//  FoodFamily
//
//  Created by tam on 2017/12/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineFailureCrowdfundingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    fileprivate let mineCrowdfundingCell = "MineCrowdfundingCell"
    
    struct MineFailureCrowdfundingUX {
        static let cellHeight:CGFloat = 200
        static let sectionLineHeight:CGFloat = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineFailureCrowdfundingUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MineFailureCrowdfundingUX.sectionLineHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineFailureCrowdfundingUX.sectionLineHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineCrowdfundingCell, for: indexPath) as! MineCrowdfundingCell
        cell.selectionStyle = .none
        cell.crowdfundingStatusLabel.text = "众筹失败"
        cell.crowdfundingStatusLabel.textColor = UIColor.red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mineCrowdfundingDetailsVC = MineCrowdfundingDetailsVC()
        mineCrowdfundingDetailsVC.crowdfundingStatus = .mineCrowdfundingFailure
        self.navigationController?.pushViewController(mineCrowdfundingDetailsVC, animated: true)
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE - 44))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineCrowdfundingCell", bundle: nil),forCellReuseIdentifier: self.mineCrowdfundingCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        tableView.tableFooterView = UIView()
        return tableView
    }()
}
