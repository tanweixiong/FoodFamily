//
//  MineHeadView.swift
//  FoodFamily
//
//  Created by tam on 2017/11/10.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineHeadView: UIView {
   var mineHeadCallBack:(()->())?;
    @IBOutlet weak var backgroundVw: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var backgroundConstraintC: NSLayoutConstraint!
    @IBAction func onClick(_ sender: UIButton) {
        if mineHeadCallBack != nil {
            mineHeadCallBack!()
        }
    }
}
