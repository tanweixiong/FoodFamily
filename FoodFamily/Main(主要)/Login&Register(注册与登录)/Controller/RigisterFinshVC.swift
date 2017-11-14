//
//  RigisterFinshVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/14.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RigisterFinshVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册成功"
        view.addSubview(registerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var registerView: RigisterFinshView = {
        let view = Bundle.main.loadNibNamed("RigisterFinshView", owner: nil, options: nil)?.last as! RigisterFinshView
        view.frame = CGRect(x: 0, y:0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        return view
    }()

}
