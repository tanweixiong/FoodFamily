//
//  MineCrowdfundingDetailsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/12/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

enum MineCrowdfundingDetailsStatus {
    case mineCrowdfundingFinish
    case mineCrowdfundingFailure
}

class MineCrowdfundingDetailsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var crowdfundingStatus = MineCrowdfundingDetailsStatus.mineCrowdfundingFinish
    fileprivate let headingArray = NSMutableArray()
    fileprivate let headingContentArray = NSMutableArray()
    
    fileprivate let crowdfundinFinishArray = [["众筹状态"],["回报方案"],["获得积分","众筹时间"],["项目编号"],["支付方式"]]
    fileprivate let crowdfundinFinishContentArray = [["众筹成功"],["回报方案"],["获得积分","众筹时间"],["项目编号"],["支付方式"]]
    fileprivate let crowdfundinFailureArray = [["众筹状态"],["回报方案"],["获得积分","众筹时间"],["项目编号"],["支付方式"],["全额退还"]]
    fileprivate let crowdfundinFailureContentArray = [["众筹失败"],["回报方案"],["获得积分","众筹时间"],["项目编号"],["支付方式"],["处理中"]]
    fileprivate let mineChefDetailsCell = "MineChefDetailsCell"
    struct MineCrowdfundingDetailsUX {
        static let sectionLineHeight:CGFloat = 15
        static let headViewHeight:CGFloat = 322
        static let cellHeight:CGFloat = 44
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "众筹详情"
        //众筹成功
        if crowdfundingStatus == .mineCrowdfundingFinish {
            self.headingArray.addObjects(from: crowdfundinFinishArray)
            self.headingContentArray.addObjects(from: crowdfundinFinishContentArray)
        }else{
            self.headingArray.addObjects(from: crowdfundinFailureArray)
            self.headingContentArray.addObjects(from: crowdfundinFailureContentArray)
        }
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array:NSArray = headingArray[section] as! NSArray
        return array.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headingArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineCrowdfundingDetailsUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MineCrowdfundingDetailsUX.sectionLineHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineCrowdfundingDetailsUX.sectionLineHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineChefDetailsCell, for: indexPath) as! MineChefDetailsCell
        cell.selectionStyle = .none
        //标题栏目
        let headingArray = self.headingArray[indexPath.section] as! NSArray
        cell.headingLabel.text = headingArray[indexPath.row] as? String
        //详情部分
        let headingContentArray = self.headingContentArray[indexPath.section] as! NSArray
        cell.headingContentLabel.text = headingContentArray[indexPath.row] as? String
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.headingContentLabel.textColor = crowdfundingStatus == .mineCrowdfundingFinish ? UIColor.R_UIRGBColor(red: 117, green: 181, blue: 228, alpha: 1) : UIColor.red
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            cell.moreImageView.isHidden = false
            cell.headingContentLabel.isHidden = true
        }
        return cell
        
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineChefDetailsCell", bundle: nil),forCellReuseIdentifier: self.mineChefDetailsCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = self.headView
        return tableView
    }()
    
    lazy var headView: MineCrowdfundinHeadView = {
        let view = Bundle.main.loadNibNamed("MineCrowdfundinHeadView", owner: nil, options: nil)?.last as! MineCrowdfundinHeadView
        view.frame = CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: MineCrowdfundingDetailsUX.headViewHeight)
        return view
    }()

}
