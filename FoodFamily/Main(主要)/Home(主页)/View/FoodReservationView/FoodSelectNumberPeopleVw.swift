//
//  FoodSelectNumberPeopleVw.swift
//  FoodFamily
//
//  Created by tam on 2017/11/29.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

protocol FoodSelectNumberPeopleDelegate {
    func foodSelectNumberPeopleChoose(_ data:String)
}

class FoodSelectNumberPeopleVw: UIView,UITableViewDelegate,UITableViewDataSource{
    fileprivate let foodSelectNumberDayCell = "FoodSelectNumberDayCell"
    fileprivate var tableView = UITableView()
    fileprivate var indexPath = IndexPath()
    fileprivate var dataScorce = NSMutableArray()
    fileprivate let backgroundVwHeight:CGFloat = YMAKE(250)
    fileprivate let titleViewHeight:CGFloat = 44
    fileprivate var chooseTextColor:UIColor = R_UIThemeGoldColor
    fileprivate var normlTextColor:UIColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
    fileprivate var peopleNum:Int = 20 //设置预约人数设置
    var delegate:FoodSelectNumberPeopleDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = (UIApplication.shared.keyWindow?.bounds)!
        self.show()
    }
    
    func show(){
        self.createUI()
    }
    
    func clean(){
        self.backgroundView.isHidden = true
        self.removeFromSuperview()
    }
    
    func createUI(){
        self.indexPath = NSIndexPath(row: 0, section: 0) as IndexPath
        for index in 1...self.peopleNum {
            self.dataScorce.add("\(index)")
        }
        self.addSubview(backgroundView)
        self.addSubview(backgroundListView)
        backgroundListView.addSubview(titleView)
        backgroundListView.addSubview(titleLabel)
        backgroundListView.addSubview(self.setTableView())
        backgroundListView.addSubview(dissButton)
        
        tableView.snp.updateConstraints { (make) in
            make.left.equalTo(titleView.snp.left).offset(0)
            make.top.equalTo(titleView.snp.bottom)
            make.width.greaterThanOrEqualTo(self.frame.size.width)
            make.height.greaterThanOrEqualTo(backgroundVwHeight - titleViewHeight)
        }
        
        dissButton.snp.updateConstraints { (make) in
            make.right.equalTo(titleView.snp.right).offset(-15)
            make.centerY.equalTo(titleView.snp.centerY)
            make.width.greaterThanOrEqualTo(dissButton.frame.size.width)
            make.height.greaterThanOrEqualTo(dissButton.frame.size.height)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissOnClick(_:)))
        self.backgroundView.addGestureRecognizer(tap)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataScorce.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let num = self.dataScorce[indexPath.row]
        self.delegate?.foodSelectNumberPeopleChoose(num as! String)
        self.clean()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: foodSelectNumberDayCell, for: indexPath) as! FoodSelectNumberDayCell
        cell.selectionStyle = .none
        cell.dayLabel.text = self.dataScorce[indexPath.row] as? String
        return cell
    }
    
    func setTableView()->UITableView{
        self.tableView = UITableView()
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "FoodSelectNumberDayCell", bundle: nil),forCellReuseIdentifier: self.foodSelectNumberDayCell)
        self.tableView.backgroundColor = R_UIThemeBackgroundColor
        self.tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        return self.tableView
    }
    
    lazy var titleView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: titleViewHeight))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    //使用规则
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.frame = CGRect(x: 0, y: 0, width: self.titleView.frame.size.width, height: titleViewHeight)
        label.text = "仅接受一人以上的预定"
        label.textColor = UIColor.R_UIRGBColor(red: 155, green: 155, blue: 155, alpha: 1)
        return label
    }()
    
    lazy var backgroundView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        view.backgroundColor = UIColor.black
        view.alpha = 0.4
        return view
    }()
    
    lazy var dissButton:UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        btn.addTarget(self, action: #selector(dissmissOnClick(_:)), for: .touchUpInside)
        btn.setBackgroundImage(UIImage.init(named: "ic_home_error"), for: .normal)
        return btn
    }()
    
    lazy var backgroundListView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.frame.size.height - backgroundVwHeight , width: self.frame.size.width, height: backgroundVwHeight))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    @objc func dissmissOnClick(_ sender:UIButton){
        self.clean()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
