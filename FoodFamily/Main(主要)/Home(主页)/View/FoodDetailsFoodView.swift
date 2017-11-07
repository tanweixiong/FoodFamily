//
//  FoodDetailsFoodView.swift
//  FoodFamily
//
//  Created by tam on 2017/11/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodDetailsFoodView: UIView {
    @IBOutlet weak var discountLabel: UILabel!
    var buyNowCallBack:((UIButton)->())?;
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func buyNowClick(_ sender: UIButton) {
        if self.buyNowCallBack != nil {
            self.buyNowClick(sender)
        }
    }
    
}
