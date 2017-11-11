//
//  MineExpensesRecordCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineExpensesRecordCell: UITableViewCell {
    var sumPriceString:String = "10000"
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var sumLabel: UILabel!
    
    func setData(){
        //字体变色
        let text = "合计:" + "10000"
        let priceString = NSMutableAttributedString.init(string: text)
        priceString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.R_UIRGBColor(red: 255, green: 40, blue: 41, alpha: 1), range: NSMakeRange(3, sumPriceString.characters.count))
        sumLabel.attributedText = priceString
        
        commentButton.layer.borderColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1).cgColor
        commentButton.layer.borderWidth = 1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
