//
//  MineOptionView.swift
//  FoodFamily
//
//  Created by tam on 2017/11/10.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineOptionView: UIView {
    fileprivate let headingArray:NSArray = ["我的收藏","消费记录","优惠卡券","购买卡券","我的预约","银行卡"]
    fileprivate let iconImageArray:NSArray = ["ic_mine_collection","ic_mine_expensesrecord","ic_mine_discount coupons","ic_mine_buyCoupons","ic_mine_bankCard","ic_mine_wallet"]
    override init(frame: CGRect) {
       super.init(frame: frame)
        
        let width = SCREEN_WIDTH/4
        let height = width
        for index in 0...headingArray.count {
            
        }
        
        
    }
    
     required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

}
