//
//  BoutiqueTableViewCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/4.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SDWebImage

class BoutiqueTableViewCell: UITableViewCell,UIScrollViewDelegate {

    @IBOutlet weak var advertisingVw: UIView!
    @IBOutlet weak var classificationScrollVw: UIScrollView!
    
    var categoryListModel : [CategoryListModel] = [CategoryListModel](){
        didSet{
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(_ model:[CategoryListModel]){
        self.categoryListModel = model
        //加载轮播图
        self.advertisingVw.addSubview(advertisingView)
        
        //加载分类图
        self.classificationScrollVw.addSubview(classification)
        self.classificationScrollVw.contentSize = CGSize(width: classification.frame.size.width, height: 60)
    }
    
    lazy var advertisingView: BoutiqueScrollView = {
        let view = BoutiqueScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.advertisingVw.frame.size.height))
        return view!
    }()
    
    lazy var classification: UIView = {
       let classificationVw = UIView()
        //第二个scrollView
        let classificationArray:NSArray = self.categoryListModel as NSArray
//        let classificationTiArray = ["附近","日料","西餐","自助"]
        let classfImgWidth:CGFloat = 28.80
        let classfImgHeight:CGFloat = 28
        for index in 0...self.categoryListModel.count - 1 {
            let model = classificationArray[index] as! CategoryListModel
            let x = 36 +   CGFloat(index) * (classfImgWidth + 65)
            let imageView = UIImageView(frame: CGRect(x: x, y: 13, width: classfImgWidth, height: classfImgHeight))
            //            imageView.sd_setImage(with: NSURL(string: classificationImgArray[index])! as URL, placeholderImage: UIImage.init(named: "morentouxiang"))
            imageView.image = UIImage.init(named: "")
            classificationVw.addSubview(imageView)
            
            let label = UILabel()
            label.text = model.categoryName
            label.textColor = UIColor.R_UIRGBColor(red: 25, green: 22, blue: 25, alpha: 1)
            label.font = UIFont.systemFont(ofSize: 14)
            classificationVw.addSubview(label)
            
            let labelSize:CGSize = label.getStringSize(text: label.text!, size: CGSize(width:SCREEN_WIDTH,height:14), font: 14)
            let labx = (imageView.frame.origin.x + CGFloat(imageView.frame.size.width/2)) - (labelSize.width/2)
            label.frame = CGRect(x: labx, y: imageView.frame.maxY + 5 , width: labelSize.width, height: labelSize.height)
            
            let btn = UIButton()
            btn.frame = CGRect(x: imageView.frame.origin.x, y: imageView.frame.origin.y, width: imageView.frame.size.width, height: label.frame.maxY - imageView.frame.origin.y)
            classificationVw.addSubview(label)
        }
        
        let classificationWidth = 36 +   CGFloat(classificationArray.count) * (classfImgWidth + 65)
        classificationVw.frame = CGRect(x: 0, y: 0, width: classificationWidth + classfImgWidth, height: classificationScrollVw.frame.size.height)
        return classificationVw
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
