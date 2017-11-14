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
    var tggStarEvaluationView = TggStarEvaluationView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(){
         tggStarEvaluationView = TggStarEvaluationView.init { (int) in
            
        }
        tggStarEvaluationView.frame = CGRect(x: evaluationLabel.frame.maxX + 1.8, y: 0, width: 23 * 5, height: 45)
        tggStarEvaluationView.center.y = evaluationLabel.center.y
        tggStarEvaluationView.starCount = 4
        tggStarEvaluationView.spacing = 0.2
        self.contentView.addSubview(tggStarEvaluationView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
