//
//  FoodPurchaseNotesVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodPurchaseNotesVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    fileprivate let foodPurchaseNotesHeadView = "FoodPurchaseNotesHeadView"
    fileprivate let foodDetailsCell = "FoodDetailsCell"
    fileprivate let foodPurchaseNotesCell = "FoodPurchaseNotesCell"
    
    struct FoodPurchaseNotesUX {
         static let footHeight:CGFloat = 50
         static let headViewHeight:CGFloat = 308
         static let sectionHeight:CGFloat = 20
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return  3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserDefaults.standard.object(forKey: "height") != nil ? UserDefaults.standard.object(forKey: "height") as! CGFloat : 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  section == 0 ? FoodPurchaseNotesUX.sectionHeight : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodPurchaseNotesUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0  {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodDetailsCell, for: indexPath) as! FoodDetailsCell
            cell.selectionStyle = .none
            cell.setData()
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodPurchaseNotesCell, for: indexPath) as! FoodPurchaseNotesCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - FoodPurchaseNotesUX.footHeight), style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodPurchaseNotesHeadView", bundle: nil),forCellReuseIdentifier: self.foodPurchaseNotesHeadView)
        tableView.register(UINib(nibName: "FoodDetailsCell", bundle: nil),forCellReuseIdentifier: self.foodDetailsCell)
        tableView.register(UINib(nibName: "FoodPurchaseNotesCell", bundle: nil),forCellReuseIdentifier: self.foodPurchaseNotesCell)
        tableView.backgroundColor = UIColor.clear
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = self.headView
        return tableView
    }()
    
    lazy var headView: FoodPurchaseNotesHeadView = {
        let view = Bundle.main.loadNibNamed("FoodPurchaseNotesHeadView", owner: nil, options: nil)?.last as! FoodPurchaseNotesHeadView
        view.frame = CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: FoodPurchaseNotesUX.headViewHeight)
        return view
    }()
    
    lazy var footView: FoodDetailsFoodView = {
        let view = Bundle.main.loadNibNamed("FoodDetailsFoodView", owner: nil, options: nil)?.last as! FoodDetailsFoodView
        view.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 50 , width: SCREEN_WIDTH, height: FoodPurchaseNotesUX.footHeight)
        let priceString = NSMutableAttributedString.init(string: "¥58921")
        priceString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSNumber.init(value: 1), range: NSRange(location: 0, length: priceString.length))
        view.discountLabel.attributedText = priceString
        view.buyNowCallBack = {(sender:UIButton) in
            
        }
        return view
    }()

}
