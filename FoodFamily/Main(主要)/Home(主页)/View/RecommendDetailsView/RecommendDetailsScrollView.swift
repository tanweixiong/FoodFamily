//
//  HomeHeadScrollView.swift
//  FoodFamily
//
//  Created by tam on 2017/11/21.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RecommendDetailsScrollView: UIView {
    var recommendDataModel : RecommendDataModel = RecommendDataModel()!{
        didSet{
            self.setData(self.recommendDataModel.coverPic!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(scrollView)
    }
    
    func setData(_ data:NSArray){
        for index in 0...data.count - 1 {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(index) * SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: self.frame.size.height))
            imageView.sd_setImage(with: NSURL(string: data[index] as! String)! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH * CGFloat(data.count), height: self.frame.size.height)
    }
    
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.frame.size.height)
        scrollView.isPagingEnabled = true;
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.clipsToBounds = false;
        scrollView.bounces = false;
        return scrollView
    }()
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}
