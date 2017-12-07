//
//  ChefReservationPayVC.swift
//  FoodFamily
//
//  Created by tam on 2017/12/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class ChefReservationPayVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    fileprivate let foodPaymentConsumptionVC = "FoodPaymentConsumptionVC"
    fileprivate let foodReservationPaymentMethodCell = "FoodReservationPaymentMethodCell"
    fileprivate var totalNumTextField = UITextField()
    fileprivate var headingArray = ["输入消费金额","钱包支付","积分券"]
    fileprivate var imageViewArray = ["输入消费金额","ic_home_card","ic_home_wodejifen"]
    struct ChefReservationPayUX {
        static let cellHeight:CGFloat = 44
        static let sectionHeight:CGFloat = 15
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "支付金额"
        self.view.addSubview(tableView)
        self.tableView.addSubview(confirmBtn)
        //添加手势
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(closeKeyboard))
        self.tableView.addGestureRecognizer(tap)
    }
    
    @objc func confirmOnClick(){
        let chefReservationPayFinishVC = ChefReservationPayFinishVC()
        self.navigationController?.pushViewController(chefReservationPayFinishVC, animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return  3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  ChefReservationPayUX.cellHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : ChefReservationPayUX.sectionHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: ChefReservationPayUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodPaymentConsumptionVC, for: indexPath) as! FoodPaymentConsumptionVC
            cell.selectionStyle = .none
            cell.textfield.delegate = self
            cell.textfield.keyboardType = .numberPad
            totalNumTextField = cell.textfield
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: foodReservationPaymentMethodCell, for: indexPath) as! FoodReservationPaymentMethodCell
            cell.chooseBtn.isSelected = indexPath.section == 1 ? true : false
            cell.selectionStyle = .none
            cell.headingLabel.text = headingArray[indexPath.section]
            cell.iconImageView.image = UIImage.init(named: (imageViewArray[indexPath.section] ))
           return cell
        }
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodPaymentConsumptionVC", bundle: nil),forCellReuseIdentifier: self.foodPaymentConsumptionVC)
        tableView.register(UINib(nibName: "FoodReservationPaymentMethodCell", bundle: nil),forCellReuseIdentifier: self.foodReservationPaymentMethodCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var confirmBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect(x: 15, y: YMAKE(392) , width: SCREEN_WIDTH - 30, height: 50)
        btn.addTarget(self, action:  #selector(ChefReservationPayVC.confirmOnClick), for: .touchUpInside)
        btn.setTitle("确定支付", for: .normal)
        btn.backgroundColor = UIColor.R_UIRGBColor(red: 211, green: 178, blue: 105, alpha: 1)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        return btn
    }()

}
