//
//  MyScoresHeadViwe.swift
//  AGTMall
//
//  Created by tam on 2017/10/18.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MyScoresHeadView: UIView {
    
   var myScoresHeadViewCallBack:((UIButton)->())?;
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var mySubView: UIView!
    
    @IBOutlet weak var chooseBtn: UIButton!
    @IBAction func optionClick(_ sender: UIButton) {
        if myScoresHeadViewCallBack != nil {
            myScoresHeadViewCallBack!(sender)
        }
    }
    

}
