//
//  AddBankCardVC.swift
//  AGTMall
//
//  Created by tam on 2017/10/19.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineAddBankCardVC: MainViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate let myBlankCardManagementCellIdentifier = "MyBlankCardManagementCellIdentifier"
    fileprivate let addBankTextFieldCellIdentifier = "AddBankTextFieldCellIdentifier"
    fileprivate let titleArray:NSArray = [["卡类型","卡号"],["身份证","姓名"]]
    fileprivate let textfieldPlaceholderArray:NSArray = [["请选择","请输入本人银行卡号"],["请输入证件号码","请填写持卡人的姓名"]]
    struct MyBlankCardManagementUX{
        static let sectionHeight:CGFloat = 15
        static let rowHeight:CGFloat = YMAKE(44)
        static let addAddressTag:Int = 1000000
        static let deleteAddressTag:Int = 2000000
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = R_UIThemeBackgroundColor
        self.title = "银行卡添加"
        self.setCloseRoundKeyboard()
        self.addDefaultButtonTextRight("下一步")
        view.addSubview(tableView)
    }
    
    override func rightTextBtn(_ sender: UIBarButtonItem) {
        let addBankCardDetailVC = MineAddBankCardDetailVC()
        self.navigationController?.pushViewController(addBankCardDetailVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  titleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array:NSArray = self.titleArray[section] as! NSArray
        return (array as AnyObject).count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MyBlankCardManagementUX.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : MyBlankCardManagementUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MyBlankCardManagementUX.sectionHeight))
        view.backgroundColor = R_UIThemeBackgroundColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: myBlankCardManagementCellIdentifier, for: indexPath) as! AddBankCardCell
            cell.selectionStyle = .none
            cell.backgroundColor = R_UIThemeBackgroundColor
            cell.chooseLabel.isHidden = false
            cell.rightImagView.isHidden = false
            let titleArr:NSArray = self.titleArray[indexPath.section] as! NSArray
            cell.titleLabel.text = titleArr[indexPath.row] as? String
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: addBankTextFieldCellIdentifier, for: indexPath) as! AddBankTextFieldCell
            cell.selectionStyle = .none
            let titleArr:NSArray = self.titleArray[indexPath.section] as! NSArray
            cell.headingLabel.text = titleArr[indexPath.row] as? String
            let textfieldPlaceholderArray = self.textfieldPlaceholderArray[indexPath.section] as! NSArray
            cell.textfield.placeholder = textfieldPlaceholderArray[indexPath.row] as? String
            return cell
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AddBankCardCell", bundle: nil),forCellReuseIdentifier: self.myBlankCardManagementCellIdentifier)
        tableView.register(UINib(nibName: "AddBankTextFieldCell", bundle: nil),forCellReuseIdentifier: self.addBankTextFieldCellIdentifier)
        tableView.backgroundColor = R_UIThemeBackgroundColor
        tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        tableView.separatorColor = R_UISectionLineColor
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        return tableView
    }()

}
