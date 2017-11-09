//
//  RecommendedReasonCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RecommendedReasonCell: UITableViewCell {
    var recommendedReasonCallBack:((RecommendedType)->())?;
    var recommendedReasonRefreshTheData:(()->())?;
    var isRefreshTheData:Bool = true
    @IBOutlet weak var featuresView: UIView!
    @IBOutlet weak var recommendImageView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData() {
        let text = "古朴的和风原木在奢华的商场里独树一帜雪花澳洲和牛牛小排有着摄人心魄的美妙餐厅里的每样摆件和器皿都是来源于日本华的商场里独树一帜雪古朴"
        headingLabel.text = text
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let sumHeight = headingLabel.frame.size.height + recommendImageView.frame.height + 268
        UserDefaults.standard.set(sumHeight , forKey: "height")
        if isRefreshTheData {
            isRefreshTheData = false
            if  self.recommendedReasonRefreshTheData != nil{
                self.recommendedReasonRefreshTheData!()
            }
        }
    }
    
    @IBAction func recommendOnClick(_ sender: UIButton) {
        if recommendedReasonCallBack != nil {
            recommendedType = .recommendStatus
            recommendedReasonCallBack!(recommendedType)
        }
    }

    @IBAction func FeaturesOnClick(_ sender: UIButton) {
        if recommendedReasonCallBack != nil {
            recommendedType = .featuresStatus
            recommendedReasonCallBack!(recommendedType)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
