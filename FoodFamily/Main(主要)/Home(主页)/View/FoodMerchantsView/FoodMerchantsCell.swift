//
//  FoodMerchantsCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/9.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodMerchantsCell: UITableViewCell {
    var merchantsModel : FoodMerchantsDataModel = FoodMerchantsDataModel()!{
        didSet{
            iconImageView.sd_setImage(with: NSURL(string: (merchantsModel.logo)!)! as URL, placeholderImage: UIImage.init(named: "ic_all_smallImageDefault"))
            iconImageView.contentMode = .scaleAspectFit
            
            headingLabel.text = merchantsModel.storeName
            perCapitaLabel.text = "人均：" + (merchantsModel.perPay?.stringValue)!
            addressLabel.text = (merchantsModel.province)! + (merchantsModel.city)! + " | " + "<" +  (merchantsModel.distance?.stringValue)! + "km"
        }
    }
    
    var classificationModel : FoodSearchDataModel = FoodSearchDataModel()!{
        didSet{
          iconImageView.sd_setImage(with: NSURL(string: (classificationModel.logo)!)! as URL, placeholderImage: UIImage.init(named: "ic_all_smallImageDefault"))
          iconImageView.contentMode = .scaleAspectFit
        
          headingLabel.text = classificationModel.storeName
          perCapitaLabel.text = "人均：" + (classificationModel.perPay?.stringValue)!
          addressLabel.text = classificationModel.address!
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
//    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var perCapitaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
