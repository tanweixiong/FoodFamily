//
//  MineCollectionVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

class MineCollectionVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate lazy var viewModel : MineCollectionVM = MineCollectionVM()
    fileprivate let mineCollectionCell = "MineCollectionCell"
    fileprivate var pageNum:Int = 0
    
    struct MineCollectionUX {
        static let cellHeight:CGFloat = 74.5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的收藏"
        view.addSubview(tableView)
        self.getData()
    }
    
    func getData(){
        let url = ConstAPI.kAPICollectionGetCollectionList
        let parameters = ["pageNum":"\(pageNum)","pageSize":""]
        viewModel.loadSuccessfullyReturnedData(requestType: .get, URLString: url, parameters: parameters, showIndicator: false) { (isData:Bool) in
            if !isData{
               self.tableView.mj_footer.resetNoMoreData()
               return
            }else{
                self.pageNum = self.pageNum + 1
                self.tableView.reloadData()
                self.tableView.mj_footer.endRefreshing()
            }
        }
    }
    
    func setCollection(isCollection:Bool,index:NSInteger,btn:UIButton){
        let url = isCollection ? ConstAPI.kAPIStoreCollectionStore : ConstAPI.kAPIStoreCancelCollection
        let model = self.viewModel.collectionListModel[index]
        let storeId = model.storeId?.stringValue
        let parameters = ["storeId":storeId!]
        viewModel.loadSuccessfullyCollectionReturnedData(requestType: .post, URLString: url, parameters: parameters, showIndicator: false, finishedCallback: {
           let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0) )as! MineCollectionCell
            cell.collectLabel.text = isCollection ? "已关注" : "加关注"
            SVProgressHUD.showSuccess(withStatus: isCollection ? "已关注" : "加关注")
            btn.isSelected = !btn.isSelected
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.collectionListModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineCollectionUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineCollectionCell, for: indexPath) as! MineCollectionCell
        cell.selectionStyle = .none
        cell.collectionListModel = self.viewModel.collectionListModel[indexPath.row]
        cell.collectButton.tag = indexPath.row
        cell.collectButton.isSelected = true
        cell.mineCollectionBlock = {(sender:UIButton) in
            let isCollection = !sender.isSelected
            self.setCollection(isCollection: isCollection, index: sender.tag,btn: sender)
        }
        return cell
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineCollectionCell", bundle: nil),forCellReuseIdentifier: self.mineCollectionCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
           self.getData()
        })
        tableView.mj_footer.isAutomaticallyHidden = true
        return tableView
    }()
}
