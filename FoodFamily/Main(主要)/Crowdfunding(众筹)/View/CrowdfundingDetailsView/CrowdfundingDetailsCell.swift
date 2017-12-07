//
//  CrowdfundingDetailsCell.swift
//  FoodFamily
//
//  Created by tam on 2017/12/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class CrowdfundingDetailsCell: UITableViewCell {
    
    struct CrowdfundingDetailsUX {
        static let imageViewSize:CGSize = CGSize(width: SCREEN_WIDTH - 30, height: 200)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(){
        self.contentView.addSubview(pojectIntroductionLabel)
        self.contentView.addSubview(pojectIntroductionDataLabel)
        self.contentView.addSubview(pojectIntroductionImageView)
        
        pojectIntroductionImageView.sd_setImage(with: NSURL(string: "")! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
        
        
        pojectIntroductionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(15)
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.width.greaterThanOrEqualTo(58)
            make.height.greaterThanOrEqualTo(22)
        }
        
        let size = pojectIntroductionDataLabel.getStringSize(text: pojectIntroductionDataLabel.text!, size: CGSize(width:SCREEN_WIDTH,height:CGFloat(MAXFLOAT)), font: 14)
        pojectIntroductionDataLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pojectIntroductionLabel.snp.bottom).offset(15)
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.width.greaterThanOrEqualTo(size.width)
            make.height.greaterThanOrEqualTo(size.height)
        }
        
        pojectIntroductionImageView.snp.makeConstraints { (make) in
            make.top.equalTo(pojectIntroductionDataLabel.snp.bottom).offset(15)
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.width.greaterThanOrEqualTo(CrowdfundingDetailsUX.imageViewSize.width)
            make.height.greaterThanOrEqualTo(CrowdfundingDetailsUX.imageViewSize.height)
        }
        
        UserDefaults.standard.set(size.height + 15 , forKey: "height")
    }
    
    lazy var pojectIntroductionLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 25, green: 22, blue: 25, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "项目介绍"
        return label
    }()
    
    lazy var pojectIntroductionDataLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        label.text = "--"
        return label
    }()
    
    lazy var pojectIntroductionImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
