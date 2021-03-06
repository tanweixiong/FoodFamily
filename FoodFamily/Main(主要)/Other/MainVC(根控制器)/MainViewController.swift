//
//  TPMainViewController.swift
//  TradingPlatform
//
//  Created by tam on 2017/8/10.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    //返回按钮点击响应
    @objc func backToPrevious() {
        self.navigationController!.popViewController(animated: true)
    }
    
    @objc func rightImageBtn(_ sender:UIBarButtonItem) {
        
    }
    
    @objc func leftImageBtn(_ sender:UIBarButtonItem) {
        
    }
    
    @objc func rightTextBtn(_ sender:UIBarButtonItem) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MainViewController {
    
     func addDefaultBackBarButtonLeft() {
        let button =   UIButton(type: .custom)
        button.frame = CGRect(x:0, y:0, width:60, height:44)
        button.setImage(UIImage(named:"ic_nav_back_white"), for: .normal)
        button.addTarget(self, action: #selector(backToPrevious), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0)
        let leftBarBtn = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarBtn
    }
    
    func addDefaultButtonTextRight(_ title:String) {
        let button =   UIButton(type: .custom)
        button.frame = CGRect(x:0, y:0, width:60, height:44)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(rightTextBtn(_:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        let leftBarBtn = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = leftBarBtn
    }
    
    func addDefaultButtonTextLeft(_ title:String) {
        let button =   UIButton(type: .custom)
        button.frame = CGRect(x:0, y:0, width:60, height:44)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(rightTextBtn(_:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        let leftBarBtn = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarBtn
    }
    
    func addDefaultButtonImageRight(_ buttonImage:String) {
        let image = UIImage(named:buttonImage)?.withRenderingMode(.alwaysOriginal)
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightImageBtn(_ :)))
        self.navigationItem.rightBarButtonItem = item;
    }
    
    func addDefaultButtonImageLeft(_ buttonImage:String) {
        let image = UIImage(named:buttonImage)?.withRenderingMode(.alwaysOriginal)
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(leftImageBtn(_:)))
        self.navigationItem.leftBarButtonItem = item
    }
    
    func pushNextViewController(_ viewController:UIViewController,_ animated:Bool) {
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func addSearchBar() ->(view:UIView,textfield:UITextField){
        let viewHeight:CGFloat = 28
//        let textFieldHeight:CGFloat = 18
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: XMAKE(246), height: viewHeight)
        view.backgroundColor = R_UINavigationBarColor
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1).cgColor
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_search")
        imageView.frame = CGRect(x: XMAKE(5), y: view.frame.height/2 - XMAKE(20)/2 + 2, width: XMAKE(15), height: XMAKE(15))
        view.addSubview(imageView)
        let textField = SearchTextField()
        textField.frame = CGRect(x: imageView.frame.maxX + XMAKE(5) , y: 0, width: view.frame.size.width - imageView.frame.maxX - XMAKE(5), height: viewHeight)
        textField.placeholder = "搜索商户、地点、厨师"
//        textField.delegate = self
        textField.setValue(UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1), forKeyPath: "_placeholderLabel.textColor")
        textField.resignFirstResponder()
        textField.textColor = UIColor.white
        textField.placeholderFont(UIFont.systemFont(ofSize: 12))
//        textField.backgroundColor = UIColor.red
        textField.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(textField)
        return (view,textField)
    }
}
