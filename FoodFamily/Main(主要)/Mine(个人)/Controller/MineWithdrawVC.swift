//
//  MineWithdrawVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/15.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineWithdrawVC: UIViewController,UITableViewDataSource,UITableViewDelegate,ZCTradeViewDelegate {
    fileprivate let mineWalletAddressCell = "MineWalletAddressCell"
    fileprivate let mimeRechargeHeadCell = "MyRechargeHeadCell"
    struct MineWithdrawUX {
        static let rowHeight:CGFloat = YMAKE(44)
        static let sectionHeight:CGFloat = 15
        static let rechargeBtnCorner:CGFloat = 5
        static let rechargeBtnFont:CGFloat = 16
        static let footHeight:CGFloat = YMAKE(80)
        static let rechargeBtnHeight:CGFloat = 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "提现"
        view.addSubview(tableView)
        self.setCloseRoundKeyboard()
    }

    @objc func withdrawOnClick(_ sender:UIButton){
        let vw = ZCTradeView()
        vw.delegate = self
        vw.show()
    }
    
    func finish(_ pwd: String) -> String! {
        let mineSuccessfulOperationVC = MineSuccessfulOperationVC()
        mineSuccessfulOperationVC.operationType = .cashOperationStatus
        self.navigationController?.pushViewController(mineSuccessfulOperationVC, animated: true)
        return pwd
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return  2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MineWithdrawUX.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : MineWithdrawUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineWithdrawUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: mimeRechargeHeadCell, for: indexPath) as! MyRechargeHeadCell
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: mineWalletAddressCell, for: indexPath) as! MineWalletAddressCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    lazy var footView :UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineWithdrawUX.footHeight))
        view.backgroundColor = UIColor.clear
        view.addSubview(self.rechargeBtn)
        return view
    }()
    
    lazy var rechargeBtn: UIButton = {
        let btn = UIButton.setBtnBoarderCorner(radius: MineWithdrawUX.rechargeBtnCorner)
        btn.backgroundColor = UIColor.clear
        btn.setTitle("确定提现", for: UIControlState.normal)
        btn.setTitleColor(UIColor.R_UIRGBColor(red: 82, green: 179, blue: 255, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: MineWithdrawUX.rechargeBtnFont)
        btn.layer.borderColor = UIColor.R_UIRGBColor(red: 82, green: 179, blue: 255, alpha: 1).cgColor
        btn.clipsToBounds = true
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(withdrawOnClick(_:)), for: .touchUpInside)
        btn.frame = CGRect(x: 20, y: MineWithdrawUX.footHeight - MineWithdrawUX.rechargeBtnHeight, width: SCREEN_WIDTH - 40, height: MineWithdrawUX.rechargeBtnHeight)
        return btn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineWalletAddressCell", bundle: nil),forCellReuseIdentifier: self.mineWalletAddressCell)
        tableView.register(UINib(nibName: "MyRechargeHeadCell", bundle: nil),forCellReuseIdentifier: self.mimeRechargeHeadCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH)
        tableView.separatorColor = R_UISectionLineColor
        tableView.tableFooterView = self.footView
        tableView.isScrollEnabled = false
        return tableView
    }()
}
