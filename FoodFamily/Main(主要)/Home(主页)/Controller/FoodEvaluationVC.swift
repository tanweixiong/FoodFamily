//
//  FoodEvaluationVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/14.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import SVProgressHUD
import YYText

class FoodEvaluationVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    fileprivate let foodEvaluationHeadCell = "FoodEvaluationHeadCell"
    fileprivate let foodEvaluationListCell = "FoodEvaluationListCell"
    fileprivate var textfied = YYTextView()
    struct FoodEvaluationUX {
        static let headViewHeight:CGFloat = 116
        static let sectionHeight:CGFloat = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "评分"
        self.addDefaultButtonTextRight("提交")
        view.addSubview(tableView)
    }
    
    @objc func rightTextBtn(_ sender:UIButton){
        let parameters = ["context":textfied.text!,"star":"","storeId":""] as [String : Any]
        let jsonParameters =  NetWorkTool.getJSONStringFromDictionary(dictionary:parameters as NSDictionary)
        let newParameters = ["data":jsonParameters]
        NetWorkTool.uploadMuchPictures(url:  ConstAPI.kAPIUserUpdateUserInfo, parameter: newParameters, imageArray: [""], imageKey: "photo", success: { (json) in
            let responseData = Mapper<ResponseData>().map(JSONObject: json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.message)
                    return
                }
            }
            SVProgressHUD.showSuccess(withStatus: "上传成功")
        }) { (error) in
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  indexPath.section == 0 ? FoodEvaluationUX.headViewHeight : UserDefaults.standard.object(forKey: "height") != nil ? UserDefaults.standard.object(forKey: "height") as! CGFloat : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: foodEvaluationHeadCell, for: indexPath) as! FoodEvaluationHeadCell
            cell.selectionStyle = .none
            cell.setData()
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: foodEvaluationListCell, for: indexPath) as! FoodEvaluationListCell
            cell.selectionStyle = .none
            cell.setData()
            textfied = cell.textView!
            return cell
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FoodEvaluationHeadCell", bundle: nil),forCellReuseIdentifier: self.foodEvaluationHeadCell)
        tableView.register(UINib(nibName: "FoodEvaluationListCell", bundle: nil),forCellReuseIdentifier: self.foodEvaluationListCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        return tableView
    }()
    
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

}
