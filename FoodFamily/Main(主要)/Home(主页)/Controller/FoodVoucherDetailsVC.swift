//
//  FoodPurchaseNotesVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodVoucherDetailsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    fileprivate lazy var viewModel : FoodVoucherDetailsVM = FoodVoucherDetailsVM()
    fileprivate let foodPurchaseNotesHeadView = "FoodPurchaseNotesHeadView"
    fileprivate let foodDetailsCell = "FoodDetailsCell"
    fileprivate let foodPurchaseNotesCell = "FoodPurchaseNotesCell"
    fileprivate let titleContentArray = ["套餐内容","购买须知"]
    var voucherID:NSNumber = 0
    var voucherModel: RecommendVoucherDataModel = RecommendVoucherDataModel()!
    var recommendModel: RecommendDataModel = RecommendDataModel()!

    struct FoodPurchaseNotesUX {
         static let footHeight:CGFloat = 50
         static let headViewHeight:CGFloat = 308
         static let sectionHeight:CGFloat = 15
         static let headimageHeight:CGFloat = 200
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.alpha = 0
    }

    //优惠券
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(footView)
        view.addSubview(backBtn)
        self.getData()
    }
    
    //加载优惠券详情
    func getData(){
        let parameters = ["voucherId":"\(self.voucherID)"]
        viewModel.loadSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIVouchersGetVoucherById, parameters: parameters, showIndicator: false) {
            self.setDisplayData()
            self.tableView.reloadData()
        }
    }
    
    //绑定并且刷新数据
    func setDisplayData(){
        headView.pirceLabel.text = "¥" + (viewModel.voucherModel.price?.stringValue)! + "代" + (viewModel.voucherModel.vouPrice?.stringValue)! + "元"
        
        let priceString = NSMutableAttributedString.init(string: (viewModel.voucherModel.vouPrice?.stringValue)!)
        priceString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSNumber.init(value: 1), range: NSRange(location: 0, length: priceString.length))
        footView.discountLabel.attributedText = priceString
        footView.priceLabel.text = viewModel.voucherModel.price?.stringValue
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return  titleContentArray.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: foodPurchaseNotesCell, for: indexPath) as! FoodPurchaseNotesCell
        cell.selectionStyle = .none
        cell.headingLabel.text = titleContentArray[indexPath.section]
        cell.setData(model:self.viewModel.voucherModel,index:indexPath.section)
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
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - FoodPurchaseNotesUX.footHeight), style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodPurchaseNotesCell", bundle: nil),forCellReuseIdentifier: self.foodPurchaseNotesCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = self.headView
        return tableView
    }()
    
    lazy var headView: FoodPurchaseNotesHeadView = {
        let view = Bundle.main.loadNibNamed("FoodPurchaseNotesHeadView", owner: nil, options: nil)?.last as! FoodPurchaseNotesHeadView
        view.frame = CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: FoodPurchaseNotesUX.headViewHeight)
        view.storeNameLabel.text = self.recommendModel.storeName
        view.logoImageView.sd_setImage(with: NSURL(string: (self.recommendModel.logo)!)! as URL, placeholderImage: UIImage.init(named: "ic_all_smallImageDefault"))
        view.storeImageView.addSubview(headScrollView)
        return view
    }()
    
    lazy var headScrollView: RecommendDetailsScrollView = {
        let view = RecommendDetailsScrollView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodPurchaseNotesUX.headimageHeight))
        view.recommendDataModel = self.recommendModel
        return view
    }()
    
    lazy var backBtn: UIButton = {
        let backButton = UIButton.init(type: .custom)
        backButton.setImage(UIImage(named: "ic_nav_back_white"), for: .normal)
        backButton.sizeToFit()
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        backButton.addTarget(self, action:  #selector(FoodVoucherDetailsVC.backClick), for: .touchUpInside)
        backButton.frame = CGRect(x: 1, y: 21, width: 40, height: 40)
        return backButton
    }()
    
    lazy var footView: FoodDetailsFoodView = {
        let view = Bundle.main.loadNibNamed("FoodDetailsFoodView", owner: nil, options: nil)?.last as! FoodDetailsFoodView
        view.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 50 , width: SCREEN_WIDTH, height: FoodPurchaseNotesUX.footHeight)
        view.buyNowCallBack = {(sender:UIButton) in
            self.navigationController?.navigationBar.alpha = 1
            let foodReservationPayVC = FoodReservationPayVC()
            foodReservationPayVC.foodPaymentMethod = .voucherPaymentStatus
            foodReservationPayVC.payPrice = self.footView.priceLabel.text!
            foodReservationPayVC.detailsModel = self.recommendModel
            foodReservationPayVC.voucherModel = self.voucherModel
            self.navigationController?.pushViewController(foodReservationPayVC, animated: true)
        }
        return view
    }()
    
    @objc func backClick(){
        self.navigationController?.navigationBar.alpha = 0
        self.navigationController?.popViewController(animated: true)
    }

}
