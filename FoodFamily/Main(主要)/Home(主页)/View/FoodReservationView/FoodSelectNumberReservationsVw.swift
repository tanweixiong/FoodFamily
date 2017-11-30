//
//  SelectNumberReservationsVw.swift
//  FoodFamily
//
//  Created by tam on 2017/11/29.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

protocol FoodSelectNumberReservationsDelegate {
    func foodSelectNumberReservationsChoose(_ day:String,_ time:String)
}

class FoodSelectNumberReservationsVw: UIView,UITableViewDelegate,UITableViewDataSource {

    fileprivate let foodSelectNumberDayCell = "FoodSelectNumberDayCell"
    fileprivate let foodSelectNumberTimeCell = "FoodSelectNumberTimeCell"
    fileprivate var dayArray = NSArray()
    fileprivate var timeArray = NSArray()
    fileprivate let backgroundVwHeight:CGFloat = YMAKE(250)
    fileprivate let titleViewHeight:CGFloat = 44
    fileprivate var dayIndexPath = IndexPath()
    fileprivate var timeIndexPath = IndexPath()
    fileprivate var dayTableView = UITableView()
    fileprivate var timeTableView = UITableView()
    fileprivate var foodDayCell = FoodSelectNumberDayCell()
    fileprivate var chooseColor:UIColor = UIColor.R_UIRGBColor(red: 242, green: 242, blue: 242, alpha: 1)
    fileprivate var normlColor:UIColor = UIColor.white
    
    fileprivate var chooseTextColor:UIColor = R_UIThemeGoldColor
    fileprivate var normlTextColor:UIColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1)
    
    var delegate:FoodSelectNumberReservationsDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = (UIApplication.shared.keyWindow?.bounds)!
        self.show()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI(){
       self.dayIndexPath = NSIndexPath(row: 0, section: 0) as IndexPath
       self.timeIndexPath = NSIndexPath(row: 0, section: 0) as IndexPath
        
        self.setDayArray()
        self.setTimeArray()
        
        self.addSubview(backgroundView)
        self.addSubview(backgroundListView)
        backgroundListView.addSubview(titleView)
        backgroundListView.addSubview(titleLabel)
        backgroundListView.addSubview(self.setDayTableView())
        backgroundListView.addSubview(self.setTimeTableView())
        backgroundListView.addSubview(dissButton)

         dayTableView.snp.updateConstraints { (make) in
            make.left.equalTo(titleView.snp.left).offset(0)
            make.top.equalTo(titleView.snp.bottom)
            make.width.greaterThanOrEqualTo(self.frame.size.width/2)
            make.height.greaterThanOrEqualTo(backgroundVwHeight - titleViewHeight)
        }

        timeTableView.snp.updateConstraints { (make) in
            make.left.equalTo(dayTableView.snp.right).offset(0)
            make.top.equalTo(titleView.snp.bottom)
            make.width.greaterThanOrEqualTo(self.frame.size.width/2)
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
        if tableView == dayTableView {
            return dayArray.count
        }
        return timeArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.dayTableView {
            foodDayCell = tableView.dequeueReusableCell(withIdentifier: foodSelectNumberDayCell, for: indexPath) as! FoodSelectNumberDayCell
            foodDayCell.selectionStyle = .none
            foodDayCell.dayLabel.text = (dayArray[indexPath.row] as! String)
            foodDayCell.dayLabel.textColor = indexPath == dayIndexPath ? chooseTextColor : normlTextColor
            foodDayCell.backgroundColor = indexPath == dayIndexPath ? chooseColor : normlColor
            return foodDayCell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: foodSelectNumberTimeCell, for: indexPath) as! FoodSelectNumberTimeCell
            cell.selectionStyle = .none
            cell.timeLabel.text = timeArray[indexPath.row] as? String
            cell.timeLabel.textColor = indexPath == timeIndexPath ? chooseTextColor : normlTextColor
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dayStr = self.dayArray[self.dayIndexPath.row]
        let timeStr = self.timeArray[self.timeIndexPath.row]
        self.delegate?.foodSelectNumberReservationsChoose(dayStr as! String, timeStr as! String)
        if tableView == dayTableView {
            if indexPath == self.dayIndexPath { return }
            self.dayTableView.reloadData()
            self.dayIndexPath  = NSIndexPath(row: indexPath.row, section: indexPath.section) as IndexPath
            
            foodDayCell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section))as! FoodSelectNumberDayCell
            foodDayCell.dayLabel.textColor = chooseTextColor
            foodDayCell.backgroundColor = chooseColor
            
        }else if tableView == timeTableView {
            if indexPath == self.timeIndexPath { return }
            self.timeTableView.reloadData()
            self.timeIndexPath  = NSIndexPath(row: indexPath.row, section: indexPath.section) as IndexPath
            
            let selectedCell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section))as! FoodSelectNumberTimeCell
            selectedCell.timeLabel.textColor = chooseTextColor
            
            self.clean()
        }
    }
    
    func clean(){
        self.backgroundView.isHidden = true
        self.removeFromSuperview()
    }
    
    func show(){
         self.createUI()
    }
    
    func setDayArray(){
        self.dayArray =  OCTools.getCurrentNumberDays()! as NSArray
    }
    
    func setTimeArray(){
        var startTime:Int = 9
        let endTime:Int = 21
        let intervalHours:Int = 2
        let timeNumber = (endTime - startTime) * intervalHours
        var isOns:Bool = true
        let timeArray = NSMutableArray()
        for _ in 0...timeNumber {
            var time = ""
            if isOns {
                 time = "\(startTime)" + ":00"
                 isOns = false
            }else{
                 time = "\(startTime)" + ":30"
                 isOns = true
                 startTime = startTime + 1
            }
            timeArray.add(time)
        }
        self.timeArray = timeArray
    }
    
    func setDayTableView ()-> UITableView{
        self.dayTableView = UITableView()
        self.dayTableView.showsVerticalScrollIndicator = false
        self.dayTableView.dataSource = self
        self.dayTableView.delegate = self
        self.dayTableView.register(UINib(nibName: "FoodSelectNumberDayCell", bundle: nil),forCellReuseIdentifier: self.foodSelectNumberDayCell)
        self.dayTableView.backgroundColor = R_UIThemeBackgroundColor
        self.dayTableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        self.dayTableView.tableFooterView = UIView()
        self.dayTableView.separatorStyle = .none
        return self.dayTableView
    }
    
    func setTimeTableView()->UITableView{
        self.timeTableView = UITableView()
        self.timeTableView.showsVerticalScrollIndicator = false
        self.timeTableView.dataSource = self
        self.timeTableView.delegate = self
        self.timeTableView.register(UINib(nibName: "FoodSelectNumberTimeCell", bundle: nil),forCellReuseIdentifier: self.foodSelectNumberTimeCell)
        self.timeTableView.backgroundColor = R_UIThemeBackgroundColor
        self.timeTableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        self.timeTableView.tableFooterView = UIView()
        self.timeTableView.separatorStyle = .none
        return self.timeTableView
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
        label.text = "选择用餐时间"
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
}
