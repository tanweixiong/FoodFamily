//
//  MineAllOrderVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineAllOrderVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    fileprivate let mineAllOrderCell = "MineAllOrderCell"
    fileprivate lazy var viewModel : MineOrderVM = MineOrderVM()
    
    struct MineAllOrderUX {
        static let cellHeight:CGFloat = 121
        static let sectionHeight:CGFloat = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        self.getData()
    }
    
    func getData(){
        viewModel.loadSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIOrderGetOrderList, showIndicator: false) {
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineAllOrderUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineAllOrderCell, for: indexPath) as! MineExpensesRecordCell
        cell.selectionStyle = .none
        cell.setData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MineAllOrderUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineAllOrderUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE - 44))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineExpensesRecordCell", bundle: nil),forCellReuseIdentifier: self.mineAllOrderCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        return tableView
    }()

}
