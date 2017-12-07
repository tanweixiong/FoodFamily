//
//  ChefDetailsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/12/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class ChefDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate let chefHeadCell = "ChefHeadCell"
    fileprivate let chefDetailsCell = "ChefDetailsCell"
    
    struct ChefDetailsUX {
        static let headHeight:CGFloat = 102
        static let sectionLineHeight:CGFloat = 15
        static let reservationHeight:CGFloat = 50
    }
    
   @objc override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "厨师详情"
        self.view.addSubview(tableView)
        self.view.addSubview(immediateReservationBtn)
    }
    
    //立即预约
    @objc func immediateReservationOnClick(_ sender:UIButton){
        let chefReservationVC = ChefReservationVC()
        self.navigationController?.pushViewController(chefReservationVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return ChefDetailsUX.headHeight
        }else{
            return UserDefaults.standard.object(forKey: "height") != nil ? UserDefaults.standard.object(forKey: "height") as! CGFloat : 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : ChefDetailsUX.sectionLineHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: ChefDetailsUX.sectionLineHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: chefHeadCell, for: indexPath) as! ChefHeadCell
            cell.selectionStyle = .none
            cell.backGroundVw.layer.cornerRadius = 5
            cell.backGroundVw.clipsToBounds = true
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: chefDetailsCell, for: indexPath) as! ChefDetailsCell
            cell.selectionStyle = .none
            cell.setData()
            return cell
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE - ChefDetailsUX.reservationHeight))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ChefHeadCell", bundle: nil),forCellReuseIdentifier: self.chefHeadCell)
         tableView.register(UINib(nibName: "ChefDetailsCell", bundle: nil),forCellReuseIdentifier: self.chefDetailsCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var immediateReservationBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("立即预约", for: .normal)
        btn.backgroundColor =  R_UIThemeGoldColor
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.frame = CGRect(x: 0, y: tableView.frame.maxY , width: SCREEN_WIDTH, height: ChefDetailsUX.reservationHeight)
        btn.addTarget(self, action: #selector(immediateReservationOnClick(_:)), for: .touchUpInside)
        return btn
    }()

}
