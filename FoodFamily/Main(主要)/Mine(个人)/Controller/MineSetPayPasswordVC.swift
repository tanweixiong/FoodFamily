//
//  MineSetPayPasswordVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/13.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

enum MineSetPayPasswordType {
    case setPayPasswordStatus
    case getBackPayPasswordStatus
}
class MineSetPayPasswordVC: MainViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate let mineSetPayPasswordCell = "MineSetPayPasswordCell"
    fileprivate var mineSetPayPasswordType = MineSetPayPasswordType.setPayPasswordStatus
    fileprivate var setPayPasswordHeadingArray = [["当前密码"],["设置密码","确认密码"]]
    fileprivate var setPayPasswordHeadingContentArray = [["请输入支付密码"],["输入交易密码","重复输入密码"]]
    fileprivate var getBackPasswordHeadingArray = [["手机号"],["验证码","密码"]]
    fileprivate var getBackPasswordHeadingContentArray = [["手机号"],["请输入验证码","请输入支付密码"]]
    fileprivate var dataSource = NSMutableArray()
    fileprivate var headingContentDataSource = NSMutableArray()
    struct MineSetPayPasswordUX {
        static let cellHeight:CGFloat = YMAKE(44)
        static let sectionHeight:CGFloat = 15
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource.removeAllObjects()
        self.headingContentDataSource.removeAllObjects()
        if mineSetPayPasswordType == .setPayPasswordStatus {
           self.title = "修改支付密码"
           self.dataSource.addObjects(from: setPayPasswordHeadingArray)
           self.headingContentDataSource.addObjects(from: setPayPasswordHeadingContentArray)
        }else{
           self.title = "找回支付密码"
           self.dataSource.addObjects(from: getBackPasswordHeadingArray)
          self.headingContentDataSource.addObjects(from: getBackPasswordHeadingContentArray)
        }
        view.addSubview(tableView)
        self.addDefaultButtonTextRight("完成")
    }
    
    @objc func getCodeClick(_ sender:UIButton){
          sender.start(withTime: 5, title: "重新获取", countDownTitle: "s", mainColor: UIColor.clear, count:   UIColor.clear)
    }
    
    override func rightTextBtn(_ sender: UIBarButtonItem) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array:NSArray = dataSource[section] as! NSArray
        return array.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineSetPayPasswordUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : MineSetPayPasswordUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineSetPayPasswordUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineSetPayPasswordCell, for: indexPath) as! MineSetPayPasswordCell
        cell.selectionStyle = .none
        let headingArray:NSArray = self.dataSource[indexPath.section] as! NSArray
        cell.headingLabel.text = headingArray[indexPath.row] as? String
        let headingContentArray:NSArray = self.headingContentDataSource[indexPath.section] as! NSArray
        cell.textfield.placeholder = headingContentArray[indexPath.row] as? String
        if indexPath.section == 0 && mineSetPayPasswordType == .getBackPayPasswordStatus{
            cell.contentView.addSubview(self.getCodeButton)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineSetPayPasswordCell", bundle: nil),forCellReuseIdentifier: self.mineSetPayPasswordCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    lazy var getCodeButton: UIButton = {
        let button = UIButton()
        let width:CGFloat = 80
        let height:CGFloat = 28
        button.frame = CGRect(x: SCREEN_WIDTH - 15 - width, y: MineSetPayPasswordUX.cellHeight/2 - height/2, width: width, height: height)
        button.setTitleColor(UIColor.R_UIRGBColor(red: 255, green: 92, blue: 132, alpha: 1), for: .normal)
        button.setTitle("获取验证码", for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1).cgColor
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(getCodeClick(_:)), for: .touchUpInside)
        button.tag = 0
        return button
    }()

}
