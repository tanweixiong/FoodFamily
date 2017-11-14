//
//  FoodEvaluationHeadCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/14.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodEvaluationHeadCell: UITableViewCell {
    @IBOutlet weak var evaluationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(){
        let view = HJRatingView.init(itemWidth: 20, margin: 10)
        view?.setBgImageName("rating_gray", andTopImageName: "rating_yellow")
        view?.backgroundColor = UIColor.clear
        view?.frame.origin.x =  evaluationLabel.frame.maxX + 15
        view?.center.y =  evaluationLabel.center.y + 1
        view?.itemBGColor = UIColor.clear
        view?.maxScore = 10
        view?.operationTypes = HJRatingViewOperationType.click
        view?.scoreChangedBlock = { (score) in
            
        }
        self.contentView.addSubview(view!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
