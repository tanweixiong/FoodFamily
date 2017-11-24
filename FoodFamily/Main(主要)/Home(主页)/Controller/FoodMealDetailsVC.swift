//
//  FoodDetailsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodMealDetailsVC: MainViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate let foodPurchaseNotesCell = "FoodPurchaseNotesCell"
    fileprivate lazy var viewModel : FoodMealDetailsVM = FoodMealDetailsVM()
    var recommendModel: RecommendDataModel = RecommendDataModel()!
    var mealId:NSNumber = 0
    
    struct FoodDetailsUX {
        static let rowHeight:CGFloat = 135
        static let sectionHeight:CGFloat = 15
        static let logoViewSize:CGSize = CGSize(width: 50, height: 50)
        static let titleHeight:CGFloat = 22
        static let headViewHeight: CGFloat = 280
        static let footHeight:CGFloat = 50
        static let imageHeight:CGFloat = 200
    }
    var origialFrame:CGRect = CGRect()
    var bgImageV:UIView = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.getData()
    }
    
    func getData(){
        let parameters = ["mealId":"\(self.mealId)"]
        viewModel.loadSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIMealGetMealInfoById, parameters: parameters, showIndicator: false) {
            self.setDisplayData()
            self.tableView.reloadData()
        }
    }
    
    func createUI(){
        self.view.addSubview(footView)
        self.view.addSubview(tableView)
        self.view.addSubview(backBtn)
        self.setDisplayData()
    }
    
    func setDisplayData(){
        titleLabel.text = self.recommendModel.storeName
        
        let priceString = NSMutableAttributedString.init(string: (viewModel.mealModel.mealPrice?.stringValue)!)
        priceString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSNumber.init(value: 1), range: NSRange(location: 0, length: priceString.length))
        footView.discountLabel.attributedText = priceString
        footView.priceLabel.text = viewModel.mealModel.mealMarketPrice?.stringValue
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserDefaults.standard.object(forKey: "height") != nil ? UserDefaults.standard.object(forKey: "height") as! CGFloat : 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? FoodDetailsUX.sectionHeight : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodDetailsUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: foodPurchaseNotesCell, for: indexPath) as! FoodPurchaseNotesCell
        cell.selectionStyle = .none
        cell.setPackageDetails(model: self.viewModel.mealModel)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderHeight:CGFloat = 20
        if scrollView == self.tableView {
            if scrollView.contentOffset.y < 0 {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - FoodDetailsUX.footHeight), style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodPurchaseNotesCell", bundle: nil),forCellReuseIdentifier: self.foodPurchaseNotesCell)
        tableView.tableFooterView = UIView()
        headView.backgroundColor = UIColor.white
        tableView.tableHeaderView = self.headView
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var headView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodDetailsUX.headViewHeight)
        view.addSubview(self.headScrollView)
        view.addSubview(self.logoView)
        view.addSubview(self.titleLabel)
        return view
    }()
    
    lazy var headScrollView: RecommendDetailsScrollView = {
        let view = RecommendDetailsScrollView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodDetailsUX.imageHeight))
        view.recommendDataModel = self.recommendModel
        return view
    }()
    
    lazy var logoView: UIImageView = {
        let space:CGFloat = 2
        let imageView = UIImageView()
        imageView.sd_setImage(with: NSURL(string: (self.recommendModel.logo)!)! as URL, placeholderImage: UIImage.init(named: "ic_all_smallImageDefault"))
        imageView.frame = CGRect(x: SCREEN_WIDTH/2 - FoodDetailsUX.logoViewSize.width/2 , y:self.headScrollView.frame.maxY - FoodDetailsUX.logoViewSize.height/2, width: FoodDetailsUX.logoViewSize.width, height: FoodDetailsUX.logoViewSize.height);
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.R_UIColorFromRGB(color: 0xD3B269).cgColor
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.R_UIColorFromRGB(color: 0x191619)
        label.frame = CGRect(x: 0, y: self.logoView.frame.maxY + 10, width: SCREEN_WIDTH, height: FoodDetailsUX.titleHeight)
        label.textAlignment = .center
        return label
    }()
    
     lazy var backBtn: UIButton = {
        let backButton = UIButton.init(type: .custom)
        backButton.setImage(UIImage(named: "ic_nav_back_white"), for: .normal)
        backButton.sizeToFit()
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        backButton.addTarget(self, action:  #selector(FoodMealDetailsVC.backClick), for: .touchUpInside)
        backButton.frame = CGRect(x: 1, y: 21, width: 40, height: 40)
        return backButton
    }()
    
    lazy var footView: FoodDetailsFoodView = {
        let view = Bundle.main.loadNibNamed("FoodDetailsFoodView", owner: nil, options: nil)?.last as! FoodDetailsFoodView
        view.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 50 , width: SCREEN_WIDTH, height: FoodDetailsUX.footHeight)
        view.buyNowCallBack = {(sender:UIButton) in
            self.navigationController?.navigationBar.alpha = 1
            let foodReservationPayVC = FoodReservationPayVC()
            foodReservationPayVC.foodPaymentMethod = .normalPaymentStatus
            foodReservationPayVC.paymentMethod = .ordinaryPaymentStatus
            self.navigationController?.pushViewController(foodReservationPayVC, animated: true)
        }
        return view
    }()
    
    @objc func backClick(){
        self.navigationController?.navigationBar.alpha = 1
        self.navigationController?.popViewController(animated: true)
    }
    
}
