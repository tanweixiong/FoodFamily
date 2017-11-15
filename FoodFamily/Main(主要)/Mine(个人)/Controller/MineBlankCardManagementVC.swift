//
//  MyBlankCardManagementVC.swift
//  AGTMall
//
//  Created by tam on 2017/10/19.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineBlankCardManagementVC: MainViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate let myBlankCardManagementCellIdentifier = "MyBlankCardManagementCellIdentifier"
    fileprivate var indexPath = IndexPath()
    struct MyBlankCardManagementUX{
        static let sectionHeight:CGFloat = 16
        static let rowHeight:CGFloat = 120
        static let addAddressTag:Int = 1000000
        static let deleteAddressTag:Int = 2000000
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "银行卡管理"
        view.addSubview(tableView)
        self.addDefaultButtonTextRight("添加")
    }
    
    override func rightTextBtn(_ sender: UIBarButtonItem) {
        let mineAddBankCardVC = MineAddBankCardVC()
        self.pushNextViewController(mineAddBankCardVC, true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MyBlankCardManagementUX.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MyBlankCardManagementUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MyBlankCardManagementUX.sectionHeight))
        view.backgroundColor = R_UIThemeBackgroundColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myBlankCardManagementCellIdentifier, for: indexPath) as! MyBlankCardManagementCell
        cell.selectionStyle = .none
        return cell
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MyBlankCardManagementCell", bundle: nil),forCellReuseIdentifier: self.myBlankCardManagementCellIdentifier)
        tableView.backgroundColor = R_UIThemeBackgroundColor
        tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH/2, 0,SCREEN_WIDTH/2);
        tableView.tableFooterView = UIView()
        return tableView
    }()
}
