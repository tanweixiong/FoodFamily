//
//  MainTabBarController.swift
//  DouYuTVMutate
//
//  Created by ZeroJ on 16/7/13.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /// 设置子控制器
        setupChildVcs()
        /// 设置item的字体颜色
        setTabBarItemColor()
    }
    
    func setTabBarItemColor() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.orange], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray], for: UIControlState())
    }
    
    func setupChildVcs() {
        let homeVc = addChildVc(HomeController(), title: "美食", imageName: "ic_tab_food", selectedImageName: "btn_home_selected_24x24_")
        let crowdfundingVc = addChildVc(CrowdfundingController(), title: "众筹", imageName: "ic_tab_crowdfunding", selectedImageName: "btn_column_selected_24x24_")
        let collegeVc = addChildVc(CollegeController(), title: "学院", imageName: "ic_tab_college", selectedImageName: "btn_live_selected_30x24_")
        let chefVc = addChildVc(ChefController(), title: "厨师", imageName: "ic_tab_chef", selectedImageName: "btn_user_selected_24x24_")
        let mineVc = addChildVc(MineController(), title: "个人", imageName: "ic_tab_mine", selectedImageName: "btn_user_selected_24x24_")
        viewControllers = [homeVc, crowdfundingVc, collegeVc, chefVc,mineVc]

    }
    
    func addChildVc(_ childVc: UIViewController, title: String, imageName: String, selectedImageName: String) -> UINavigationController {
        let navi = FMNavigationController(rootViewController: childVc)

        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        let selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)

        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        navi.tabBarItem = tabBarItem
        
        return navi
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

