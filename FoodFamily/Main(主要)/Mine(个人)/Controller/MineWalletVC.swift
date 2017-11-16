//
//  MyBalanceVC.swift
//  AGTMall
//
//  Created by tam on 2017/10/18.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineWalletVC: UIViewController {
    fileprivate let SCREEN_KeyWindowBounds = (UIApplication.shared.keyWindow?.bounds)!
    struct MyBalanceUX {
        static let myBalanceViewSize:CGSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        static let myBalanceListView:CGSize = CGSize(width: SCREEN_WIDTH, height: YMAKE(62))
        static let balanceFont:CGFloat = 25
        static let companyFont:CGFloat = 14
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的钱包"
        self.createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setColor(UIColor.clear)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setColor(R_UINavigationBarColor)
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
        
        let balanceSize:CGSize = balanceLabel.getStringSize(text:balanceLabel.text!, size: CGSize(width: SCREEN_WIDTH, height: MyBalanceUX.balanceFont), font:  MyBalanceUX.balanceFont)
        balanceLabel.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalTo(myBalanceView.headView.snp.centerX)
            make.centerY.equalTo(myBalanceView.headView.snp.centerY)
            make.width.equalTo(balanceSize.width + 1)
            make.height.equalTo(balanceSize.height)
        }
        
        companyLabel.snp.makeConstraints{ (make) -> Void in
            make.right.equalTo(balanceLabel.snp.left).offset(0)
            make.centerY.equalTo(balanceLabel.snp.centerY)
            make.width.equalTo(10)
            make.height.equalTo(MyBalanceUX.companyFont)
        }
    }
    
    lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "120.00"
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

}
