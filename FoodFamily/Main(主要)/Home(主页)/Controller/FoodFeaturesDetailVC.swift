//
//  FoodFeaturesDetailVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/8.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodFeaturesDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var foodModel : [RecommendFoodDataModel] = [RecommendFoodDataModel]()
    fileprivate let foodFeaturesDetailCell = "FoodFeaturesDetailCell"
    
    struct FoodFeaturesDetailUX {
        static let cellHeight:CGFloat = 130
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "特色菜"
        self.view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  FoodFeaturesDetailUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: foodFeaturesDetailCell, for: indexPath) as! FoodFeaturesDetailCell
        cell.selectionStyle = .none
        let model = foodModel[indexPath.row]
        cell.iconImageView.sd_setImage(with: NSURL(string: (model.foodImg)!)! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
        cell.nameLabel.text = model.foodName
        return cell
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodFeaturesDetailCell", bundle: nil),forCellReuseIdentifier: self.foodFeaturesDetailCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        return tableView
    }()
}
