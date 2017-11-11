//
//  MineDiscountCouponsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineDiscountCouponsVC: UIViewController,SGPageTitleViewDelegate, SGPageContentViewDelegare {
    
    fileprivate let contentViewHeight:CGFloat = SCREEN_HEIGHT_INSIDE - 44
    fileprivate var pageContentView = SGPageContentView()
    fileprivate var pageTitleView = SGPageTitleView()
    fileprivate let titleArr:NSArray = ["可使用", "已过期"]
    
    struct MineDiscountCouponsUX {
        static let pageTitleViewHeight:CGFloat = 44
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "优惠卡券"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mineUsableCoupons = MineUsableCoupons()
        let mineExpiredCoupons = MineExpiredCoupons()
        let childVC = [mineUsableCoupons,mineExpiredCoupons]
        
        pageContentView = SGPageContentView(frame: CGRect(x: 0, y: MineDiscountCouponsUX.pageTitleViewHeight, width: SCREEN_WIDTH, height: contentViewHeight), parentVC: self, childVCs: childVC)
        pageContentView.delegatePageContentView = self
        view.addSubview(pageContentView)
        
        self.pageTitleView = SGPageTitleView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MineDiscountCouponsUX.pageTitleViewHeight), delegate: self, titleNames: titleArr as! [Any])
        self.pageTitleView.selectedIndex = 0
        self.pageTitleView.titleColorStateSelected = UIColor.R_UIRGBColor(red: 211, green: 178, blue: 105, alpha: 1)
        self.pageTitleView.titleColorStateNormal = UIColor.R_UIRGBColor(red: 155, green: 155, blue: 155, alpha: 1)
        self.pageTitleView.indicatorColor = UIColor.R_UIRGBColor(red: 211, green: 178, blue: 105, alpha: 1)
        self.pageTitleView.backgroundColor = UIColor.white
        view.addSubview(self.pageTitleView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sgPageTitleView(_ SGPageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.pageContentView.setPageCententViewCurrentIndex(selectedIndex)
        
    }
    
    func sgPageContentView(_ SGPageContentView: SGPageContentView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }

}
