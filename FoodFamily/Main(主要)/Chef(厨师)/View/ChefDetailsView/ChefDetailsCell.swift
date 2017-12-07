//
//  ChefDetailsCell.swift
//  FoodFamily
//
//  Created by tam on 2017/12/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class ChefDetailsCell: UITableViewCell {

    struct ChefDetailsCellUX {
        static let labelHeight:CGFloat = 22
        static let labelFont:CGFloat = 16
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(){
         self.contentView.addSubview(mineIntroductionImage)
         self.contentView.addSubview(mineIntroductionLabel)
         self.contentView.addSubview(mineIntroductionDetailsLabel)
         self.contentView.addSubview(line)
         self.contentView.addSubview(foodIntroductionImage)
         self.contentView.addSubview(foodIntroductionLabel)
         self.contentView.addSubview(seeMoreButton)
        
        let mineIntroductionSize:CGSize = mineIntroductionLabel.getStringSize(text: mineIntroductionLabel.text!, size: CGSize(width:SCREEN_WIDTH,height:ChefDetailsCellUX.labelHeight), font: ChefDetailsCellUX.labelFont)
        
        let mineIntroductionDetailsSize:CGSize = mineIntroductionDetailsLabel.getStringSize(text: mineIntroductionDetailsLabel.text!, size: CGSize(width:SCREEN_WIDTH - 60,height:ChefDetailsCellUX.labelHeight), font: 14)
        
        mineIntroductionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(18)
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.width.greaterThanOrEqualTo(mineIntroductionSize.width)
            make.height.greaterThanOrEqualTo(mineIntroductionSize.height)
        }
        
        mineIntroductionImage.snp.makeConstraints { (make) in
            make.right.equalTo(mineIntroductionLabel.snp.left).offset(-5)
            make.centerY.equalTo(mineIntroductionLabel.snp.centerY)
            make.width.greaterThanOrEqualTo(mineIntroductionImage.frame.width)
            make.height.greaterThanOrEqualTo(mineIntroductionImage.frame.height)
        }
        
        mineIntroductionDetailsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(mineIntroductionLabel.snp.bottom).offset(15)
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.width.greaterThanOrEqualTo(mineIntroductionDetailsSize.width)
            make.height.greaterThanOrEqualTo(mineIntroductionDetailsSize.height)
        }
        
        line.snp.makeConstraints { (make) in
            make.top.equalTo(mineIntroductionDetailsLabel.snp.bottom).offset(15)
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.width.greaterThanOrEqualTo(line.frame.width)
            make.height.greaterThanOrEqualTo(line.frame.height)
        }
        
        foodIntroductionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp.bottom).offset(15)
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.width.greaterThanOrEqualTo(mineIntroductionSize.width)
            make.height.greaterThanOrEqualTo(mineIntroductionSize.height)
        }
        
        foodIntroductionImage.snp.makeConstraints { (make) in
            make.right.equalTo(foodIntroductionLabel.snp.left).offset(-5)
            make.centerY.equalTo(foodIntroductionLabel.snp.centerY)
            make.width.greaterThanOrEqualTo(foodIntroductionImage.frame.width)
            make.height.greaterThanOrEqualTo(foodIntroductionImage.frame.height)
        }
        
        let space:CGFloat = 13.5
        let width = (SCREEN_WIDTH - space * 4)/3
        let maxY = 18 + 16 + mineIntroductionDetailsSize.height + mineIntroductionSize.height*2 + 15*3
        let seeMoreHeight = maxY + width + 15 + 16 + 20
        
        seeMoreButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(seeMoreHeight)
            make.centerX.equalTo(foodIntroductionLabel.snp.centerX)
            make.width.greaterThanOrEqualTo(seeMoreButton.frame.width)
            make.height.greaterThanOrEqualTo(seeMoreButton.frame.height)
        }
        
        for index in 0...3 {
            let x = space + CGFloat(index) * (width + space)
            let imageView = UIImageView()
            imageView.sd_setImage(with: NSURL(string: "")! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
            imageView.frame = CGRect(x: x, y: maxY, width: width, height: width)
            contentView.addSubview(imageView)
            
            let label = UILabel()
            label.text = "西餐"
            label.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14)
            contentView.addSubview(label)
            let size = label.getStringSize(text: label.text!, size: CGSize(width:SCREEN_WIDTH,height:20), font: 14)
            label.frame = CGRect(x: (imageView.frame.origin.x + width/2) - (size.width/2), y: imageView.frame.maxY + 16, width: size.width, height: 20)
        }
        
        UserDefaults.standard.set(seeMoreHeight + seeMoreButton.frame.height + 20, forKey: "height")
    }
    
    @objc func seeMoreOnClick(_ sender:UIButton){
        
    }
    
    lazy var mineIntroductionImage :UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        imageView.image = UIImage.init(named: "ic_home_tuijian")
        return imageView
    }()
    
    lazy var mineIntroductionLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 25, green: 22, blue: 25, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: ChefDetailsCellUX.labelFont)
        label.text = "自我介绍"
        return label
    }()
    
    lazy var mineIntroductionDetailsLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        label.text = "--"
        return label
    }()
    
    lazy var foodIntroductionImage :UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        imageView.image = UIImage.init(named: "ic_home_tuijian")
        return imageView
    }()

    lazy var foodIntroductionLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 25, green: 22, blue: 25, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: ChefDetailsCellUX.labelFont)
        label.text = "菜系介绍"
        return label
    }()
    
    lazy var line: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0 ,width: SCREEN_WIDTH - 52  ,height:0.5)
        view.backgroundColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        return view
    }()
    
    lazy var seeMoreButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("查看更多 >", for: .normal)
        btn.setTitleColor(UIColor.R_UIColorFromRGB(color: 0xD3B269), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.frame = CGRect(x: 0, y: 0, width: 90, height: 20)
        btn.addTarget(self, action: #selector(seeMoreOnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
}
