//
//  CrowdfundingDetailsFoodVw.swift
//  FoodFamily
//
//  Created by tam on 2017/12/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class CrowdfundingDetailsFoodVw: UIView {
   var crowdfundingDetailsCallBack:((UIButton)->())?;
    @IBAction func onClick(_ sender: UIButton) {
        if crowdfundingDetailsCallBack != nil {
            crowdfundingDetailsCallBack!(sender)
        }
    }
    
}
