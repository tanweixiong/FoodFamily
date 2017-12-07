//
//  ChefReservationPayFinishVC.swift
//  FoodFamily
//
//  Created by tam on 2017/12/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class ChefReservationPayFinishVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate let headingArray = [[""],["预约人数","预约时间"]]
    fileprivate let chefHeadCell = "ChefHeadCell"
    fileprivate let mineChefDetailsCell = "MineChefDetailsCell"
    struct ChefReservationPayFinishUX {
        static let foodPurchaseSuccessViewHeight:CGFloat = 290
        static let cellHeight:CGFloat = 44
        static let headHeight:CGFloat = 102
        static let sectionLineHeight:CGFloat = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.view.addSubview(headView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.headingArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : ChefReservationPayFinishUX.sectionLineHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: ChefReservationPayFinishUX.sectionLineHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let headingArray = self.headingArray[section] as NSArray
        return headingArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  indexPath.section == 0 ? ChefReservationPayFinishUX.headHeight : ChefReservationPayFinishUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: chefHeadCell, for: indexPath) as! ChefHeadCell
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: mineChefDetailsCell, for: indexPath) as! MineChefDetailsCell
            cell.selectionStyle = .none
            let array = self.headingArray[indexPath.section]
            cell.headingLabel.text = array[indexPath.row]
            return cell
        }
    }
    
    lazy var headView: FoodPurchaseSuccessView = {
        let view = Bundle.main.loadNibNamed("FoodPurchaseSuccessView", owner: nil, options: nil)?.last as! FoodPurchaseSuccessView
        view.frame = CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height:ChefReservationPayFinishUX.foodPurchaseSuccessViewHeight)
        view.foodPurchaseSuccessCallBack = {(_ foodPurchaseSuccessChooseType:FoodPurchaseSuccessChooseType) in
            if foodPurchaseSuccessChooseType == .seeDetailsStatus{
                let chefPayFinishVC = ChefPayFinishVC()
                self.navigationController?.pushViewController(chefPayFinishVC, animated: true)
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: ChefReservationPayFinishUX.foodPurchaseSuccessViewHeight , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE - ChefReservationPayFinishUX.foodPurchaseSuccessViewHeight))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ChefHeadCell", bundle: nil),forCellReuseIdentifier: self.chefHeadCell)
        tableView.register(UINib(nibName: "MineChefDetailsCell", bundle: nil),forCellReuseIdentifier: self.mineChefDetailsCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        return tableView
    }()

}
