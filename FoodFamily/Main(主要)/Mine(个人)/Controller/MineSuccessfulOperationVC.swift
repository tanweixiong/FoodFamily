//
//  MySuccessfulOperationVC.swift
//  AGTMall
//
//  Created by tam on 2017/10/20.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineSuccessfulOperationVC: MainViewController {
    @IBOutlet weak var pirceLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var seeDetailsButton: UIButton!
    var operationType = MineAmountOperationType.cashOperationStatus
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "充值"
        self.createUI()
        self.addDefaultButtonTextRight("")
        self.addDefaultButtonImageLeft("")
    }
    
    func createUI(){
        self.closeButton.layer.borderColor = UIColor.R_UIRGBColor(red: 155, green: 155, blue: 155, alpha: 1).cgColor
        self.closeButton.layer.borderWidth = 1
    }
    
    @IBAction func closeOnClkick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func seeDetailsOnClick(_ sender: UIButton) {
        let mineSuccessfulOperationVC = MineAmountOperationVC()
        mineSuccessfulOperationVC.operationType = operationType
        self.navigationController?.pushViewController(mineSuccessfulOperationVC, animated: true)
    }
    
    override func rightTextBtn(_ sender: UIBarButtonItem) {

    }
    
    override func leftImageBtn(_ sender:UIBarButtonItem) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
