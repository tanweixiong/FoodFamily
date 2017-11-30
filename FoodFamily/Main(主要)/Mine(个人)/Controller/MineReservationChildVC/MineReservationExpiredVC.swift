//
//  MineReservationExpiredVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineReservationExpiredVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    fileprivate lazy var viewModel : MineReservationVM = MineReservationVM()
    fileprivate let mineReservationExpiredCell = "MineReservationExpiredCell"
    
    struct MineReservationExpiredUX {
        static let sectionHeight:CGFloat = 20
        static let cellHeight:CGFloat = 100
        static let textColor = UIColor.R_UIRGBColor(red: 155, green: 155, blue: 155, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        self.getData()
    }
    
    func getData(){
        let parameters = ["":""]
        viewModel.loadSuccessfullyReturnedData(requestType: .get, URLString:ConstAPI.kAPIReservationList , parameters: parameters, showIndicator: false) {
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineReservationExpiredUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineReservationExpiredUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  MineReservationExpiredUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineReservationExpiredCell, for: indexPath) as! MineReservationCell
        cell.selectionStyle = .none
        cell.reservationStatusLabel.text = "预约失效"
        cell.logoImageView.sd_setImage(with: NSURL(string: "")! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
        cell.storeName.text = ""
        cell.createTimeLabel.text = ""
        return cell
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE - 44))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineReservationCell", bundle: nil),forCellReuseIdentifier: self.mineReservationExpiredCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        return tableView
    }()

}
