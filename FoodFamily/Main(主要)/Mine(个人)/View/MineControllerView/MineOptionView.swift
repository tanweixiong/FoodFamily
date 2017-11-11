//
//  MineOptionView.swift
//  FoodFamily
//
//  Created by tam on 2017/11/10.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineOptionView: UIView {
    var mineOptionViewCallBack:((Int)->())?;
    @IBOutlet weak var backgroundVw: UIView!
    @IBAction func onClick(_ sender: UIButton) {
        if mineOptionViewCallBack != nil {
            mineOptionViewCallBack!(sender.tag)
        }
    }
    
}
