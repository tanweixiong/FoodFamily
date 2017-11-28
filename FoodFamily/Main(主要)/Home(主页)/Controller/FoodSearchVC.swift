//
//  FoodSearchVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/28.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodSearchVC: UIViewController {
   fileprivate lazy var viewModel : FoodSearchVM = FoodSearchVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
    }
    
    func getData(){
        let parameters = ["storeName":"","longitude":"","latitude":"","pageSize":""]
        viewModel.loadSuccessfullyReturnedData(requestType: .post, URLString: ConstAPI.kAPIStoreSelectStoreByStoreName, parameters: parameters, showIndicator: false) {
            
        }
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
