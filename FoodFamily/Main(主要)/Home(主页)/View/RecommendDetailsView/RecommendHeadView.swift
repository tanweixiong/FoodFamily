//
//  RecommendHeadView.swift
//  FoodFamily
//
//  Created by tam on 2017/11/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RecommendHeadView: UIView {
    var recommendDataModel : RecommendDataModel = RecommendDataModel()!{
        didSet{
            self.storeTypeLabel.text = recommendDataModel.storeType
           self.storeNameLabel.text = recommendDataModel.storeName
           self.perPayLabel.text = recommendDataModel.perPay?.stringValue
           self.addresslabel.text = recommendDataModel.address
        }
    }
    
    @IBOutlet weak var storeTypeLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var perPayLabel: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
