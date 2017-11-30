//
//  MyScoresVC.swift
//  AGTMall
//
//  Created by tam on 2017/10/18.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class MyScoresVC: UIViewController {
    
    fileprivate let lead:CGFloat = 10
    struct MyScoresUX {
        static let myScoresViewSize:CGSize = CGSize(width: SCREEN_KeyWindowBounds.size.width, height: SCREEN_KeyWindowBounds.size.height)
        static let myScoresHeadViewSize:CGSize = CGSize(width: SCREEN_WIDTH, height: YMAKE(62))
        static let scoresLabelFont:CGFloat = 35
        static let scoresImageSize:CGSize = CGSize(width: 30, height: 30)
        static let lineHeight:CGFloat = 2
        static let lineWidth:CGFloat = XMAKE(70)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的积分"
        
        view.addSubview(myScoresView)
        view.addSubview(myScoresHeadView)
        view.addSubview(scoresLabel)
        view.addSubview(scoresImageView)
        
        myScoresView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view.snp.top).offset(-64)
            make.left.equalTo(view.snp.left)
            make.width.equalTo(SCREEN_KeyWindowBounds.size.width + 1)
            make.height.equalTo(SCREEN_KeyWindowBounds.size.height + 1)
        }
        
        myScoresHeadView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(myScoresView.headView.snp.bottom).offset(-MyScoresUX.myScoresHeadViewSize.height/2)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(MyScoresUX.myScoresHeadViewSize.width)
            make.height.equalTo(MyScoresUX.myScoresHeadViewSize.height)
        }
        
        let scoresSize:CGSize = scoresLabel.getStringSize(text:scoresLabel.text!, size: CGSize(width: SCREEN_WIDTH, height: MyScoresUX.scoresLabelFont), font:  MyScoresUX.scoresLabelFont)
        scoresLabel.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalTo(myScoresView.headView.snp.centerX)
            make.centerY.equalTo(myScoresView.headView.snp.centerY)
            make.width.equalTo(scoresSize.width + 1)
            make.height.equalTo(scoresSize.height)
        }
        
        scoresImageView.snp.makeConstraints{ (make) -> Void in
            make.right.equalTo(scoresLabel.snp.left).offset(0)
            make.centerY.equalTo(scoresLabel.snp.centerY).offset(-5)
            make.width.equalTo(MyScoresUX.scoresImageSize.width)
            make.height.equalTo(MyScoresUX.scoresImageSize.height)
        }
        
        self.createLine()
    }
    
    func createLine(){
        let btn:UIButton = self.myScoresHeadView.chooseBtn!
        let x = CGFloat((btn.frame.origin.x + btn.frame.size.width/2) - (MyScoresUX.lineWidth/2) - lead)
        self.line.frame = CGRect(x:x, y: self.myScoresHeadView.frame.size.height - MyScoresUX.lineHeight, width: MyScoresUX.lineWidth, height: MyScoresUX.lineHeight)
    }
    
    func setAnimate(sender:UIButton){
        UIView.animate(withDuration: 0.8, animations: {
            let x = CGFloat((sender.frame.origin.x + sender.frame.size.width/2) - (MyScoresUX.lineWidth/2) - self.lead)
            let y = CGFloat(sender.frame.size.height - MyScoresUX.lineHeight)
            self.line.frame = CGRect(x: x, y: y, width: MyScoresUX.lineWidth, height: MyScoresUX.lineHeight)
        }, completion: { (finish) in
        })
    }
    
    lazy var scoresLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: MyScoresUX.scoresLabelFont)
        label.text = "1200"
        return label
    }()
    
    lazy var scoresImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "mine_shape")
        img.layer.cornerRadius = MyScoresUX.scoresImageSize.width/2
        img.clipsToBounds = true
        return img
    }()

    lazy var myScoresView: MyScoresView = {
        let view = Bundle.main.loadNibNamed("MyScoresView", owner: nil, options: nil)?.last as! MyScoresView
        view.frame = CGRect(x: 0, y: -64, width: MyScoresUX.myScoresViewSize.width, height: MyScoresUX.myScoresViewSize.height)
        return view
    }()
    
    lazy var myScoresHeadView: MyScoresHeadView = {
        let view = Bundle.main.loadNibNamed("MyScoresHeadView", owner: nil, options: nil)?.last as! MyScoresHeadView
        view.frame = CGRect(x: 0, y: 0, width: MyScoresUX.myScoresHeadViewSize.width, height: MyScoresUX.myScoresHeadViewSize.height)
        view.addSubview(self.line)
        view.myScoresHeadViewCallBack = {(sender:UIButton) in
            self.setAnimate(sender: sender)
        }
        return view
    }()
    
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.R_UIRGBColor(red: 70, green: 168, blue: 241, alpha: 1)
        return view
    }()

}
