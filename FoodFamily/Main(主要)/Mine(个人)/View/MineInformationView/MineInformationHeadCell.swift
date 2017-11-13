//
//  MineInformationHeadCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineInformationHeadCell: UITableViewCell {
   var mineInformationHeadCallBack:(()->())?;
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onClick(_ sender: UIButton) {
        if mineInformationHeadCallBack != nil {
            mineInformationHeadCallBack!()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
