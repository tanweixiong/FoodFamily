//
//  MyBalanceListView.swift
//  AGTMall
//
//  Created by tam on 2017/10/18.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MyBalanceListView: UIView {

   var myBalanceCallBack:((UIButton)->())?;
    
    @IBAction func handleClick(_ sender: UIButton) {
        if myBalanceCallBack != nil {
            myBalanceCallBack!(sender)
        }
    }

}
