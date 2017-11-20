//
//  RecommendTableViewCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/4.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RecommendTableViewCell: UITableViewCell {
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var perPayLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(_ model:StoreListModel){
        self.storeNameLabel.text = model.storeName
        self.perPayLabel.text = model.perPay?.stringValue
        self.streetLabel.text = model.street
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
