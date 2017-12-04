//
//  MineSetVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/13.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineSetVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate let mineSetCell = "MineSetCell"
    fileprivate let dataSource = [["支付密码"],["商户入驻","厨师入驻"],["关于我们","常见问题"],["版本信息","服务及隐私条款"]]
    struct MineSetUX {
        static let cellHeight:CGFloat = 44
        static let sectionHeight:CGFloat = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        view.addSubview(tableView)
        tableView.addSubview(footView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = dataSource[section]
        return array.count
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineSetUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MineSetUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineSetUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineSetCell, for: indexPath) as! MineSetCell
        cell.selectionStyle = .none
        let array = self.dataSource[indexPath.section]
        cell.headingLabel.text = array[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let spassword = UserDefaults.standard.getUserInfo().spassword as! String
            let mineSetPayPasswordVC = MineSetPayPasswordVC()
            //没有设置支付密码
            if spassword == "" {
                mineSetPayPasswordVC.mineSetPayPasswordType = .setPayPasswordStatus
            }else{
                mineSetPayPasswordVC.mineSetPayPasswordType = .getBackPayPasswordStatus
            }
            self.navigationController?.pushViewController(mineSetPayPasswordVC, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderHeight:CGFloat = MineSetUX.sectionHeight
        if scrollView == self.tableView {
            if scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 20 {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            }else if scrollView.contentOffset.y >= MineSetUX.sectionHeight {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            }
        }
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineSetCell", bundle: nil),forCellReuseIdentifier: self.mineSetCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var footView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - YMAKE(45) - 44 - 50, width: SCREEN_WIDTH, height: YMAKE(45)))
        let button = UIButton(frame: CGRect(x: 15, y: 0, width: SCREEN_WIDTH - 30, height: YMAKE(45)))
        button.setTitle("退出登录", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.R_UIColorFromRGB(color: 0xD3B269), for: .normal)
        button.addTarget(self, action: #selector(MineSetVC.loginOutHandle), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.R_UIColorFromRGB(color: 0xD3B269).cgColor
        view.addSubview(button)
        return view
    }()
    
    @objc func loginOutHandle(){
       let login = FMNavigationController(rootViewController: LoginVC())
       UIApplication.shared.keyWindow?.rootViewController = login
       UserDefaults.standard.set(false, forKey: R_Theme_isLogin)
    }
}
