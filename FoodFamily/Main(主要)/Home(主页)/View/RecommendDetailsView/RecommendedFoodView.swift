//
//  RecommendedFoodView.swift
//  FoodFamily
//
//  Created by tam on 2017/11/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

enum RecommendedType {
    case collectionStatus
    case reservationStatus
    case payStatus
    case recommendStatus
    case featuresStatus
    case vouchersDetailStatus
    case defaultDetailStatus
}
var recommendedType = RecommendedType.collectionStatus
class RecommendedFoodView: UIView {
   var recommendedFoodCallBack:((RecommendedType)->())?;
    @IBAction func OnClick(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            recommendedType = .collectionStatus
        case 2:
            recommendedType = .reservationStatus
        case 3:
            recommendedType = .payStatus
        default:
            break
        }
        if recommendedFoodCallBack != nil {
            recommendedFoodCallBack!(recommendedType)
        }
    }
}
