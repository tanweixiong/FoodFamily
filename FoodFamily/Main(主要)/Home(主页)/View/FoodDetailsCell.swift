//
//  FoodDetailsCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodDetailsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    struct FoodDetailsUX {
        static let titleHeight:CGFloat = 14
        static let backgroundHeight:CGFloat = 27
        static let space:CGFloat = 7
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(){
        self.contentView.addSubview(listView)
        listView.layer.addSublayer(layers)
    }
    
    lazy var listView: UIView = {
        let view = UIView()
        let data:NSArray = ["极致沙拉","极致机选泽物","极致汤品"]
        for item in 0...data.count - 1 {
            let backgroundVw = UIView()
            let backgroundHeight:CGFloat = FoodDetailsUX.backgroundHeight
            backgroundVw.frame = CGRect(x: 0 , y:CGFloat(Int(FoodDetailsUX.backgroundHeight) * item) , width: SCREEN_WIDTH , height: backgroundHeight)
            backgroundVw.tag = item + 1
            view.addSubview(backgroundVw)
            
            let titleLab = UILabel()
            titleLab.text = data[item] as? String
            titleLab.font = UIFont.systemFont(ofSize: 14)
            titleLab.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height:backgroundVw.frame.size.height)
            titleLab.textColor = UIColor.R_UIColorFromRGB(color: 0x434243)
            titleLab.textAlignment = .center
            backgroundVw.addSubview(titleLab)
        }
        let tagView = view.viewWithTag(data.count)!
        view.frame = CGRect(x: 0, y: self.titleLabel.frame.maxY, width: SCREEN_HEIGHT, height: tagView.frame.maxY + FoodDetailsUX.space)
        
        UserDefaults.standard.set(view.frame.maxY, forKey: "height")
        return view
    }()
    
    lazy var layers: CALayer = {
        let layers = CALayer()
        layers.frame = CGRect(x: 26, y: listView.frame.size.height - 0.5 ,width: SCREEN_WIDTH - 52  ,height:0.5)
        layers.backgroundColor  = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1).cgColor
//        layers.backgroundColor = UIColor.orange.cgColor
        return layers
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
