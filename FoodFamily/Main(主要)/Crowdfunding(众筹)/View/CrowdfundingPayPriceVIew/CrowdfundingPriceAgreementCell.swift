//
//  CrowdfundingPriceAgreementCell.swift
//  FoodFamily
//
//  Created by tam on 2017/12/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class CrowdfundingPriceAgreementCell: UITableViewCell {

    @IBOutlet weak var agreementChooseBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onClick(_ sender: UIButton) {
       self.agreementChooseBtn.isSelected = !self.agreementChooseBtn.isSelected
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
