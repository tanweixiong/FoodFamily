//
//  MyRechargeVC.swift
//  AGTMall
//
//  Created by tam on 2017/10/19.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD

class MineRechargeVC: MainViewController,UITableViewDelegate,UITableViewDataSource,InputPaymentPasswordDelegate {
    
    fileprivate let mineRechargeMessageCell = "MineRechargeMessageCell"
    fileprivate let myRechargeListCellIdentifier = "MyRechargeListCellIdentifier"
    fileprivate let titleArray:NSArray = [["充值数量"],["当前汇率"],["微信充值","支付宝充值","银行卡充值"]]
    fileprivate let iconImageViewArray:NSArray = [["ic_mine_wallet"],["ic_mine_wallet"],["ic_mine_weChat","ic_mine_alpay","ic_mine_newBankCard"]]
    fileprivate var indexPath = IndexPath()
    var exchangeRate = "1EC=100RMB" //汇率
    var rechargeAmount = "" {
        didSet{
            self.rechargeAmount = rechargeAmount + "EC币"
        }
    }
    struct MyRechargeUX{
        static let sectionHeight:CGFloat = 16
        static let rowHeight:CGFloat = YMAKE(44)
        static let footHeight:CGFloat = YMAKE(50) + YMAKE(80)
        static let rechargeBtnCorner:CGFloat = 5
        static let rechargeBtnFont:CGFloat = 16
        static let rechargeBtnHeight:CGFloat = 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCloseRoundKeyboard()
        self.title = "充值"
        view.addSubview(tableView)
        self.indexPath = NSIndexPath(row: 0, section: 2) as IndexPath
    }
    
   @objc func rechargeClick(_ sender:UIButton){
        let view = InputPaymentPasswordVw(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        view.delegate = self
        view.show()
    }
    
    func inputPaymentPassword(_ pwd: String) -> String! {
        SVProgressHUD.show(withStatus: "支付成功")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
            SVProgressHUD.dismiss()
            let mineSuccessfulOperationVC = MineSuccessfulOperationVC()
            mineSuccessfulOperationVC.operationType = .rechargeOperationStatus
            self.navigationController?.pushViewController(mineSuccessfulOperationVC, animated: true)
        })
        return pwd
    }
    
    func inputPaymentPasswordChangeBankCard() {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  titleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array:NSArray = titleArray[section] as! NSArray
        return array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MyRechargeUX.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : MyRechargeUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MyRechargeUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 || indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: mineRechargeMessageCell, for: indexPath) as! MineRechargeMessageCell
            cell.selectionStyle = .none
            let headingArray:NSArray = self.titleArray[indexPath.section] as! NSArray
            let iconImageViewArray:NSArray =  self.iconImageViewArray[indexPath.section] as! NSArray
            
            cell.iconImageView.image = UIImage.init(named: (iconImageViewArray[indexPath.row] as? String)!)
            cell.headingLabel.text = headingArray[indexPath.row] as? String
            exchangeRate = "100"
            cell.headingContentLabel.text = indexPath.section == 0 ? rechargeAmount : exchangeRate
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: myRechargeListCellIdentifier, for: indexPath) as! MyRechargeListCell
            cell.selectionStyle = .none
            cell.chooseBtn.tag = indexPath.row
            cell.chooseBtn.isSelected = indexPath == self.indexPath ? true : false
            
            let headingContentArray:NSArray = self.titleArray[indexPath.section] as! NSArray
            cell.titleLabel.text = headingContentArray[indexPath.row] as? String
            
            let iconImageViewArray:NSArray = self.iconImageViewArray[indexPath.section] as! NSArray
            cell.iconImageView.image = UIImage.init(named:(iconImageViewArray[indexPath.row] as? String)!)
            cell.myRechargeListCallBack = { (sender:UIButton) in
                let myIndexPath = sender.tag
                if myIndexPath == self.indexPath.row {
                    return
                }
                let selectedCell = tableView.cellForRow(at: IndexPath(row: myIndexPath, section: 2))as! MyRechargeListCell
                selectedCell.chooseBtn.isSelected = true
                let restoreCell = tableView.cellForRow(at: self.indexPath as IndexPath) as! MyRechargeListCell
                restoreCell.chooseBtn.isSelected = false
                self.indexPath  = NSIndexPath(row: myIndexPath, section: 2) as IndexPath
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    lazy var footView :UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MyRechargeUX.footHeight))
        view.backgroundColor = UIColor.clear
        view.addSubview(self.rechargeBtn)
        return view
    }()
    
    lazy var rechargeBtn: UIButton = {
        let btn = UIButton.setBtnBoarderCorner(radius: MyRechargeUX.rechargeBtnCorner)
        btn.backgroundColor = UIColor.clear
        btn.setTitle("立即充值", for: UIControlState.normal)
        btn.setTitleColor(UIColor.R_UIRGBColor(red: 82, green: 179, blue: 255, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: MyRechargeUX.rechargeBtnFont)
        btn.layer.borderColor = UIColor.R_UIRGBColor(red: 82, green: 179, blue: 255, alpha: 1).cgColor
        btn.clipsToBounds = true
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(rechargeClick(_:)), for: .touchUpInside)
        btn.frame = CGRect(x: 20, y: MyRechargeUX.footHeight - MyRechargeUX.rechargeBtnHeight, width: SCREEN_WIDTH - 40, height: MyRechargeUX.rechargeBtnHeight)
        return btn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineRechargeMessageCell", bundle: nil),forCellReuseIdentifier: self.mineRechargeMessageCell)
        tableView.register(UINib(nibName: "MyRechargeListCell", bundle: nil),forCellReuseIdentifier: self.myRechargeListCellIdentifier)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH)
        tableView.separatorColor = R_UISectionLineColor
        tableView.tableFooterView = self.footView
        tableView.isScrollEnabled = false
        return tableView
    }()

}
