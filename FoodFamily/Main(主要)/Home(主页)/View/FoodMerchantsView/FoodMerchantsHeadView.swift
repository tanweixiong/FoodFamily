//
//  FoodMerchantsHeadView.swift
//  FoodFamily
//
//  Created by tam on 2017/11/9.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodMerchantsHeadView: UIView {
    var foodMerchantsHeadCallBack:((UIButton)->())?;
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var recentButton: UIButton!
    @IBOutlet weak var allArrowButton: UIButton!
    @IBOutlet weak var recentArrowButton: UIButton!
    @IBAction func onClick(_ sender: UIButton) {
        if foodMerchantsHeadCallBack != nil {
            foodMerchantsHeadCallBack!(sender)
        }
    }
}
