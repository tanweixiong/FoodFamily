//
//  FoodDetailsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodDetailsVC: MainViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate let FoodDetailsCell = "FoodDetailsCell"
    
    struct FoodDetailsUX {
        static let rowHeight:CGFloat = 135
        static let sectionHeight:CGFloat = 20
        static let imageHeight:CGFloat =  640 / (1200/SCREEN_WIDTH)
        static let logoViewSize:CGSize = CGSize(width: 50, height: 50)
        static let titleHeight:CGFloat = 22
        static let headViewHeight: CGFloat = 280
        static let footHeight:CGFloat = 50
    }
    var origialFrame:CGRect = CGRect()
    var bgImageV:UIImageView = UIImageView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }
    
    @objc func backClick(){
        self.navigationController?.navigationBar.alpha = 1
        self.navigationController?.popViewController(animated: true)
    }
    
    func createUI(){
        self.view.addSubview(headImageView)
        self.view.addSubview(logoView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(footView)
        
        titleLabel.text = "喜贺极上烤肉"
        let titleSize:CGSize = titleLabel.getStringSize(text: titleLabel.text!, size: CGSize(width:SCREEN_WIDTH,height:FoodDetailsUX.titleHeight), font: 16)
        titleLabel.frame = CGRect(x: SCREEN_WIDTH/2 - titleSize.width/2, y: titleLabel.frame.origin.y, width: titleSize.width, height: FoodDetailsUX.titleHeight)

        bgImageV = headImageView
        origialFrame = headImageView.frame
        
        self.view.addSubview(tableView)
        self.view.addSubview(backBtn)
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
        return section == 0 ? FoodDetailsUX.sectionHeight : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodDetailsUX.sectionHeight))
        view.backgroundColor = R_UISectionLineColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodDetailsCell, for: indexPath) as! FoodDetailsCell
        cell.selectionStyle = .none
        cell.setData()
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y_offset = scrollView.contentOffset.y
        if y_offset > 0 {
            bgImageV.frame.origin.y = origialFrame.origin.y - y_offset
            logoView.frame.origin.y = bgImageV.frame.maxY - FoodDetailsUX.logoViewSize.height/2
            titleLabel.frame.origin.y = logoView.frame.maxY + 10
        }else{
            let height = self.origialFrame.size.height - y_offset
            let width = height/640*1200// 有高度 算出 宽
            let x = origialFrame.origin.x - (width-origialFrame.size.width)/2
            let frame = CGRect(x: x, y: origialFrame.origin.y, width: width, height: height)
            bgImageV.frame = frame
            
            logoView.frame = CGRect(x: logoView.frame.origin.x, y: bgImageV.frame.maxY - FoodDetailsUX.logoViewSize.height/2, width: logoView.frame.size.width, height: logoView.frame.size.height)
            
            titleLabel.frame = CGRect(x: titleLabel.frame.origin.x, y:logoView.frame.maxY + 10, width: titleLabel.frame.size.width, height: FoodDetailsUX.titleHeight)
        }
        
        //去除section移动
        let sectionHeaderHeight:CGFloat = FoodDetailsUX.sectionHeight
        if scrollView == self.tableView {
            if scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0 {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            }else if scrollView.contentOffset.y >= FoodDetailsUX.sectionHeight {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - FoodDetailsUX.footHeight), style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodDetailsCell", bundle: nil),forCellReuseIdentifier: self.FoodDetailsCell)
        tableView.backgroundColor = UIColor.clear
        tableView.tableFooterView = UIView()
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodDetailsUX.headViewHeight))
        headView.backgroundColor = UIColor.clear
        tableView.tableHeaderView = headView
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var headImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "foodDeatil")
        imageView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FoodDetailsUX.imageHeight)
        return imageView
    }()
    
    lazy var logoView: UIImageView = {
        let space:CGFloat = 2
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "foodDeatil")
        imageView.frame = CGRect(x: SCREEN_WIDTH/2 - FoodDetailsUX.logoViewSize.width/2 , y:self.headImageView.frame.maxY - FoodDetailsUX.logoViewSize.height/2, width: FoodDetailsUX.logoViewSize.width, height: FoodDetailsUX.logoViewSize.height);
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
        backButton.addTarget(self, action:  #selector(FoodDetailsVC.backClick), for: .touchUpInside)
        backButton.frame = CGRect(x: 1, y: 21, width: 40, height: 40)
        return backButton
    }()
    
    lazy var footView: FoodDetailsFoodView = {
        let view = Bundle.main.loadNibNamed("FoodDetailsFoodView", owner: nil, options: nil)?.last as! FoodDetailsFoodView
        view.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 50 , width: SCREEN_WIDTH, height: FoodDetailsUX.footHeight)
        let priceString = NSMutableAttributedString.init(string: "¥58921")
        priceString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSNumber.init(value: 1), range: NSRange(location: 0, length: priceString.length))
        view.discountLabel.attributedText = priceString
        view.buyNowCallBack = {(sender:UIButton) in
            let foodReservationPayVC = FoodReservationPayVC()
            foodReservationPayVC.foodPaymentMethod = .normalPaymentStatus
            self.navigationController?.pushViewController(foodReservationPayVC, animated: true)
        }
        return view
    }()
    
}
