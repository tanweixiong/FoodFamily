//
//  MineReservationFinishVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineReservationFinishVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    fileprivate let mineReservationFinishCell = "mineReservationFinishCell"
    
    struct MineReservationFinishUX {
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
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineReservationFinishUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineReservationFinishUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  MineReservationFinishUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineReservationFinishCell, for: indexPath) as! MineReservationCell
        cell.selectionStyle = .none
        cell.reservationStatusLabel.text = "预约成功"
        return cell
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE - 44))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineReservationCell", bundle: nil),forCellReuseIdentifier: self.mineReservationFinishCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        return tableView
    }()

}
