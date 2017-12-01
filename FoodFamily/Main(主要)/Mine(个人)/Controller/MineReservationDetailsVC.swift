//
//  MineReservationDetailsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/12/1.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineReservationDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate lazy var viewModel : MineReservationDetailsVM = MineReservationDetailsVM()
    fileprivate let headingCotentArray = [[""],["手机号"],["预约人数","预约时间"],["订单编号","下单时间","支付方式"]]
    fileprivate var headingCotentDataArray = [[""],[""],["",""],["","",""]]
    fileprivate let foodReservationPayCell = "FoodReservationPayCell"
    fileprivate let mineReservationDetailsCell = "MineReservationDetailsCell"
    var orderNo = ""
    struct MineReservationDetailsUX {
        static let headHeight:CGFloat = 90
        static let cellHeight:CGFloat = 44
        static let sectionHeight:CGFloat = 15
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "预约详情"
        view.addSubview(tableView)
        self.getData()
    }
    
    func getData(){
        let parameters = ["orderNo":orderNo]
        viewModel.loadSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIOrdreGetUserReserveInfo, parameters: parameters, showIndicator: false) {
            let phone = self.viewModel.model.phone!
            let appointmentTime = self.viewModel.model.appointmentTime!
            let appointmentNum = self.viewModel.model.appointmentNum!
            let orderNo = self.viewModel.model.orderNo!
            let orderTime = self.viewModel.model.orderTime!
            let payType = self.viewModel.model.payType!
            self.headingCotentDataArray = [[""],[phone],[appointmentNum,appointmentTime],[orderNo,orderTime,payType]]
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  headingCotentArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array:NSArray = headingCotentArray[section] as NSArray
        return array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return MineReservationDetailsUX.headHeight
        }else{
            return MineReservationDetailsUX.cellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let foodEvaluationVC = FoodEvaluationVC()
            self.navigationController?.pushViewController(foodEvaluationVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : MineReservationDetailsUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineReservationDetailsUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationPayCell, for: indexPath) as! FoodReservationPayCell
            cell.selectionStyle = .none
            cell.iconImageView.sd_setImage(with: NSURL(string: (viewModel.model.logo)!)! as URL, placeholderImage: UIImage.init(named: "ic_all_smallImageDefault"))
            cell.storeNameLabel.text = viewModel.model.storeName
            cell.priceLabel.text = viewModel.model.expired
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: mineReservationDetailsCell, for: indexPath) as! MineReservationDetailsCell
            cell.selectionStyle = .none
            let heading = self.headingCotentArray[indexPath.section] as NSArray
            cell.headingLabel.text = heading[indexPath.row] as? String
    
            let content = self.headingCotentDataArray[indexPath.section] as NSArray
            cell.contentLabel.text = content[indexPath.row] as? String
            return cell
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodReservationPayCell", bundle: nil),forCellReuseIdentifier: self.foodReservationPayCell)
        tableView.register(UINib(nibName: "MineReservationDetailsCell", bundle: nil),forCellReuseIdentifier: self.mineReservationDetailsCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        return tableView
    }()
}
