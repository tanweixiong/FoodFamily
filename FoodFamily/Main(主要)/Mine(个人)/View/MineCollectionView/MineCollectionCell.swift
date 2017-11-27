//
//  MineCollectionCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineCollectionCell: UITableViewCell {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var collectLabel: UILabel!
    @IBOutlet weak var collectButton: UIButton!
    var  mineCollectionBlock:((_ sender:UIButton)->())?;
    var collectionListModel : MineCollectionDataModel = MineCollectionDataModel()!{
        didSet{
            logoImageView.sd_setImage(with: NSURL(string: (collectionListModel.logo)!)! as URL, placeholderImage: UIImage.init(named: "ic_all_smallImageDefault"))
            storeNameLabel.text = collectionListModel.storeName
        }
    }
    
    @IBAction func collecttionClick(_ sender: UIButton) {
        if mineCollectionBlock != nil {
            mineCollectionBlock!(self.collectButton)
        }
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
