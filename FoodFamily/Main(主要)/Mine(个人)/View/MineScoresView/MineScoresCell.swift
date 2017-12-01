//
//  MineScoresCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/30.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineScoresCell: UITableViewCell {

    var model : MineScoresDataModel = MineScoresDataModel()!{
        didSet{
           self.nameLabel.text = model.storeName
           self.logoImageView.sd_setImage(with: NSURL(string: (model.logo!))! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
           self.priceLabel.text = model.price
           self.remarkLabel.text = model.createTime
        }
    }
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
