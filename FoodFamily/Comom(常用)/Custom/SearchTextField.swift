//
//  SearchTextField.swift
//  AGTMall
//
//  Created by tam on 2017/10/20.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {


    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        
        let inset = CGRect(x: bounds.origin.x, y: bounds.origin.y + 2, width: bounds.size.width, height: bounds.size.height)
        
        return inset
    }
    
    func placeholderFont(_ font:UIFont){
        self.setValue(font, forKeyPath: "_placeholderLabel.font")
    }

}

