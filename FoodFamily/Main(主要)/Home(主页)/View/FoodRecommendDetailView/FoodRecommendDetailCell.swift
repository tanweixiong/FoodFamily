//
//  FoodRecommendDetailCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/8.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodRecommendDetailCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!{
        didSet{
            backgroundImageView.layer.cornerRadius = 5
            backgroundImageView.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(){
        let text = "秋天来临了天空像一块覆盖大地的蓝宝石。村外那个小池塘睁着碧澄澄的眼睛,凝望着这美好的天色。一对小白鹅侧着脑袋欣赏自己映在水里的影子。山谷里枫树..."
        titleLabel.text = text
        let size = titleLabel.getStringSize(text: text, size: CGSize(width:SCREEN_WIDTH - 30,height:CGFloat(MAXFLOAT)), font: 14)
        let sumHeight = backgroundImageView.frame.size.height + size.height + 15
        UserDefaults.standard.set(sumHeight , forKey: "height")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
