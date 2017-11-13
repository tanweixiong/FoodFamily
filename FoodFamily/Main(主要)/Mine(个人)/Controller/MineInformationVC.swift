//
//  MineInformationVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import IQKeyboardManager

class MineInformationVC: MainViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    fileprivate let photoAlbum = LJXPhotoAlbum()
    fileprivate var headCell = MineInformationHeadCell()
    fileprivate let mineInformationHeadCell = "MineInformationHeadCell"
    fileprivate let mineInformationListCell = "MineInformationListCell"
    let headingContentArray = ["头像","昵称","年龄","星座","城市","签名"]
    let contentArray = ["头像","昵称","年龄","星座","城市","签名"]
    var textfieldRect = CGRect()
    
    struct MineInformationUX {
        static let cellHeight:CGFloat = 60
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人资料"
        self.addDefaultButtonTextRight("保存")
        self.setCloseRoundKeyboard()
        view.addSubview(tableView)
        
        
        print(self.view.frame)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared().isEnabled = true
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func rightTextBtn(_ sender: UIBarButtonItem) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headingContentArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MineInformationUX.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            headCell = tableView.dequeueReusableCell(withIdentifier: mineInformationHeadCell, for: indexPath) as! MineInformationHeadCell
            headCell.selectionStyle = .none
            headCell.headingLabel.text = headingContentArray[indexPath.row]
            headCell.avatarImageView.image = UIImage.init(named: "")
            headCell.mineInformationHeadCallBack = { () in
                self.photoAlbum.getOrTakeAPhoto(with: self) { (imgae) in
                    self.headCell.avatarImageView.image = imgae
                }
            }
            return headCell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: mineInformationListCell, for: indexPath) as! MineInformationListCell
            cell.selectionStyle = .none
            cell.headingLabel.text = headingContentArray[indexPath.row]
            cell.textfield.text = contentArray[indexPath.row]
            cell.textfield.delegate = self
            return cell
        }
    }
    
    @objc func keyboardWillShow(_ notification:NSNotification) {
        let userInfo = notification.userInfo! as NSDictionary
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Float
        let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        let keyboardH:CGFloat = (keyboardRect?.size.height)!
        UIView.animate(withDuration: TimeInterval(duration)) {
            if keyboardH > 200 {
                let textFileHeight = self.textfieldRect.maxY + 20
                let maxY = SCREEN_HEIGHT_INSIDE - keyboardH
                //计算被挡住的距离
                if textFileHeight > maxY {
                    if textFileHeight >= 360{
                        self.view.frame = CGRect(x: 0, y: -90, width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE)
                        return
                    }
                    let blockTheheight:CGFloat = CGFloat(fabsf(Float(SCREEN_HEIGHT_INSIDE - textFileHeight - keyboardH + 3)))
                    self.view.frame = CGRect(x: 0, y: -blockTheheight, width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE)
                }
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification:NSNotification) {
        let userInfo = notification.userInfo! as NSDictionary
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Float
        UIView.animate(withDuration: TimeInterval(duration)) {
            self.view.frame = CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let content:UIView = textField.superview!
        let cell:UIView = content.superview!
        let rect = cell.convert(textField.frame, to: self.tableView)
        self.textfieldRect = rect
        return true
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: SCREEN_WIDTH, height: SCREEN_HEIGHT_INSIDE))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MineInformationHeadCell", bundle: nil),forCellReuseIdentifier: self.mineInformationHeadCell)
        tableView.register(UINib(nibName: "MineInformationListCell", bundle: nil),forCellReuseIdentifier: self.mineInformationListCell)
        tableView.backgroundColor = R_UISectionLineColor
        tableView.separatorColor = UIColor.R_UIRGBColor(red: 237, green: 237, blue: 237, alpha: 1)
          tableView.separatorInset = UIEdgeInsetsMake(0,SCREEN_WIDTH, 0,SCREEN_WIDTH);
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        return tableView
    }()

}
