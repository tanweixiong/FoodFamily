//
//  AddBankCardFinishVC.swift
//  AGTMall
//
//  Created by tam on 2017/10/19.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MineAddBankCardFinishVC: MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "银行卡"
        self.addDefaultButtonImageLeft("")
        self.addDefaultButtonTextRight("关闭")
    }
    
    override func leftImageBtn(_ sender:UIBarButtonItem) {
        
    }
    
    override func rightTextBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
