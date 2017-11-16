//
//  MyRechargeListCell.swift
//  AGTMall
//
//  Created by tam on 2017/10/19.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MyRechargeListCell: UITableViewCell {
    
   var myRechargeListCallBack:((UIButton)->())?;
    
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chooseBtn: UIButton!

    @IBAction func myChooseClick(_ sender: UIButton) {
        if myRechargeListCallBack != nil {
           myRechargeListCallBack!(self.chooseBtn)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
