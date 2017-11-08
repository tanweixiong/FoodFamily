//
//  FoodPurchaseSuccessVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/8.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodPurchaseSuccessVC: MainViewController {
    
    struct FoodPurchaseSuccessUX {
        static let foodPurchaseSuccessViewHeight:CGFloat = 300
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.alpha = 1
        
        self.title = "支付"
        self.addDefaultButtonTextRight("关闭")
        self.addDefaultButtonImageLeft("")
        
        self.view.backgroundColor = UIColor.R_UIRGBColor(red: 251, green: 251, blue: 251, alpha: 1)
        view.addSubview(footView)
    }
    
    override func leftImageBtn(_ sender: UIBarButtonItem) {
        
    }
    
    override func rightTextBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var footView: FoodPurchaseSuccessView = {
        let view = Bundle.main.loadNibNamed("FoodPurchaseSuccessView", owner: nil, options: nil)?.last as! FoodPurchaseSuccessView
        view.frame = CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height:FoodPurchaseSuccessUX.foodPurchaseSuccessViewHeight)
        view.foodPurchaseSuccessCallBack = {(_ foodPurchaseSuccessChooseType:FoodPurchaseSuccessChooseType) in
            if foodPurchaseSuccessChooseType == .seeDetailsStatus{
                
            }else{
                
            }
        }
        return view
    }()
}
