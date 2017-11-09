//
//  FoodOrderPackageCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/9.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodOrderPackageCell: UITableViewCell {

    struct FoodOrderPackageUX {
        static let backgroundHeight:CGFloat = 38.5
        static let space:CGFloat = 0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(){
        self.contentView.addSubview(listView)
    }
    
    lazy var listView: UIView = {
        let view = UIView()
        let headingContentArray:NSArray = ["套餐内容","代金券（1张）","使用范围：除酒水、全场通用"]
        for item in 0...headingContentArray.count - 1 {
            let backgroundVw = UIView()
            let backgroundHeight:CGFloat = FoodOrderPackageUX.backgroundHeight
            backgroundVw.frame = CGRect(x: 0 , y:CGFloat(Int(FoodOrderPackageUX.backgroundHeight) * item) , width: SCREEN_WIDTH , height: backgroundHeight)
            backgroundVw.tag = item + 1
            view.addSubview(backgroundVw)
            
            let heading = headingContentArray[item] as? String
            let headingLab = UILabel()
            headingLab.text = heading
            headingLab.font = UIFont.systemFont(ofSize: 14)
            headingLab.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
            headingLab.textAlignment = .left
            backgroundVw.addSubview(headingLab)
            let size:CGSize = headingLab.getStringSize(text: heading!, size: CGSize(width:SCREEN_WIDTH - 30,height:backgroundVw.frame.size.height), font: 14)
            headingLab.frame = CGRect(x: 15, y: 0, width: size.width, height: backgroundVw.frame.size.height)
        
            if item == 1 {
                //字体变色
                let priceString = NSMutableAttributedString.init(string: heading!)
                priceString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.R_UIRGBColor(red: 155, green: 155, blue: 155, alpha: 1),range: NSMakeRange(3, 4))
                headingLab.attributedText = priceString
                
                //内容
                let contentLab = UILabel()
                contentLab.text = "¥1000000000000000000000"
                contentLab.font = UIFont.systemFont(ofSize: 16)
                let x =  headingLab.frame.maxX + 5
                contentLab.frame = CGRect(x: x, y: 0, width:SCREEN_WIDTH - x - 15, height:backgroundVw.frame.size.height)
                contentLab.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
                contentLab.textAlignment = .right
                backgroundVw.addSubview(contentLab)
            }
        }
        let tagView = view.viewWithTag(headingContentArray.count)!
        view.frame = CGRect(x: 0, y:0, width: SCREEN_HEIGHT, height: tagView.frame.maxY + FoodOrderPackageUX.space)
        UserDefaults.standard.set(view.frame.maxY, forKey: "height")
        return view
    }()
    
}
