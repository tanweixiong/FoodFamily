//
//  FoodSearchCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/29.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodSearchCell: UITableViewCell {
    var model : FoodSearchDataModel = FoodSearchDataModel()!{
        didSet{
           logoImageView.sd_setImage(with: NSURL(string: (model.logo)!)! as URL, placeholderImage: UIImage.init(named: "ic_all_smallImageDefault"))
           coverPicImageView.sd_setImage(with: NSURL(string: (model.coverPic)!)! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
            distanceLabel.text = ">" + (model.distance?.stringValue)! + "km"
            addressLabel.text = model.address
            storeNameLabel.text = model.storeName
            perPayLabel.text = "人均：" + (model.perPay?.stringValue)! + " 元"
        }
    }
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var coverPicImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var perPayLabel: UILabel!
    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
