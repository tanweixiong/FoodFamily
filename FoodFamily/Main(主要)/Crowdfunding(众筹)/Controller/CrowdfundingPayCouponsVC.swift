//
//  CrowdfundingPayCouponsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/12/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class CrowdfundingPayCouponsVC: MainViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate lazy var viewModel : CrowdfundingVM = CrowdfundingVM()
    fileprivate let crowdfundingPayCouponsCell = "CrowdfundingPayCouponsCell"
    var model = CrowdfundingDataModel()
    struct CrowdfundingPayCouponsUX {
        static let cellHeight:CGFloat =  100
        static let sectionLineHeight:CGFloat = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "购买积分券"
        self.navigationController?.navigationBar.alpha = 1
        self.view.addSubview(tableView)
        self.addDefaultBackBarButtonLeft()
        self.getData()
    }

    func getData(){
        let parameters = ["crowdId":(self.model?.projectId?.stringValue)!]
        viewModel.loadCouponsSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIPointGetPointList, parameters: parameters, showIndicator: false) { (hasData:Bool) in
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.couponsModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return CrowdfundingPayCouponsUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CrowdfundingPayCouponsUX.sectionLineHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: CrowdfundingPayCouponsUX.sectionLineHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: crowdfundingPayCouponsCell, for: indexPath) as! CrowdfundingPayCouponsCell
        cell.selectionStyle = .none
        cell.backgroundColor = R_UISectionLineColor
        cell.setData(model: viewModel.couponsModel[indexPath.section])
        cell.crowdfundingPayCouponsBlcok = {(sender:UIButton) in
            let crowdfundingPayVC = CrowdfundingPayVC()
            self.navigationController?.pushViewController(crowdfundingPayVC, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func backToPrevious() {
        self.navigationController?.navigationBar.alpha = 0
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CrowdfundingPayCouponsCell", bundle: nil),forCellReuseIdentifier: self.crowdfundingPayCouponsCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = R_UISectionLineColor
        tableView.tableFooterView = UIView()
        return tableView
    }()
}
