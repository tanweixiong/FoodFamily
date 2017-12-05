//
//  RecommendDetailsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD

class RecommendDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate lazy var recommendDetailsVM : RecommendDetailsVM = RecommendDetailsVM()
    fileprivate let recommendNaviCell = "recommendNaviCell"
    fileprivate let recommendedReasonCell = "recommendedReasonCell"
    fileprivate let recommendedMomeyCell = "recommendedMomeyCell"
    fileprivate let recommendedCommentCell = "recommendedCommentCell"
    fileprivate let recommendMealCell = "RecommendMealCell"
    fileprivate let recommendedListMoneyCell = "RecommendedListMoneyCell"
    fileprivate var pageNum:Int = 1
    fileprivate let dataSource = NSMutableArray()
    fileprivate var isFirst:Bool = true
    fileprivate var refreshFooterView = SDRefreshFooterView()
    var storeID = ""
    
    struct RecommendDetailsUX {
        static let recommendHeadHeight:CGFloat = 108
        static let recommendNaviHeight:CGFloat = 50
        static let recommendedReasonHeight:CGFloat = 409
        static let recommendedMomeyHeight:CGFloat = 109
        static let recommendedCommentHeight:CGFloat = 200
        static let recommendedMealHeight:CGFloat = 113
        static let recommendedListMoneyHeight:CGFloat = 75
        static let sectionHeight:CGFloat = 20
        static let headimageHeight:CGFloat = 200
        static let headViewHeight:CGFloat = headimageHeight + recommendHeadHeight
        static let footViewHeight:CGFloat = 50
        static let logoViewSize:CGSize = CGSize(width: 50, height: 50)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataSource.add([""])
        self.dataSource.add([""])
        self.navigationController?.navigationBar.alpha = 0
    }

    @objc func backClick(){
        self.navigationController?.navigationBar.alpha = 1
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.view.addSubview(tableView)
       self.view.addSubview(recommendFootView)
       self.view.addSubview(backBtn)
       self.getData()
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
            tableView.scrollIndicatorInsets = tableView.contentInset
        }
    }
    
    func getData(){
        let parameters = ["storeId":storeID]
        //获取头部
        recommendDetailsVM.loadSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIStoreGetStoreInfo, parameters: parameters, showIndicator: false) {
            self.headScrollView.recommendDataModel = self.recommendDetailsVM.recommendDataModel
            self.recommendHeadView.recommendDataModel = self.recommendDetailsVM.recommendDataModel
            self.logoView.sd_setImage(with: NSURL(string: (self.recommendDetailsVM.recommendDataModel.logo!))! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
            self.recommendFootView.collectView.isSelected = self.recommendDetailsVM.recommendDataModel.isCollection == 0 ? false : true
            
            let voucherArray:NSArray = self.recommendDetailsVM.recommendDataModel.voucherList! as NSArray
            if voucherArray.count != 0 {
               self.dataSource.add(voucherArray)
            }
            
            let mealArray:NSArray = self.recommendDetailsVM.recommendDataModel.mealList! as NSArray
            if mealArray.count != 0 {
               self.dataSource.add(mealArray)
            }
            self.tableView.reloadData()
            self.getCommentData(isfirst: true)
        }
    }
    
    func getCommentData(isfirst:Bool){
        //获取评论列表
        let commentParameters = ["storeId":storeID,"pageNum":"\(self.pageNum)","pageSize":""]
        recommendDetailsVM.loadSuccessfullyCommentReturnedData(requestType: .get, URLString: ConstAPI.kAPIAssessGetAssessList, parameters: commentParameters, showIndicator: false) {(hasData:Bool) in
            self.pageNum = self.pageNum + 1
            if isfirst && self.recommendDetailsVM.recommendListModel.count != 0{
                self.dataSource.add(self.recommendDetailsVM.recommendListModel)
                self.tableView.reloadData()
            }
            if !isfirst && hasData == true {
                self.dataSource.replaceObject(at: self.dataSource.count - 1, with: self.recommendDetailsVM.recommendListModel)
                self.tableView.reloadData()
            }
           self.refreshFooterView.endRefreshing()
        }
    }
    
    func setCollectionStore(isCollection:Bool){
        let parameters = ["storeId":storeID]
        let url = isCollection ? ConstAPI.kAPIStoreCollectionStore : ConstAPI.kAPIStoreCancelCollection
        recommendDetailsVM.loadSuccessfullyReturnedData(requestType: .post, URLString: url, parameters: parameters, showIndicator: true, finishedCallback: {
            self.recommendFootView.collectView.isSelected = isCollection
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array:NSArray = self.dataSource[section] as! NSArray
        return array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UserDefaults.standard.object(forKey: "height") != nil ? UserDefaults.standard.object(forKey: "height") as! CGFloat : 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return RecommendDetailsUX.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: RecommendDetailsUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderHeight:CGFloat = RecommendDetailsUX.sectionHeight
        if scrollView == self.tableView {
            if scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 20 {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            }else if scrollView.contentOffset.y >= RecommendDetailsUX.sectionHeight {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            }
            if scrollView.contentOffset.y < 0 && self.isFirst{
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                self.isFirst = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: recommendNaviCell, for: indexPath) as! RecommendNaviCell
            cell.recommendDataModel = self.recommendDetailsVM.recommendDataModel
            cell.selectionStyle = .none
            UserDefaults.standard.set(RecommendDetailsUX.recommendNaviHeight, forKey: "height")
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: recommendedReasonCell, for: indexPath) as! RecommendedReasonCell
            cell.recommendDataModel = self.recommendDetailsVM.recommendDataModel
            cell.recommendedReasonCallBack = { (_ type:RecommendedType) in
                self.pushViewController(type,self.recommendDetailsVM.recommendDataModel)
            }
            cell.recommendedReasonRefreshTheData = {() in
                let vc = OCTools.getCurrentVC() as! RecommendDetailsVC
                vc.tableView.reloadData()
            }
            cell.selectionStyle = .none
            return cell
        }else{
            let array:NSArray = self.dataSource[indexPath.section] as! NSArray
            let model = array[indexPath.row]
            //金额
            if ((model as? RecommendVouchersModel) != nil) {
                let models:RecommendVouchersModel = model as! RecommendVouchersModel
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: recommendedMomeyCell, for: indexPath) as! RecommendedMoneyCell
                    cell.selectionStyle = .none
                    cell.moneyDataModel = models.voucher!
                    UserDefaults.standard.set(CGFloat(RecommendDetailsUX.recommendedMomeyHeight), forKey: "height")
                    cell.recommendedMoneyCallBack = {(model:RecommendVoucherDataModel) in
                        self.pushVouchersDetailStatus(model)
                    }
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: recommendedListMoneyCell, for: indexPath) as! RecommendedListMoneyCell
                    cell.selectionStyle = .none
                    cell.moneyDataModel = models.voucher!
                    UserDefaults.standard.set(CGFloat(RecommendDetailsUX.recommendedListMoneyHeight), forKey: "height")
                    cell.recommendedMoneyCallBack = {(model:RecommendVoucherDataModel) in
                        self.pushVouchersDetailStatus(model)
                    }
                    return cell
                }
            }
            //套餐
            if ((model as? RecommendMealsModel) != nil) {
            let models:RecommendMealsModel = model as! RecommendMealsModel
                let cell = tableView.dequeueReusableCell(withIdentifier: recommendMealCell, for: indexPath) as! RecommendMealCell
                cell.selectionStyle = .none
                cell.mealModel = models.meal!
                cell.recommendMealCallBack = { (model:RecommendMealDataModel) in
                    self.pushMealsDetailStatus(model)
                }
                UserDefaults.standard.set(CGFloat(RecommendDetailsUX.recommendedMealHeight), forKey: "height")
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: recommendedCommentCell, for: indexPath) as! RecommendedCommentCell
            cell.selectionStyle = .none
            if self.recommendDetailsVM.recommendListModel.count != 0{
                cell.commentDataModel = self.recommendDetailsVM.recommendListModel[indexPath.row]
                cell.setData()
            }
            return cell
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT - RecommendDetailsUX.footViewHeight))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "RecommendNaviCell", bundle: nil),forCellReuseIdentifier: self.recommendNaviCell)
        tableView.register(UINib(nibName: "RecommendedReasonCell", bundle: nil),forCellReuseIdentifier: self.recommendedReasonCell)
        tableView.register(UINib(nibName: "RecommendedMoneyCell", bundle: nil),forCellReuseIdentifier: self.recommendedMomeyCell)
       tableView.register(UINib(nibName: "RecommendedCommentCell", bundle: nil),forCellReuseIdentifier: self.recommendedCommentCell)
       tableView.register(UINib(nibName: "RecommendMealCell", bundle: nil),forCellReuseIdentifier: self.recommendMealCell)
       tableView.register(UINib(nibName: "RecommendedListMoneyCell", bundle: nil),forCellReuseIdentifier: self.recommendedListMoneyCell)
       tableView.backgroundColor = UIColor.white
       tableView.tableFooterView = UIView()
       let headView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: RecommendDetailsUX.headViewHeight))
        headView.backgroundColor = UIColor.white
        tableView.tableHeaderView = headView
        headView.addSubview(headScrollView)
        headView.addSubview(recommendHeadView)
        headView.addSubview(logoView)
        self.refreshFooterView = SDRefreshFooterView.init()
        self.refreshFooterView.add(toScroll: tableView)
        self.refreshFooterView.addTarget(self, refreshAction: #selector(getComment))
        return tableView
    }()
    
    @objc func getComment(){
        self.getCommentData(isfirst: false)
    }
    
    lazy var headScrollView: RecommendDetailsScrollView = {
        let view = RecommendDetailsScrollView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: RecommendDetailsUX.headimageHeight))
        return view
    }()
    
    lazy var logoView: UIImageView = {
        let space:CGFloat = 2
        let imageView = UIImageView()
        imageView.sd_setImage(with: NSURL(string: "")! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
        imageView.frame = CGRect(x: SCREEN_WIDTH/2 - RecommendDetailsUX.logoViewSize.width/2 , y:RecommendDetailsUX.headimageHeight - RecommendDetailsUX.logoViewSize.height/2, width: RecommendDetailsUX.logoViewSize.width, height: RecommendDetailsUX.logoViewSize.height);
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.R_UIColorFromRGB(color: 0xD3B269).cgColor
        return imageView
    }()
    
    lazy var recommendHeadView: RecommendHeadView = {
        let view = Bundle.main.loadNibNamed("RecommendHeadView", owner: nil, options: nil)?.last as! RecommendHeadView
        view.frame = CGRect(x: 0, y:RecommendDetailsUX.headimageHeight, width: SCREEN_WIDTH, height: RecommendDetailsUX.recommendHeadHeight)
        return view
    }()
    
    lazy var recommendFootView: RecommendedFoodView = {
        let view = Bundle.main.loadNibNamed("RecommendedFoodView", owner: nil, options: nil)?.last as! RecommendedFoodView
        view.frame = CGRect(x: 0, y:self.tableView.frame.maxY, width: SCREEN_WIDTH, height: RecommendDetailsUX.footViewHeight)
        view.recommendedFoodCallBack = {(_ type:RecommendedType) in
            self.pushViewController(type,self.recommendDetailsVM.recommendDataModel)
        }
        return view
    }()
    
    func pushViewController(_ recommendedType:RecommendedType,_ model:RecommendDataModel){
        self.navigationController?.navigationBar.alpha =  recommendedType == .collectionStatus ? 0 : 1
        switch recommendedType {
        case .collectionStatus:
            let isCollection = !self.recommendFootView.collectView.isSelected
            self.setCollectionStore(isCollection: isCollection)
            break
        case .reservationStatus:
            let foodReservationVC = FoodReservationVC()
            foodReservationVC.detailsModel = self.recommendDetailsVM.recommendDataModel
            self.navigationController?.pushViewController(foodReservationVC, animated: true)
            break
        //支付入口
        case .payStatus:
            let foodReservationPayVC = FoodReservationPayVC()
            foodReservationPayVC.detailsModel = self.recommendDetailsVM.recommendDataModel
            foodReservationPayVC.foodPaymentMethod = .immediatelyPaymentStatus
            self.navigationController?.pushViewController(foodReservationPayVC, animated: true)
            break
        case .recommendStatus:
            let foodRecommendDetailVC = FoodRecommendDetailVC()
            self.navigationController?.pushViewController(foodRecommendDetailVC, animated: true)
            break
        case .featuresStatus:
            let foodFeaturesDetailVC = FoodFeaturesDetailVC()
            foodFeaturesDetailVC.foodModel = self.recommendDetailsVM.recommendDataModel.foodList!
            self.navigationController?.pushViewController(foodFeaturesDetailVC, animated: true)
            break
        case .vouchersDetailStatus:
            let foodPurchaseNotesVC = FoodVoucherDetailsVC()
            self.navigationController?.pushViewController(foodPurchaseNotesVC, animated: true)
            break
        case .defaultDetailStatus:
            let foodMealDetailsVC = FoodMealDetailsVC()
            self.navigationController?.pushViewController(foodMealDetailsVC, animated: true)
            break
        default: break
        }
    }
    
    func pushVouchersDetailStatus(_ model:RecommendVoucherDataModel){
        let foodVoucherDetailsVC = FoodVoucherDetailsVC()
        foodVoucherDetailsVC.voucherID = model.voucherId!
        foodVoucherDetailsVC.recommendModel = self.recommendDetailsVM.recommendDataModel
        foodVoucherDetailsVC.voucherModel = model
        self.navigationController?.pushViewController(foodVoucherDetailsVC, animated: true)
    }
    
    func pushMealsDetailStatus(_ model:RecommendMealDataModel){
        let foodMealDetailsVC = FoodMealDetailsVC()
        foodMealDetailsVC.mealId = model.mealId!
        foodMealDetailsVC.recommendModel = self.recommendDetailsVM.recommendDataModel
        foodMealDetailsVC.mealModel = model
        self.navigationController?.pushViewController(foodMealDetailsVC, animated: true)
    }
    
    lazy var backBtn: UIButton = {
        let backButton = UIButton.init(type: .custom)
        backButton.setImage(UIImage(named: "ic_nav_back_white"), for: .normal)
        backButton.sizeToFit()
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        backButton.addTarget(self, action:  #selector(RecommendDetailsVC.backClick), for: .touchUpInside)
        backButton.frame = CGRect(x: 1, y: 21, width: 40, height: 40)
        return backButton
    }()
}
