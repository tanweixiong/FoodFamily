//
//  CrowdfundingController.swift
//  FoodFamily
//
//  Created by tam on 2017/11/4.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import MJRefresh

class CrowdfundingController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate lazy var viewModel : CrowdfundingVM = CrowdfundingVM()
    fileprivate let crowdfundingCell = "CrowdfundingCell"
    fileprivate var pageNum:Int = 1
    struct CrowdfundingUX {
        static let cellHeight:CGFloat = 180
        static let sectionLineHeight:CGFloat = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "众筹"
        self.view.addSubview(tableView)
        self.getData()
    }
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  CrowdfundingUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CrowdfundingUX.sectionLineHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: CrowdfundingUX.sectionLineHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: crowdfundingCell, for: indexPath) as! CrowdfundingCell
        let model = self.viewModel.model[indexPath.section]
        cell.setData(model: model)
        cell.selectionStyle = .none
        cell.backgroundColor = R_UISectionLineColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CrowdfundingDetailsVC()
        vc.model = self.viewModel.model[indexPath.section]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CrowdfundingCell", bundle: nil),forCellReuseIdentifier: self.crowdfundingCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.getData()
        })
        return tableView
    }()

}
