//
//  FoodMerchantsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/9.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodMerchantsVC: UIViewController {

    struct FoodMerchantsUX {
        static let headHeight:CGFloat = 44
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(foodMerchantsHeadView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var foodMerchantsHeadView: FoodMerchantsHeadView = {
        let view = Bundle.main.loadNibNamed("FoodMerchantsHeadView", owner: nil, options: nil)?.last as! FoodMerchantsHeadView
        view.frame = CGRect(x: 0, y:0, width: SCREEN_WIDTH, height: FoodMerchantsUX.headHeight)
        return view
    }()
}
