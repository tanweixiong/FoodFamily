//
//  CrowdfundingDetailsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/12/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class CrowdfundingDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate lazy var viewModel : CrowdfundingVM = CrowdfundingVM()
    var model = CrowdfundingDataModel()
    fileprivate let mineCrowdfundinHeadView = "MineCrowdfundinHeadView"
    fileprivate let crowdfundingDetailsCell = "CrowdfundingDetailsCell"
    fileprivate var pageNum:Int = 1
    fileprivate var isLoad:Bool = true
    struct CrowdfundingDetailsUX {
        static let cellHeight:CGFloat = 300
        static let sectionLineHeight:CGFloat = 15
        static let headViewHeight:CGFloat = 322
        static let fooodViewHeight:CGFloat = 40
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.alpha = 0
        self.view.addSubview(tableView)
        self.view.addSubview(backBtn)
        self.view.addSubview(footView)
    }
    
    func getData(){
        func getData(){
            let parameters = ["pageNum":"\(self.pageNum)","pageSize":""]
            self.viewModel.loadSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPICrowdGetUserCrowdList, parameters: parameters, showIndicator: false) {(hasData:Bool) in
                self.pageNum = self.pageNum + 1
                if hasData {
                    self.tableView.reloadData()
                }
            }
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    @objc func backClick(){
        self.navigationController?.navigationBar.alpha = 1
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CrowdfundingDetailsUX.headViewHeight
        }else{
            return  UserDefaults.standard.object(forKey: "height") != nil ? UserDefaults.standard.object(forKey: "height") as! CGFloat : 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : CrowdfundingDetailsUX.sectionLineHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: CrowdfundingDetailsUX.sectionLineHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: crowdfundingDetailsCell, for: indexPath) as! CrowdfundingDetailsCell
        cell.selectionStyle = .none
        cell.setData()
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderHeight:CGFloat = 20
        if scrollView == self.tableView {
            if scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 20 {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            }else if scrollView.contentOffset.y >= sectionHeaderHeight {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            }
            if scrollView.contentOffset.y < 0 && self.isLoad{
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                self.isLoad = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT - CrowdfundingDetailsUX.fooodViewHeight))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CrowdfundingDetailsCell", bundle: nil),forCellReuseIdentifier: self.crowdfundingDetailsCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = self.headBackgroundView
        return tableView
    }()

    lazy var headBackgroundView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: CrowdfundingDetailsUX.headViewHeight + CrowdfundingDetailsUX.sectionLineHeight)
        view.backgroundColor = R_UISectionLineColor
        view.addSubview(headView)
        return view
    }()
    
    lazy var headView: MineCrowdfundinHeadView = {
        let view = Bundle.main.loadNibNamed("MineCrowdfundinHeadView", owner: nil, options: nil)?.last as! MineCrowdfundinHeadView
        view.frame = CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: CrowdfundingDetailsUX.headViewHeight)
        view.crImageView.layer.cornerRadius = 0
        view.crImageView.clipsToBounds = false
        return view
    }()
    
    lazy var backBtn: UIButton = {
        let backButton = UIButton.init(type: .custom)
        backButton.setImage(UIImage(named: "ic_nav_back_white"), for: .normal)
        backButton.sizeToFit()
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        backButton.addTarget(self, action:  #selector(backClick), for: .touchUpInside)
        backButton.frame = CGRect(x: 1, y: 21, width: 40, height: 40)
        return backButton
    }()
    
    lazy var footView: CrowdfundingDetailsFoodVw = {
        let view = Bundle.main.loadNibNamed("CrowdfundingDetailsFoodVw", owner: nil, options: nil)?.last as! CrowdfundingDetailsFoodVw
        view.frame = CGRect(x: 0, y: tableView.frame.maxY , width: SCREEN_WIDTH, height: CrowdfundingDetailsUX.fooodViewHeight)
        view.crowdfundingDetailsCallBack = {(sender:UIButton) in
            if sender.tag == 0 {
                
            }else{
                let crowdfundingPayCouponsVC = CrowdfundingPayCouponsVC()
                crowdfundingPayCouponsVC.model = self.model
                self.navigationController?.pushViewController(crowdfundingPayCouponsVC, animated: true)
            }
        }
        return view
    }()
    
}
