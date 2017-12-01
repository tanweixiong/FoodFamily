//
//  MyScoresVC.swift
//  AGTMall
//
//  Created by tam on 2017/10/18.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJRefresh

class MyScoresVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate lazy var viewModel : MineScoresVM = MineScoresVM()
    fileprivate let lead:CGFloat = 10
    fileprivate let mineScoresCell = "MineScoresCell"
    fileprivate var allTableView = UITableView()
    fileprivate var incomeTableView = UITableView()
    fileprivate var expenditureTableView = UITableView()
    
    fileprivate var isLoadIncome:Bool = true
    fileprivate var isLoadExpenditure:Bool = true
    
    fileprivate var allPageNum:Int = 0
    fileprivate var incomePageNum:Int = 0
    fileprivate var expenditurePageNum:Int = 0
    
    
    struct MyScoresUX {
        static let myScoresViewSize:CGSize = CGSize(width: SCREEN_KeyWindowBounds.size.width, height: SCREEN_KeyWindowBounds.size.height)
        static let myScoresHeadViewSize:CGSize = CGSize(width: SCREEN_WIDTH, height: YMAKE(62))
        static let scoresLabelFont:CGFloat = 35
        static let scoresImageSize:CGSize = CGSize(width: 30, height: 30)
        static let lineHeight:CGFloat = 2
        static let lineWidth:CGFloat = XMAKE(70)
        static let rowHeight:CGFloat = 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setColor(UIColor.clear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setColor(R_UINavigationBarColor)
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
        
        myScoresView.addSubview(scrollView)
        scrollView.addSubview(self.setAllTableView())
        scrollView.addSubview(self.setIncomeTableView())
        scrollView.addSubview(self.setExpenditureTableView())
        
        self.getALlData()
//        self.getIncomeData()
//        self.getExpenditureData()
    }
    
    //获取所有记录
    func getALlData(){
        let parameters = ["type":"0","pageNum":"\(allPageNum)","pageSize":""]
        viewModel.loadAllSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIUserWalletGetUserIntegral, parameters: parameters, showIndicator: false) {(hasData:Bool) in
            if hasData{
                self.allPageNum = self.allPageNum + 1
                self.allTableView.reloadData()
            }
            self.allTableView.mj_footer.endRefreshing()
        }
    }
    
    //获取收入记录
    func getIncomeData(){
        let parameters = ["type":"1","pageNum":"\(incomePageNum)","pageSize":""]
        if isLoadIncome {
             SVProgressHUD.show(withStatus: "请稍等")
        }
        viewModel.loadIncomeSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIUserWalletGetUserIntegral, parameters: parameters, showIndicator: false) {(hasData:Bool) in
            SVProgressHUD.dismiss()
            if hasData {
                self.incomePageNum = self.incomePageNum + 1
                self.incomeTableView.reloadData()
            }
                self.incomeTableView.mj_footer.endRefreshing()
        }
    }
    
    //获取支出记录
    func getExpenditureData(){
        let parameters = ["type":"2","pageNum":"\(expenditurePageNum)","pageSize":""]
        if isLoadExpenditure {
            SVProgressHUD.show(withStatus: "请稍等")
        }
        viewModel.loadExpenditureSuccessfullyReturnedData(requestType: .get, URLString: ConstAPI.kAPIUserWalletGetUserIntegral, parameters: parameters, showIndicator: false) {(hasData:Bool) in
            SVProgressHUD.dismiss()
            if hasData {
                self.expenditurePageNum = self.expenditurePageNum + 1
                self.expenditureTableView.reloadData()
            }
               self.expenditureTableView.mj_footer.endRefreshing()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == allTableView {
            return viewModel.allModel.count
        }else if tableView == incomeTableView {
            return viewModel.incomeModel.count
        }else{
            return viewModel.expenditureModel.count
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MyScoresUX.rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //全部列表
        if tableView == allTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: mineScoresCell, for: indexPath) as! MineScoresCell
            cell.selectionStyle = .none
            cell.model = viewModel.allModel[indexPath.row]
            return cell
        }else if tableView == incomeTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: mineScoresCell, for: indexPath) as! MineScoresCell
            cell.selectionStyle = .none
            cell.model = viewModel.incomeModel[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: mineScoresCell, for: indexPath) as! MineScoresCell
            cell.selectionStyle = .none
            cell.model = viewModel.expenditureModel[indexPath.row]
            return cell
        }
    }
    
    func createLine(){
        let btn:UIButton = self.myScoresHeadView.chooseBtn!
        let x = CGFloat((btn.frame.origin.x + btn.frame.size.width/2) - (MyScoresUX.lineWidth/2) - lead)
        self.line.frame = CGRect(x:x, y: self.myScoresHeadView.frame.size.height - MyScoresUX.lineHeight, width: MyScoresUX.lineWidth, height: MyScoresUX.lineHeight)
    }
    
    func setAnimate(sender:UIButton){
        UIView.animate(withDuration: 0.2, animations: {
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
            if sender.tag == 1{
                self.scrollView.contentOffset = CGPoint(x: SCREEN_WIDTH, y: 0)
                if self.isLoadIncome{
                    self.getIncomeData()
                }
                self.isLoadIncome = false
            }else if sender.tag == 2 && self.isLoadExpenditure {
                self.scrollView.contentOffset = CGPoint(x: SCREEN_WIDTH * 2, y: 0)
                if self.isLoadExpenditure {
                     self.getExpenditureData()
                }
                self.isLoadExpenditure = false
            }else{
                self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
            }
            self.setAnimate(sender: sender)
        }
        return view
    }()
    
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.R_UIRGBColor(red: 70, green: 168, blue: 241, alpha: 1)
        return view
    }()
    
    lazy var scrollView:UIScrollView = {
        let maxY = MyScoresUX.myScoresHeadViewSize.height/2 + 15 + 215
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: maxY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 215 - MyScoresUX.myScoresHeadViewSize.height/2 - 15)
        scrollView.isPagingEnabled = true;
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.clipsToBounds = false;
        scrollView.bounces = false;
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH * 3, height: scrollView.frame.size.height)
        return scrollView
    }()
    
    func setAllTableView()->UITableView {
        allTableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height:self.scrollView.frame.size.height))
        allTableView.showsVerticalScrollIndicator = false
        allTableView.dataSource = self
        allTableView.delegate = self
        allTableView.register(UINib(nibName: "MineScoresCell", bundle: nil),forCellReuseIdentifier: self.mineScoresCell)
        allTableView.backgroundColor = R_UISectionLineColor
        allTableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        allTableView.tableFooterView = UIView()
        allTableView.separatorColor = R_UISectionLineColor
        allTableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
             self.getALlData()
        })
        return allTableView
    }
    

    func setIncomeTableView()->UITableView {
        incomeTableView = UITableView.init(frame: CGRect(x: SCREEN_WIDTH, y: 0 , width: SCREEN_WIDTH, height:self.scrollView.frame.size.height))
        incomeTableView.showsVerticalScrollIndicator = false
        incomeTableView.dataSource = self
        incomeTableView.delegate = self
        incomeTableView.register(UINib(nibName: "MineScoresCell", bundle: nil),forCellReuseIdentifier: self.mineScoresCell)
        incomeTableView.backgroundColor = R_UISectionLineColor
        incomeTableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        incomeTableView.tableFooterView = UIView()
        incomeTableView.separatorColor = R_UISectionLineColor
        incomeTableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.getIncomeData()
        })
        return incomeTableView
    }
    
    func setExpenditureTableView()->UITableView {
        expenditureTableView = UITableView.init(frame: CGRect(x: SCREEN_WIDTH * 2, y: 0 , width: SCREEN_WIDTH, height:self.scrollView.frame.size.height))
        expenditureTableView.showsVerticalScrollIndicator = false
        expenditureTableView.dataSource = self
        expenditureTableView.delegate = self
        expenditureTableView.register(UINib(nibName: "MineScoresCell", bundle: nil),forCellReuseIdentifier: self.mineScoresCell)
        expenditureTableView.backgroundColor = R_UISectionLineColor
        expenditureTableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        expenditureTableView.tableFooterView = UIView()
        expenditureTableView.separatorColor = R_UISectionLineColor
        expenditureTableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.getExpenditureData()
        })
        return expenditureTableView
    }
}
