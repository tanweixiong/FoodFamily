//
//  InputView.swift
//  AGTMall
//
//  Created by tam on 2017/10/17.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class InputView: UIView {
    
    struct InputViewUX {
        static let iconImageSize:Float = 30
        static let inputTFHeight:Float = 120
        static let placeholderFont:Float = 14
    }

    // MARK: - OverrideMethod
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
    }
    
    func createUI(){
        let layers = CALayer()
        layers.frame = CGRect(x: 0 , y: self.frame.size.height, width: SCREEN_WIDTH  ,height:0.5)
        layers.backgroundColor  = UIColor.R_UIColorFromRGB(color: 0xdddddd).cgColor
        self.layer.addSublayer(layers)
        
        self.addSubview(iconImageView)
        self.addSubview(AGTextField)
        
        iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(20)
            make.size.width.equalTo(InputViewUX.iconImageSize)
            make.size.height.equalTo(InputViewUX.iconImageSize)
        }
        
        AGTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalTo(self.snp.right).offset(-20)
            make.height.equalTo(self.frame.size.height)
        }

    }
    
    lazy var iconImageView :UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var AGTextField :UITextField = {
        let textField  = UITextField()
        textField.setValue(UIColor.R_UIRGBColor(red: 207, green: 207, blue: 207, alpha: 1), forKeyPath: "_placeholderLabel.textColor")
        textField.font = UIFont.systemFont(ofSize: CGFloat(InputViewUX.placeholderFont))
        textField.textColor = UIColor.R_UIColorFromRGB(color: 0x333333)
        return textField
    }()

}
