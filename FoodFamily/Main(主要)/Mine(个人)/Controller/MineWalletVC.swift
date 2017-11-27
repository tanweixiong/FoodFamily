//
//  MyBalanceVC.swift
//  AGTMall
//
//  Created by tam on 2017/10/18.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import MJRefresh

class MineWalletVC: UIViewController,UITableViewDataSource,UITableViewDelegate{
    fileprivate let mineWalletCell = "MineWalletCell"
    fileprivate let SCREEN_KeyWindowBounds = (UIApplication.shared.keyWindow?.bounds)!
    fileprivate var pageNum:Int = 0
    fileprivate lazy var viewModel : MineWalletVM = MineWalletVM()
    
    struct MyBalanceUX {
        static let myBalanceViewSize:CGSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        static let myBalanceListView:CGSize = CGSize(width: SCREEN_WIDTH, height: YMAKE(62))
        static let balanceFont:CGFloat = 25
        static let companyFont:CGFloat = 14
        static let rowHeight:CGFloat = 60
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setColor(UIColor.clear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setColor(R_UINavigationBarColor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的钱包"
        self.createUI()
        self.getData()
    }
    
    func getData(){
        let parameters = ["pageNum":"\(self.pageNum)","pageSize":""]
        viewModel.loadSuccessfullyReturnedData(requestType: .get, URLString:  ConstAPI.kAPIUserWalletGetUserWalletList, parameters: parameters, showIndicator: false) {
            self.balanceLabel.text = self.viewModel.walletPirceModel.price?.stringValue
            self.repaintView()
            self.pageNum = self.pageNum + 1
            self.tableView.reloadData()
            self.tableView.mj_footer.endRefreshing()
        }
        self.tableView.mj_footer.endRefreshing()
    }
    
    func createUI(){
        view.addSubview(myBalanceView)
        view.addSubview(myBalanceListView)
        view.addSubview(balanceLabel)
        view.addSubview(companyLabel)
        
        myBalanceView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view.snp.top).offset(-64)
            make.left.equalTo(view.snp.left)
            make.width.greaterThanOrEqualTo(SCREEN_KeyWindowBounds.size.width)
            make.height.greaterThanOrEqualTo(SCREEN_KeyWindowBounds.size.height)
        }
        
        myBalanceListView.snp.makeConstraints{ (make) -> Void in
           make.top.equalTo(myBalanceView.headView.snp.bottom).offset(-MyBalanceUX.myBalanceListView.height/2)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(MyBalanceUX.myBalanceListView.width)
            make.height.equalTo(MyBalanceUX.myBalanceListView.height)
        }
        
         self.repaintView()
        
         myBalanceView.listView.addSubview(self.tableView)
    }
    
    //重新绘制
    func repaintView(){
        let balanceSize:CGSize = balanceLabel.getStringSize(text:balanceLabel.text!, size: CGSize(width: SCREEN_WIDTH, height: MyBalanceUX.balanceFont), font:  MyBalanceUX.balanceFont)
        balanceLabel.snp.updateConstraints{ (make) -> Void in
            make.centerX.equalTo(myBalanceView.headView.snp.centerX)
            make.centerY.equalTo(myBalanceView.headView.snp.centerY)
            make.width.greaterThanOrEqualTo(balanceSize.width)
            make.height.equalTo(balanceSize.height)
        }
        
        companyLabel.snp.updateConstraints{ (make) -> Void in
            make.right.equalTo(balanceLabel.snp.left).offset(0)
            make.centerY.equalTo(balanceLabel.snp.centerY)
            make.width.equalTo(10)
            make.height.equalTo(MyBalanceUX.companyFont)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.walletModel.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return MyBalanceUX.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineWalletCell, for: indexPath) as! MineWalletCell
        cell.selectionStyle = .none
        let model = self.viewModel.walletModel[indexPath.row]
        var detailType = ""
        switch (model.detailType?.intValue)! {
        case 1:
            detailType = "ec币"
            break
        case 2:
            detailType = "积分"
            break
        case 3:
             detailType = "消费"
            break
        default:
            break
        }
        cell.detailTypeLabel.text = detailType
        cell.createTimeLabel.text = model.createTime
        cell.detailPriceLabel.text = model.detailPrice?.stringValue
        return cell
    }
    
    lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "--"
        label.font = UIFont.systemFont(ofSize: MyBalanceUX.balanceFont)
        return label
    }()
    
    lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "¥"
        label.font = UIFont.systemFont(ofSize: MyBalanceUX.companyFont)
        return label
    }()

    lazy var myBalanceView: MyBalanceView = {
        let view = Bundle.main.loadNibNamed("MyBalanceView", owner: nil, options: nil)?.last as! MyBalanceView
        view.frame = CGRect(x: 0, y: 0, width: MyBalanceUX.myBalanceViewSize.width, height: MyBalanceUX.myBalanceViewSize.height)
        return view
    }()
    
    lazy var myBalanceListView: MyBalanceListView = {
        let view = Bundle.main.loadNibNamed("MyBalanceListView", owner: nil, options: nil)?.last as! MyBalanceListView
        view.frame = CGRect(x: 0, y: 0, width: MyBalanceUX.myBalanceListView.width, height: MyBalanceUX.myBalanceListView.height)
        view.myBalanceCallBack = {(sender:UIButton) in
            if sender.tag == 1 {
                let mineAmountChoiceVC = MineAmountChoiceVC()
                self.navigationController?.pushViewController(mineAmountChoiceVC, animated: true)
            }else{
                let mineWithdrawVC = MineWithdrawVC()
                self.navigationController?.pushViewController(mineWithdrawVC, animated: true)
            }
        }
        return view
    }()
    
    lazy var tableView: UITableView = {
        let maxY = MyBalanceUX.myBalanceListView.height/2 + 15
        let tableView = UITableView.init(frame: CGRect(x: 0, y: maxY , width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 215 - maxY))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineWalletCell", bundle: nil),forCellReuseIdentifier: self.mineWalletCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        tableView.tableFooterView = UIView()
        tableView.separatorColor = R_UISectionLineColor
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
             self.getData()
        })
        return tableView
    }()
    
}
