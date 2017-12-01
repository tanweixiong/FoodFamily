//
//  FoodOrderDetailsHeadCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/8.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodOrderDetailsHeadCell: UITableViewCell {
    //堂吃 预约
    var canteenModel : FoodOrderCanteenListModel = FoodOrderCanteenListModel()!{
        didSet{
           self.nameLabel.text = canteenModel.name
           self.storeLogoImageView.sd_setImage(with: NSURL(string: (canteenModel.storeLogo)!)! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
        }
    }
    //代金券
    var voucherModel : FoodOrderVoucherListModel = FoodOrderVoucherListModel()!{
        didSet{
            self.nameLabel.text = voucherModel.name
            self.totalPriceLabel.text = voucherModel.totalPrice?.stringValue
            self.contentLabel.text = voucherModel.remark
            self.storeLogoImageView.sd_setImage(with: NSURL(string: (voucherModel.storeLogo)!)! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
        }
    }
    //套餐
    var packageModel : FoodOrderPackageListModel = FoodOrderPackageListModel()!{
        didSet{
            self.nameLabel.text = packageModel.name
            self.totalPriceLabel.text = packageModel.totalPrice?.stringValue
            self.contentLabel.text = packageModel.remark
            self.storeLogoImageView.sd_setImage(with: NSURL(string: (packageModel.storeLogo)!)! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
        }
    }

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var storeLogoImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
