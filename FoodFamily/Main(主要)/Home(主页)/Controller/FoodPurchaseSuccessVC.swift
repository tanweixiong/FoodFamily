//
//  FoodPurchaseSuccessVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/8.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

enum OrderPaymentMethod {
    case ordinaryPaymentStatus //线上支付方式
    case voucherPaymentStatus //代金券支付方式
}
class FoodPurchaseSuccessVC: MainViewController {
    var paymentMethod = FoodPaymentMethodStatus.voucherPaymentStatus
    var finishText = ""
    var ecPrice = ""
    var price = ""
    struct FoodPurchaseSuccessUX {
        static let foodPurchaseSuccessViewHeight:CGFloat = 220
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "支付"
        navigationController?.navigationBar.alpha = 1
        view.backgroundColor = UIColor.R_UIRGBColor(red: 251, green: 251, blue: 251, alpha: 1)
        view.addSubview(headView)
        headView.finishLabel.text = finishText
        let text = "支付成功，消费"
        if paymentMethod == .mealPaymentStatus || paymentMethod == .voucherPaymentStatus {
            self.headView.finishLabel.text = text + ecPrice + "个EC"
        }else{
            self.headView.finishLabel.text = text + price + "个金额"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDefaultButtonTextRight("关闭")
        self.addDefaultButtonImageLeft("")
    }
    
    override func leftImageBtn(_ sender: UIBarButtonItem) {
        
    }
    
    override func rightTextBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var headView: FoodPurchaseSuccessView = {
        let view = Bundle.main.loadNibNamed("FoodPurchaseSuccessView", owner: nil, options: nil)?.last as! FoodPurchaseSuccessView
        view.frame = CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height:FoodPurchaseSuccessUX.foodPurchaseSuccessViewHeight)
        view.foodPurchaseSuccessCallBack = {(_ foodPurchaseSuccessChooseType:FoodPurchaseSuccessChooseType) in
            if foodPurchaseSuccessChooseType == .seeDetailsStatus{
//                if self.paymentMethod == .ordinaryPaymentStatus{
//                    let foodPackageOrderDetailsVC = FoodPackageOrderDetailsVC()
//                    self.navigationController?.pushViewController(foodPackageOrderDetailsVC, animated: true)
//                }else{
//                    let foodVoucherOrderDetailsVC = FoodVoucherOrderDetailsVC()
//                    self.navigationController?.pushViewController(foodVoucherOrderDetailsVC, animated: true)
//                }
            }else{
                
            }
        }
        return view
    }()
}
