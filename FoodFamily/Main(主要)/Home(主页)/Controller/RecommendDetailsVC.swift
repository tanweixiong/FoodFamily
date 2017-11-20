//
//  RecommendDetailsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RecommendDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    fileprivate lazy var recommendDetailsVM : RecommendDetailsVM = RecommendDetailsVM()
    fileprivate let recommendNaviCell = "recommendNaviCell"
    fileprivate let recommendedReasonCell = "recommendedReasonCell"
    fileprivate let recommendedMomeyCell = "recommendedMomeyCell"
    fileprivate let recommendedCommentCell = "recommendedCommentCell"
    var storeID = ""
    
    struct RecommendDetailsUX {
        static let recommendHeadHeight:CGFloat = 108
        static let recommendNaviHeight:CGFloat = 50
        static let recommendedReasonHeight:CGFloat = 409
        static let recommendedMomeyHeight:CGFloat = 109
        static let recommendedCommentHeight:CGFloat = 200
        static let sectionHeight:CGFloat = 20
        static let headimageHeight:CGFloat = 200
        static let headViewHeight:CGFloat = headimageHeight + recommendHeadHeight
        static let footViewHeight:CGFloat = 50
        static let logoViewSize:CGSize = CGSize(width: 50, height: 50)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.alpha = 0
    }
    
    @objc func backClick(){
        self.navigationController?.navigationBar.alpha = 1
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.getData()
       self.view.addSubview(tableView)
       self.view.addSubview(recommendFootView)
       self.view.addSubview(backBtn)
    }
    
    func getData(){
        print(self.storeID)
        let parameters = ["storeId":self.storeID]
        recommendDetailsVM.loadSuccessfullyReturnedData(requestType: .post, URLString: ConstAPI.kAPIStoreGetStoreInfo, parameters: parameters, showIndicator: true) {
            self.tableView.reloadData()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return  4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return RecommendDetailsUX.recommendNaviHeight
        }else if indexPath.section == 1 {
            return  UserDefaults.standard.object(forKey: "height") != nil ? UserDefaults.standard.object(forKey: "height") as! CGFloat : 0
        }else if indexPath.section == 2 {
            return RecommendDetailsUX.recommendedMomeyHeight
        }else{
            return RecommendDetailsUX.recommendedCommentHeight
        }
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
            if scrollView.contentOffset.y < 0 {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: recommendNaviCell, for: indexPath) as! RecommendNaviCell
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: recommendedReasonCell, for: indexPath) as! RecommendedReasonCell
            cell.setData()
            cell.recommendedReasonCallBack = { (_ type:RecommendedType) in
                self.pushViewController(type)
            }
            cell.recommendedReasonRefreshTheData = {() in
                let vc = OCTools.getCurrentVC() as! RecommendDetailsVC
                vc.tableView.reloadData()
            }
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: recommendedMomeyCell, for: indexPath) as! RecommendedMoneyCell
            cell.recommendedMoneyCallBack = {(sender:UIButton) in
                self.pushViewController(.vouchersDetailStatus)
            }
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: recommendedCommentCell, for: indexPath) as! RecommendedCommentCell
            cell.selectionStyle = .none
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
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: RecommendDetailsUX.headViewHeight))
        headView.backgroundColor = UIColor.white
        tableView.tableHeaderView = headView
        
        headView.addSubview(headImageView)
        headView.addSubview(recommendHeadView)
        headView.addSubview(logoView)
        return tableView
    }()
    
    lazy var headImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "foodDeatil")
        imageView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: RecommendDetailsUX.headimageHeight)
        return imageView
    }()
    
    lazy var logoView: UIImageView = {
        let space:CGFloat = 2
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "foodDeatil")
        imageView.frame = CGRect(x: SCREEN_WIDTH/2 - RecommendDetailsUX.logoViewSize.width/2 , y:self.headImageView.frame.maxY - RecommendDetailsUX.logoViewSize.height/2, width: RecommendDetailsUX.logoViewSize.width, height: RecommendDetailsUX.logoViewSize.height);
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
           self.pushViewController(recommendedType)
        }
        return view
    }()
    
    func pushViewController(_ recommendedType:RecommendedType){
        self.navigationController?.navigationBar.alpha = 1
        switch recommendedType {
        case .collectionStatus:
            
            break
        case .reservationStatus:
            let foodReservationVC = FoodReservationVC()
            self.navigationController?.pushViewController(foodReservationVC, animated: true)
            break
        case .payStatus:
            let foodReservationPayVC = FoodReservationPayVC()
            self.navigationController?.pushViewController(foodReservationPayVC, animated: true)
            break
        case .recommendStatus:
            let foodRecommendDetailVC = FoodRecommendDetailVC()
            self.navigationController?.pushViewController(foodRecommendDetailVC, animated: true)
            break
        case .featuresStatus:
            let foodFeaturesDetailVC = FoodFeaturesDetailVC()
            self.navigationController?.pushViewController(foodFeaturesDetailVC, animated: true)
            break
        case .vouchersDetailStatus:
            let foodPurchaseNotesVC = FoodPurchaseNotesVC()
            self.navigationController?.pushViewController(foodPurchaseNotesVC, animated: true)
            break
        case .defaultDetailStatus:
            let foodDetailsVC = FoodDetailsVC()
            self.navigationController?.pushViewController(foodDetailsVC, animated: true)
            break

        default: break
   
        }
    }
    
    lazy var backBtn: UIButton = {
        let backButton = UIButton.init(type: .custom)
        backButton.setImage(UIImage(named: "ic_nav_back_white"), for: .normal)
        backButton.sizeToFit()
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        backButton.addTarget(self, action:  #selector(FoodDetailsVC.backClick), for: .touchUpInside)
        backButton.frame = CGRect(x: 1, y: 21, width: 40, height: 40)
        return backButton
    }()
}
