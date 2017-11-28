//
//  MineOrderEvaluatedVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineOrderEvaluatedVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    fileprivate let mineOrderEvaluatedCell = "MineOrderEvaluatedCell"
    fileprivate lazy var viewModel : MineOrderVM = MineOrderVM()
    
    struct MineOrderEvaluatedUX {
        static let cellHeight:CGFloat = 121
        static let sectionHeight:CGFloat = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
    
    func getData(){
        let parameters = ["type":"1"]
        viewModel.loadSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIOrderGetOrderList, parameters: parameters, showIndicator: true) {
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.orderModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineOrderEvaluatedUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineOrderEvaluatedCell, for: indexPath) as! MineExpensesRecordCell
        cell.selectionStyle = .none
        cell.orderModel = self.viewModel.orderModel[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MineOrderEvaluatedUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineOrderEvaluatedUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE - 44))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineExpensesRecordCell", bundle: nil),forCellReuseIdentifier: self.mineOrderEvaluatedCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        return tableView
    }()
}
