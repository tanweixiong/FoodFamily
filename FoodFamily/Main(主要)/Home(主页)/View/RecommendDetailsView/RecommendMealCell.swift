//
//  RecommendMealCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/22.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RecommendMealCell: UITableViewCell {
    var mealDataModel : RecommendMealDataModel = RecommendMealDataModel()!{
        didSet{
            pricelabel.text = mealDataModel.marketPrice?.stringValue
            iconImageView.sd_setImage(with: NSURL(string: mealDataModel.mealImgDetail!)! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
        }
    }
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var storeMeallabel: UILabel!
    @IBOutlet weak var pricelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
