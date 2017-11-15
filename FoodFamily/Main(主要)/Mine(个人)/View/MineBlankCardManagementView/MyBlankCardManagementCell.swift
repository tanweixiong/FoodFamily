//
//  MyBlankCardManagementCell.swift
//  AGTMall
//
//  Created by tam on 2017/10/19.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MyBlankCardManagementCell: UITableViewCell {

    @IBOutlet weak var backgroundVw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundVw.backgroundColor = R_UIThemeBackgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
