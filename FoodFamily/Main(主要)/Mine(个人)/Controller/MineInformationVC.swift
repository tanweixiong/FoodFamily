//
//  MineInformationVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import IQKeyboardManager

class MineInformationVC: MainViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    fileprivate let mineInformationHeadCell = "MineInformationHeadCell"
    fileprivate let mineInformationListCell = "MineInformationListCell"
    let headingContentArray = ["头像","昵称","年龄","星座","城市","签名"]
    let contentArray = ["头像","昵称","年龄","星座","城市","签名"]
    
    struct MineInformationUX {
        static let cellHeight:CGFloat = 60
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人资料"
        self.addDefaultButtonTextRight("保存")
        self.setCloseRoundKeyboard()
        view.addSubview(tableView)
        
        NSNotificationC
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared().isEnabled = true
    }
    
    override func rightTextBtn(_ sender: UIBarButtonItem) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headingContentArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineInformationUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: mineInformationHeadCell, for: indexPath) as! MineInformationHeadCell
            cell.selectionStyle = .none
            cell.headingLabel.text = headingContentArray[indexPath.row]
            cell.avatarImageView.image = UIImage.init(named: "")
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: mineInformationListCell, for: indexPath) as! MineInformationListCell
            cell.selectionStyle = .none
            cell.headingLabel.text = headingContentArray[indexPath.row]
            cell.textfield.text = contentArray[indexPath.row]
            if indexPath.row == 5 {
                cell.contentView.tag = 111
                cell.tag = 222
            }
            
            cell.textfield.delegate = self
            return cell
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineInformationHeadCell", bundle: nil),forCellReuseIdentifier: self.mineInformationHeadCell)
        tableView.register(UINib(nibName: "MineInformationListCell", bundle: nil),forCellReuseIdentifier: self.mineInformationListCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
          tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        return tableView
    }()

}
