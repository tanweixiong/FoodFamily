//
//  FoodPurchaseSuccessView.swift
//  FoodFamily
//
//  Created by tam on 2017/11/8.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

enum FoodPurchaseSuccessChooseType{
    case seeDetailsStatus
    case buyNowsStatus
}

class FoodPurchaseSuccessView: UIView {
   var foodPurchaseSuccessCallBack:((FoodPurchaseSuccessChooseType)->())?;
   var foodPurchaseSuccessChooseType = FoodPurchaseSuccessChooseType.seeDetailsStatus
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var buyNowButton: UIButton!
    @IBOutlet weak var seeDetailsButton: UIButton!{
        didSet{
            seeDetailsButton.layer.borderColor = UIColor.R_UIRGBColor(red: 155, green: 155, blue: 155, alpha: 1).cgColor
            seeDetailsButton.layer.borderWidth = 1
     }}
  
    
    @IBAction func onClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            foodPurchaseSuccessChooseType = .seeDetailsStatus
            break
        case 1:
            foodPurchaseSuccessChooseType = .buyNowsStatus
            break
        default: break
            
        }
        if foodPurchaseSuccessCallBack != nil{
            foodPurchaseSuccessCallBack!(foodPurchaseSuccessChooseType)
        }
    }
}
