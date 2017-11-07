//
//  FoodReservationVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodReservationVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    fileprivate let dataScore:NSArray = ["预约人数","预约时间","请手机号输入","验证码天蝎","需支付预金"]
    fileprivate let foodReservationCell = "FoodReservationCell"
    fileprivate let foodReservationCodeCell = "FoodReservationCodeCell"
    fileprivate let foodReservationFilliCell = "FoodReservationFilliCell"
    fileprivate var foodReservationCodeText = ""
    
    struct FoodReservationUX {
        static let rowHeight:CGFloat = 44
        static let sectionHeight:CGFloat = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.alpha = 1
        self.title = "预约"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.addSubview(nextBtn)
    }
    
    @objc func nextOnClick(){
        let vc = FoodReservationPayVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FoodReservationUX.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? FoodReservationUX.sectionHeight/2 : FoodReservationUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodReservationUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationCell, for: indexPath) as! FoodReservationCell
            cell.selectionStyle = .none
            cell.chooseView.isHidden = indexPath.section == 0 || indexPath.section == 1 ? false : true
            cell.priceLabel.isHidden = indexPath.section == 4 ? false : true
            cell.headingLabel.text = self.dataScore[indexPath.section] as? String
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationCodeCell, for: indexPath) as! FoodReservationCodeCell
            cell.headingLabel.text = self.dataScore[indexPath.section] as? String
            cell.foodReservationCodeCallBack = {() in
                
            }
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationFilliCell, for: indexPath) as! FoodReservationFilliCell
            cell.selectionStyle = .none
            cell.headingLabel.text = self.dataScore[indexPath.section] as? String
            cell.foodReservationFillTextFiledCallBack = { (codeStr:String) in
                self.foodReservationCodeText = codeStr
            }
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //去除section移动
        let sectionHeaderHeight:CGFloat = FoodReservationUX.sectionHeight
        if scrollView == self.tableView {
            if scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0 {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            }else if scrollView.contentOffset.y >= FoodReservationUX.sectionHeight {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodReservationCell", bundle: nil),forCellReuseIdentifier: self.foodReservationCell)
        tableView.register(UINib(nibName: "FoodReservationCodeCell", bundle: nil),forCellReuseIdentifier: self.foodReservationCodeCell)
        tableView.register(UINib(nibName: "FoodReservationFilliCell", bundle: nil),forCellReuseIdentifier: self.foodReservationFilliCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var nextBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect(x: 15, y: YMAKE(370) , width: SCREEN_WIDTH - 30, height: 50)
        btn.addTarget(self, action:  #selector(FoodReservationVC.nextOnClick), for: .touchUpInside)
        btn.setTitle("下一步", for: .normal)
        btn.backgroundColor = UIColor.R_UIRGBColor(red: 211, green: 178, blue: 105, alpha: 1)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        return btn
    }()
    
}
