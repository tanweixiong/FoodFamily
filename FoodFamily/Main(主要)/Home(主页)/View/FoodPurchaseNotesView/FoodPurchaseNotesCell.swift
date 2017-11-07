//
//  FoodPurchaseNotesCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodPurchaseNotesCell: UITableViewCell {
    @IBOutlet weak var headingLabel: UILabel!
    //有效期
    var validityStr = String() {
        didSet {
            validityStr = "有效期：2017.09.22-2017.12.21"
        }
    }
    //使用时间
    var usageTimeStr = String() {
        didSet {
            usageTimeStr = "使用时间：8:00～22:00"
        }
    }
    //使用规则
    var useRulesStr = String() {
        didSet {
            useRulesStr = "使用规则：无需预约，消费高峰期时可能需要等位不兑现、不找零、不可使用包间每人限制一张、提供swifi"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(){
        
    }
    
    lazy var listView: UIView = {
        let view = UIView()
        let data:NSArray = [self.validityStr,self.usageTimeStr,self.useRulesStr]
        let origin_y = headingLabel.frame.maxY + 10
        for item in 0...data.count - 1 {
            
            let titleLab = UILabel()
            titleLab.text = data[item] as? String
            titleLab.font = UIFont.systemFont(ofSize: 14)
            titleLab.textColor = UIColor.R_UIColorFromRGB(color: 0x434243)
            titleLab.textAlignment = .center
            view.addSubview(titleLab)
            let size = titleLab.getStringSize(text:titleLab.text!, size: CGSize(width:SCREEN_WIDTH - 60 ,height:CGFloat(MAXFLOAT)), font: 14)
//            titleLab.frame = CGRect(x: 30, y: self.frame.origin, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
            
            
            
            
//            let backgroundVw = UIView()
//            let backgroundHeight:CGFloat = FoodDetailsUX.backgroundHeight
//            backgroundVw.frame = CGRect(x: 0 , y:CGFloat(Int(FoodDetailsUX.backgroundHeight) * item) , width: SCREEN_WIDTH , height: backgroundHeight)
//            backgroundVw.tag = item + 1
//            view.addSubview(backgroundVw)
//
//            let titleLab = UILabel()
//            titleLab.text = data[item] as? String
//            titleLab.font = UIFont.systemFont(ofSize: 14)
//            titleLab.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height:backgroundVw.frame.size.height)
//            titleLab.textColor = UIColor.R_UIColorFromRGB(color: 0x434243)
//            titleLab.textAlignment = .center
//            backgroundVw.addSubview(titleLab)
        }
        let tagView = view.viewWithTag(data.count)!
//        view.frame = CGRect(x: 0, y: self.titleLabel.frame.maxY, width: SCREEN_HEIGHT, height: tagView.frame.maxY + FoodDetailsUX.space)
        
        UserDefaults.standard.set(view.frame.maxY, forKey: "height")
        return view
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
