//
//  MineChefDetailsCell.swift
//  FoodFamily
//
//  Created by tam on 2017/12/5.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineChefDetailsCell: UITableViewCell {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var headingContentLabel: UILabel!
    @IBOutlet weak var moreImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //设置厨师的星级
    func setChefStarRating(){
        
    }
    
    //设置厨师的状态
    func setChefTradingStatus(){
        
    }
    
    //设置厨师的类型
    func setChefStatus(){
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
