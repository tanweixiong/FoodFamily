//
//  MineExpensesRecordCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineExpensesRecordCell: UITableViewCell {
    var orderModel : MineOrderDataModel = MineOrderDataModel()!{
        didSet{
            self.mealNameLabel.text = self.orderModel.storeName
            self.orderTimeLabel.text = self.orderModel.orderTime
            self.logoImageView.sd_setImage(with: NSURL(string: self.orderModel.logo!)! as URL, placeholderImage: UIImage.init(named: "ic_all_smallImageDefault"))
            self.logoImageView.contentMode = .scaleAspectFit
            
            let text = "合计:" + (self.orderModel.totalPrice?.stringValue)!
            let priceString = NSMutableAttributedString.init(string: text)
            priceString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.R_UIRGBColor(red: 255, green: 40, blue: 41, alpha: 1), range: NSMakeRange(3, (self.orderModel.totalPrice?.stringValue)!.characters.count))
            sumLabel.attributedText = priceString
        }
    }

    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var orderTimeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    func setData(){
        //字体变色
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
