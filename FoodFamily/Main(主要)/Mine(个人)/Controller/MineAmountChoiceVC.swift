//
//  MineAmountChoiceVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/15.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD

class MineAmountChoiceVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    fileprivate let mineWalletAddressCell = "MineWalletAddressCell"
    
    struct MineAmountChoiceUX {
        static let sectionHeight:CGFloat = 16
        static let rowHeight:CGFloat = YMAKE(44)
        static let footHeight:CGFloat = YMAKE(51)
        static let footY:CGFloat = YMAKE(120)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "充值"
        self.setCloseRoundKeyboard()
        view.addSubview(tableView)
        view.addSubview(footView)
    }
    
    @objc func nextClick(_ sender:UIButton){
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0) )as! MineWalletAddressCell
        if cell.textfield.text?.characters.count != 0  {
            let mineRechargeVC = MineRechargeVC()
            mineRechargeVC.rechargeAmount = cell.textfield.text!
            self.navigationController?.pushViewController(mineRechargeVC, animated: true)
        }else{
            SVProgressHUD.showInfo(withStatus: "请输入金额")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MineAmountChoiceUX.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineWalletAddressCell, for: indexPath) as! MineWalletAddressCell
        cell.selectionStyle = .none
        cell.headingLabel.text = "数量"
        cell.textfield.placeholder = "请输入金额数量"
        cell.textfield.keyboardType = .decimalPad
        cell.textfield.textAlignment = .left
        cell.textfield.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
        return cell
    }
    
    lazy var footView :UIView = {
        let view = UIView(frame: CGRect(x: 0, y: MineAmountChoiceUX.footY, width: SCREEN_WIDTH, height: MineAmountChoiceUX.footHeight))
        view.backgroundColor = UIColor.clear
        view.addSubview(self.nextBtn)
        return view
    }()
    
    lazy var nextBtn: UIButton = {
        let btn = UIButton.setBtnBoarderCorner(radius: MineRechargeVC.MyRechargeUX.rechargeBtnCorner)
        btn.backgroundColor = UIColor.clear
        btn.setTitle("下一步", for: UIControlState.normal)
        btn.setTitleColor(UIColor.R_UIRGBColor(red: 82, green: 179, blue: 255, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize:  MineRechargeVC.MyRechargeUX.rechargeBtnFont)
        btn.layer.borderColor = UIColor.R_UIRGBColor(red: 82, green: 179, blue: 255, alpha: 1).cgColor
        btn.clipsToBounds = true
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(nextClick(_:)), for: .touchUpInside)
        btn.frame = CGRect(x: 20, y: 0, width: SCREEN_WIDTH - 40, height:  MineAmountChoiceUX.footHeight)
        return btn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineWalletAddressCell", bundle: nil),forCellReuseIdentifier: self.mineWalletAddressCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH)
        tableView.separatorColor = R_UISectionLineColor
        tableView.isScrollEnabled = false
        return tableView
    }()

}
