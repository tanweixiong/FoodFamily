//
//  RecommendMealCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/22.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RecommendMealCell: UITableViewCell {
    var recommendMealCallBack:((_ model:RecommendMealDataModel)->())?;
    var mealModel : RecommendMealDataModel = RecommendMealDataModel()!{
        didSet{
            pricelabel.text = "¥" + (mealModel.mealPrice?.stringValue)!
            iconImageView.sd_setImage(with: NSURL(string: mealModel.mealImgDetail!)! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
            self.storeMeallabel.text = mealModel.remark
            let priceString = NSMutableAttributedString.init(string: "¥" + (mealModel.mealMarketPrice?.stringValue)!)
            priceString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSNumber.init(value: 1), range: NSRange(location: 0, length: priceString.length))
            self.discountLabel.attributedText = priceString
        }
    }
    
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var storeMeallabel: UILabel!
    @IBOutlet weak var pricelabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buyButton.layer.borderColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1).cgColor
        buyButton.layer.borderWidth = 1
    }

    @IBAction func buyOnClick(_ sender: UIButton) {
        if recommendMealCallBack != nil {
           recommendMealCallBack!(self.mealModel)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
