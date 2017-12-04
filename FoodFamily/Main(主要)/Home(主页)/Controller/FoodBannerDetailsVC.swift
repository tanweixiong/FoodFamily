//
//  FoodBannerDetailsVC.swift
//  FoodFamily
//
//  Created by tam on 2017/12/4.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD

class FoodBannerDetailsVC: UIViewController,UIWebViewDelegate {
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情"
        self.setWebView()
    }
    
    func setWebView(){
        webView.delegate = self
        SVProgressHUD.show(withStatus: "请稍等", maskType: .black)
        let url:NSURL = NSURL.init(string: self.url)!
        webView.loadRequest(NSURLRequest(url: url as URL) as URLRequest)
        self.view.addSubview(webView)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let time: TimeInterval = 0.1
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            SVProgressHUD.dismiss()
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.showInfo(withStatus: "网络不给力，请稍后再试")
    }
    
    let webView:UIWebView = {
        let view = UIWebView()
        view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
        return view
    }()
}
