//
//  MineController.swift
//  FoodFamily
//
//  Created by tam on 2017/11/4.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineController: MainViewController,MineInformationDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addDefaultButtonImageRight("ic_mine_setting")
        self.addDefaultButtonImageLeft("ic_mine_message")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.headView.backgroundVw.frame.size.height)
        view.addSubview(headView)
        mineOptionView.frame = CGRect(x: 0, y: headView.frame.maxY, width: SCREEN_WIDTH, height: self.mineOptionView.backgroundVw.frame.size.height)
        view.addSubview(mineOptionView)
        self.setData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func rightImageBtn(_ sender: UIBarButtonItem) {
        let mineSetVC = MineSetVC()
        self.navigationController?.pushViewController(mineSetVC, animated: true)
    }
    
    override func leftImageBtn(_ sender: UIBarButtonItem) {
        
    }
    
    func mineInformationChangeUserInfo() {
        self.setData()
    }
    
    func pushNextViewController(type:Int){
        switch type {
        case 0:
            let mineCollectionVC = MineCollectionVC()
            self.navigationController?.pushViewController(mineCollectionVC, animated: true)
            break
        case 1:
            let mineExpensesRecordVC = MineExpensesRecordVC()
            self.navigationController?.pushViewController(mineExpensesRecordVC, animated: true)
            break
        case 2:
            let mineDiscountCouponsVC = MineReservationVC()
            self.navigationController?.pushViewController(mineDiscountCouponsVC, animated: true)
            break
        case 3:
            let mineDiscountCouponsVC = MyScoresVC()
            self.navigationController?.pushViewController(mineDiscountCouponsVC, animated: true)
            break
        case 4:
            let mineWalletVC = MineWalletVC()
            self.navigationController?.pushViewController(mineWalletVC, animated: true)
            break
            
        case 5:
            let mineCrowdfundingVC = MineCrowdfundingVC()
            self.navigationController?.pushViewController(mineCrowdfundingVC, animated: true)
            break
            
        case 6:
            let mineChefDetailsVC = MineChefDetailsVC()
            self.navigationController?.pushViewController(mineChefDetailsVC, animated: true)
            break
            
        case 10:
            let mineInformationVC = MineInformationVC()
            mineInformationVC.delegate = self
            self.navigationController?.pushViewController(mineInformationVC, animated: true)
            break
            
        default:
            break
        }
    }
    
    lazy var headView: MineHeadView = {
        let view = Bundle.main.loadNibNamed("MineHeadView", owner: nil, options: nil)?.last as! MineHeadView
        view.mineHeadCallBack = {() in
            self.pushNextViewController(type: 10)
        }
        return view
    }()
    
    func setData(){
        let name = UserDefaults.standard.getUserInfo().nickname as! String
        self.headView.nameLabel.text = name
        
        let pice = UserDefaults.standard.getUserInfo().pice as! String
        self.headView.headImageView.sd_setImage(with: NSURL(string: (pice))! as URL, placeholderImage: UIImage.init(named: "ic_all_smallImageDefault"))
    }
    
    lazy var mineOptionView: MineOptionView = {
        let view = Bundle.main.loadNibNamed("MineOptionView", owner: nil, options: nil)?.last as! MineOptionView
        view.mineOptionViewCallBack = {(_ type:Int) in
            self.pushNextViewController(type: type)
        }
        return view
    }()
}
