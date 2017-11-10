//
//  FoodMerchantsListView.swift
//  FoodFamily
//
//  Created by tam on 2017/11/10.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodMerchantsListView: UIView,UITableViewDataSource,UITableViewDelegate {
    private enum FoodMerchantsPullType {
        case dropDownType //下拉类型
        case pullUpType  //上拉类型
    }
    
    private enum FoodMerchantsChooseType {
        case allType //全部类型
        case recentType //离我最近类型
    }
    private var foodMerchantsPullType = FoodMerchantsPullType.dropDownType
    private var foodMerchantsChooseType = FoodMerchantsChooseType.allType
    
    fileprivate let allFoodMerchantsListCell = "AllfoodMerchantsListCell"
    fileprivate let recentfoodMerchantsListCell = "RecentfoodMerchantsListCell"
    
    fileprivate let allDataSource:NSArray = ["离我最近","最新上线","人气最高","价格最低","价格最低"]
    fileprivate let recentDataSource:NSArray = ["火锅","烤肉","川菜","湘菜","粤菜"]
    
    fileprivate var currentTableView = UITableView()
    fileprivate var currentRcct = CGRect()
    
    fileprivate var allTableView = UITableView()
    fileprivate var allIndexPath = IndexPath()
    fileprivate var allTableViewFrame = CGRect()
    fileprivate var allTableViewHeight:CGFloat = 0
    
    fileprivate var recentTableView = UITableView()
    fileprivate var recentIndexPath = IndexPath()
    fileprivate var recentTableViewFrame = CGRect()
    fileprivate var recentTableViewHeight:CGFloat = 0
    
    fileprivate var headViewHeight:CGFloat = 0
    
    struct FoodMerchantsListUX {
        static let cellHeight:CGFloat = 47.4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.allIndexPath = NSIndexPath(row: 0, section: 0) as IndexPath
        self.recentIndexPath = NSIndexPath(row: 0, section: 0) as IndexPath
        
        self.headViewHeight = frame.size.height
        let maxHeight  = SCREEN_HEIGHT_INSIDE - self.headViewHeight
        
        let allListHeight = FoodMerchantsListUX.cellHeight * CGFloat(allDataSource.count)
        self.allTableViewHeight =  allListHeight < maxHeight ? allListHeight : maxHeight
        
        let recentListHeight = FoodMerchantsListUX.cellHeight * CGFloat(recentDataSource.count)
        self.recentTableViewHeight =  recentListHeight < maxHeight ? recentListHeight : maxHeight
        
        self.addSubview(dissMissButton)
        self.setAllTableView()
        self.setRecentTalbeView()
        self.addSubview(foodMerchantsHeadView)
        self.allTableViewFrame = allTableView.frame
        self.recentTableViewFrame = recentTableView.frame
    }
    
    func setAllTableView(){
        let originY:CGFloat = -self.allTableViewHeight + headViewHeight
        allTableView = UITableView.init(frame: CGRect(x: 0, y: originY, width: SCREEN_WIDTH, height:self.allTableViewHeight))
        allTableView.showsVerticalScrollIndicator = false
        allTableView.dataSource = self
        allTableView.delegate = self
        allTableView.register(UINib(nibName: "FoodMerchantsListCell", bundle: nil),forCellReuseIdentifier: self.allFoodMerchantsListCell)
        allTableView.backgroundColor = R_UISectionLineColor
        allTableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        allTableView.tableFooterView = UIView()
        self.addSubview(allTableView)
    }
    
    func setRecentTalbeView(){
        let originY:CGFloat = -self.recentTableViewHeight + headViewHeight
        recentTableView = UITableView.init(frame: CGRect(x: 0, y: originY, width: SCREEN_WIDTH, height:self.recentTableViewHeight))
        recentTableView.showsVerticalScrollIndicator = false
        recentTableView.dataSource = self
        recentTableView.delegate = self
        recentTableView.register(UINib(nibName: "FoodMerchantsListCell", bundle: nil),forCellReuseIdentifier: self.recentfoodMerchantsListCell)
        recentTableView.backgroundColor = R_UISectionLineColor
        recentTableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        recentTableView.tableFooterView = UIView()
        self.addSubview(recentTableView)
    }

    lazy var dissMissButton:UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: headViewHeight)
        btn.addTarget(self, action: #selector(dismissOnClick), for: .touchUpInside)
        return btn
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var array = NSArray()
        if tableView == allTableView {
            array = allDataSource
        }else{
            array = recentDataSource
        }
        return array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  FoodMerchantsListUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == allTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: allFoodMerchantsListCell, for: indexPath) as! FoodMerchantsListCell
            cell.selectionStyle = .none
            cell.headingLabel.text = allDataSource[indexPath.row] as? String
            cell.checkedImageView.isHidden = indexPath == self.allIndexPath ? false : true
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: recentfoodMerchantsListCell, for: indexPath) as! FoodMerchantsListCell
            cell.selectionStyle = .none
            cell.headingLabel.text = recentDataSource[indexPath.row] as? String
            cell.checkedImageView.isHidden = indexPath == self.recentIndexPath ? false : true
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == allTableView {
            if self.allIndexPath == indexPath {return }
            let selectedCell = tableView.cellForRow(at: indexPath)as! FoodMerchantsListCell
            selectedCell.checkedImageView.isHidden = false
            let restoreCell = tableView.cellForRow(at: self.allIndexPath as IndexPath) as! FoodMerchantsListCell
            restoreCell.checkedImageView.isHidden = true
            self.allIndexPath  = indexPath
        }else{
            if self.recentIndexPath == indexPath {return }
            let selectedCell = tableView.cellForRow(at: indexPath)as! FoodMerchantsListCell
            selectedCell.checkedImageView.isHidden = false
            let restoreCell = tableView.cellForRow(at: self.recentIndexPath as IndexPath) as! FoodMerchantsListCell
            restoreCell.checkedImageView.isHidden = true
            self.recentIndexPath  = indexPath
        }
    }
    
    lazy var foodMerchantsHeadView: FoodMerchantsHeadView = {
        let view = Bundle.main.loadNibNamed("FoodMerchantsHeadView", owner: nil, options: nil)?.last as! FoodMerchantsHeadView
        view.frame = CGRect(x: 0, y:0, width: self.frame.size.width, height: self.headViewHeight)
        view.foodMerchantsHeadCallBack = { (sender:UIButton) in
            //全部
            if sender.tag == 1 {
                self.foodMerchantsChooseType = .allType
                self.animationLoading()
            //离我最近
            }else{
                self.foodMerchantsChooseType = .recentType
                self.animationLoading()
            }
        }
        return view
    }()
    
    @objc func dismissOnClick(){
        self.animationLoading()
    }
    
    @objc func tapOnClick(){
        self.animationLoading()
    }
    
     private  func animationLoading(){
        if self.foodMerchantsChooseType == .allType {
            self.foodMerchantsHeadView.allArrowButton.isSelected = self.foodMerchantsPullType == .dropDownType ? true : false
        }else if self.foodMerchantsChooseType == .recentType {
            self.foodMerchantsHeadView.recentArrowButton.isSelected = self.foodMerchantsPullType == .dropDownType ? true : false
        }
        
        //上拉操作
        if self.foodMerchantsPullType == .pullUpType {
            self.foodMerchantsHeadView.allArrowButton.isSelected = false
            self.foodMerchantsHeadView.recentArrowButton.isSelected = false
        }
        
        //下拉操作
        if self.foodMerchantsPullType == .dropDownType {
            if self.foodMerchantsChooseType == .allType {
                currentTableView = self.allTableView
                currentRcct = allTableViewFrame
            }else{
                currentTableView = self.recentTableView
                currentRcct = recentTableViewFrame
            }
        }

        if self.foodMerchantsPullType == .dropDownType {
            self.frame.size.height = SCREEN_HEIGHT_INSIDE
            UIView.animate(withDuration: 0.5, animations: {
                self.currentTableView.frame = CGRect(x: 0, y: self.headViewHeight ,width: SCREEN_WIDTH, height: self.currentTableView.frame.size.height)
            }, completion: { (finish) in
               self.backgroundColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 0.5)
            })
        }else{
            self.frame.size.height = self.headViewHeight
            UIView.animate(withDuration: 0.5, animations: {
                self.currentTableView.frame = self.currentRcct
            }, completion: { (finish) in
                self.backgroundColor = UIColor.clear
            })
        }
        self.dissMissButton.frame.size.height = self.frame.size.height
        self.foodMerchantsPullType = self.foodMerchantsPullType == FoodMerchantsPullType.dropDownType ? FoodMerchantsPullType.pullUpType : FoodMerchantsPullType.dropDownType
    }
    
}
