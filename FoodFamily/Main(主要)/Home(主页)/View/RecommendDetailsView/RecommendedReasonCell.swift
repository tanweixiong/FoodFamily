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
    
    struct RecommendedReasonUX {
        static let titleLabelHeight:CGFloat = 22
    }
    
    @IBOutlet weak var featuresView: UIView!
    @IBOutlet weak var recommendImageView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData() {
        contentView.addSubview(conventionThumbsUp)
        contentView.addSubview(conventionLabel)
        contentView.addSubview(conventionContentLabel)
        contentView.addSubview(seeConventionDetail)
        contentView.addSubview(featuresThumbsUp)
        contentView.layer.addSublayer(layers)
        contentView.addSubview(featuresLabel)
        contentView.addSubview(seefeaturesDetail)
        
        let text = "古朴的和风原木在奢华的商场里独树一帜雪花澳洲和牛牛小排有着摄人心魄的美妙餐厅里的每样摆件和器皿都是来源于日本华的商场里独树一帜雪古朴"
        conventionContentLabel.text = text
        
        //推荐菜
        let conventionSize:CGSize = conventionLabel.getStringSize(text: conventionLabel.text!, size: CGSize(width:SCREEN_WIDTH,height:RecommendedReasonUX.titleLabelHeight), font: 16)
        conventionLabel.frame = CGRect(x: SCREEN_WIDTH/2 - conventionSize.width/2, y: 18, width: conventionSize.width, height: RecommendedReasonUX.titleLabelHeight)
        
        //推荐点赞
        conventionThumbsUp.frame = CGRect(x: conventionLabel.frame.origin.x - conventionThumbsUp.frame.size.width - 5, y: conventionLabel.frame.origin.y + 4, width: conventionThumbsUp.frame.size.width, height: conventionThumbsUp.frame.size.height)
        
        //推荐详情
        let conventionContentSize:CGSize = conventionContentLabel.getStringSize(text: conventionContentLabel.text!, size: CGSize(width:SCREEN_WIDTH - 60,height:CGFloat(MAXFLOAT)), font: 14)
          conventionContentLabel.frame = CGRect(x: 30, y: conventionLabel.frame.maxY + 15, width: conventionContentSize.width, height: conventionContentSize.height)
        
        //查看更多
        seeConventionDetail.frame = CGRect(x: SCREEN_WIDTH/2 - seeConventionDetail.frame.size.width/2, y: conventionContentLabel.frame.maxY + 20, width: seeConventionDetail.frame.size.width, height: seeConventionDetail.frame.size.height)
        
        //灰色线条
         layers.frame = CGRect(x: 26, y: seeConventionDetail.frame.maxY + 20, width: SCREEN_WIDTH - 52, height: 0.5)
        
        //特色菜
        let featuresSize:CGSize = featuresLabel.getStringSize(text: featuresLabel.text!, size: CGSize(width:SCREEN_WIDTH,height:RecommendedReasonUX.titleLabelHeight), font: 16)
        featuresLabel.frame = CGRect(x: SCREEN_WIDTH/2 - featuresSize.width/2, y: layers.frame.maxY + 20, width: featuresSize.width, height: RecommendedReasonUX.titleLabelHeight)
        
        //推荐点赞
        featuresThumbsUp.frame = CGRect(x: featuresLabel.frame.origin.x - featuresThumbsUp.frame.size.width - 5 , y: featuresLabel.frame.origin.y + 5, width: featuresThumbsUp.frame.size.width, height: featuresThumbsUp.frame.size.height)
        
        
        //16 图片
        let space:CGFloat = 13.5
        let width = (SCREEN_WIDTH - space * 4)/3
        let maxY = featuresLabel.frame.maxY + 16
        for index in 0...2 {
            let x = space + CGFloat(index) * (width + space)
            let imageView = UIImageView()
            imageView.image = UIImage.init(named: "ic_home_food")
            imageView.frame = CGRect(x: x, y: maxY, width: width, height: width)
            contentView.addSubview(imageView)
            
            let label = UILabel()
            label.text = "特上小排"
            label.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14)
            contentView.addSubview(label)
            let size = label.getStringSize(text: label.text!, size: CGSize(width:SCREEN_WIDTH,height:20), font: 14)
            label.frame = CGRect(x: (imageView.frame.origin.x + width/2) - (size.width/2), y: imageView.frame.maxY + 16, width: size.width, height: 20)
        }
        
        let seeConventionMaxY = maxY + width + 16 + 20 + 20
       //查看更多
        seefeaturesDetail.frame = CGRect(x: SCREEN_WIDTH/2 - seefeaturesDetail.frame.size.width/2, y: seeConventionMaxY, width: seefeaturesDetail.frame.size.width, height: seefeaturesDetail.frame.size.height)
        
        let sum = seefeaturesDetail.frame.maxY + 23
        UserDefaults.standard.set(sum, forKey: "height")
    }
    
    lazy var conventionThumbsUp :UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        imageView.image = UIImage.init(named: "ic_home_tuijian")
        return imageView
    }()
    
    
    lazy var featuresThumbsUp :UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        imageView.image = UIImage.init(named: "ic_home_tuijian")
        return imageView
    }()
    
    lazy var conventionLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 25, green: 22, blue: 25, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "推荐理由"
        return label
    }()
    
    lazy var conventionContentLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        return label
    }()
    
    lazy var featuresLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 25, green: 22, blue: 25, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "特色菜"
        return label
    }()
    
    
    lazy var seeConventionDetail:UIButton = {
       let btn = UIButton()
        btn.setTitle("查看详情 >", for: .normal)
        btn.setTitleColor(UIColor.R_UIColorFromRGB(color: 0xD3B269), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.frame = CGRect(x: 0, y: 0, width: 90, height: 20)
        btn.addTarget(self, action: #selector(recommendOnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var seefeaturesDetail:UIButton = {
        let btn = UIButton()
        btn.setTitle("查看详情 >", for: .normal)
        btn.setTitleColor(UIColor.R_UIColorFromRGB(color: 0xD3B269), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.frame = CGRect(x: 0, y: 0, width: 90, height: 20)
        btn.addTarget(self, action: #selector(featuresOnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var layers: CALayer = {
        let layers = CALayer()
        layers.frame = CGRect(x: 0, y: 0 ,width: SCREEN_WIDTH - 52  ,height:0.5)
        layers.backgroundColor  = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1).cgColor
        //        layers.backgroundColor = UIColor.orange.cgColor
        return layers
    }()
    
    
   @objc func recommendOnClick(_ sender: UIButton) {
        if recommendedReasonCallBack != nil {
            recommendedType = .recommendStatus
            recommendedReasonCallBack!(recommendedType)
        }
    }

    @objc func featuresOnClick(_ sender: UIButton) {
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
