//
//  MineInformationVC.swift
//  FoodFamily
//
//  Created by tam on 2017/11/11.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import IQKeyboardManager
import SVProgressHUD

protocol MineInformationDelegate {
    func mineInformationChangeUserInfo()
}
class MineInformationVC: MainViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {
    fileprivate let photoAlbum = LJXPhotoAlbum()
    fileprivate var headCell = MineInformationHeadCell()
    fileprivate let mineInformationHeadCell = "MineInformationHeadCell"
    fileprivate let mineInformationListCell = "MineInformationListCell"
    let headingContentArray = ["头像","昵称","年龄","星座","城市","签名"]
    var contentArray = NSArray()
    var textfieldRect = CGRect()
    var province = ""
    var city     = ""
    var nicknameTextField = UITextField()
    var ageTextField = UITextField()
    var starTextField = UITextField()
    var positionTextField = UITextField()
    var signTextField = UITextField()
    var delegate:MineInformationDelegate?
//    ["nickname":"","age":"","star":"","province":"","city":"","sign":""]
    
    struct MineInformationUX {
        static let cellHeight:CGFloat = 60
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人资料"
        self.addDefaultButtonTextRight("保存")
        self.setCloseRoundKeyboard()
        
        let newAge = NSNumber(value: UserDefaults.standard.getUserInfo().age as! Float).stringValue
        let nickname = UserDefaults.standard.getUserInfo().nickname as Any
        let sign = UserDefaults.standard.getUserInfo().sign as Any
        let star = UserDefaults.standard.getUserInfo().star as Any
        let avatar = UserDefaults.standard.getUserInfo().pice as Any
        self.city = UserDefaults.standard.getUserInfo().city as! String
        self.province = UserDefaults.standard.getUserInfo().province as! String
        var position = ""
        if self.city != "" && self.province != "" {
           position = self.province + "、" + self.city
        }else{
           position = self.province + self.city
        }
        self.contentArray = [avatar,nickname,newAge,star,position,sign]
        
        view.addSubview(tableView)
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
        let parameters = ["nickname":self.nicknameTextField.text!,"age":self.ageTextField.text!,"star":self.starTextField.text!,"province":self.province,"city":self.city,"sign":self.signTextField.text!]
        let avatar = (headCell.avatarImageView.image)!
        
        let jsonParameters =  NetWorkTool.getJSONStringFromDictionary(dictionary:parameters as NSDictionary)
        let newParameters = ["data":jsonParameters]
        
        NetWorkTool.uploadPictures(url: ConstAPI.kAPIUserUpdateUserInfo, parameter: newParameters, image: avatar, imageKey: "photo", success: { (json) in
            print(json)
            let responseData = Mapper<ResponseData>().map(JSONObject: json)
            if let code = responseData?.code {
                guard  100 == code else {
                    SVProgressHUD.showInfo(withStatus: responseData?.message)
                    return
                }
                let data = json["data"] as![String:AnyObject]
                let user = data["user"] as![String:AnyObject]
                let price = user["pice"] as! String
                
                SVProgressHUD.showSuccess(withStatus: "上传成功")
                let userInfo = UserDefaults.standard.getUserInfo()
                userInfo.nickname = self.nicknameTextField.text! as AnyObject
                userInfo.age = NSNumber(value: NSString(string: self.ageTextField.text!).floatValue)
                userInfo.star = self.starTextField.text! as AnyObject
                userInfo.province = self.province as AnyObject
                userInfo.city = self.city as AnyObject
                userInfo.sign = self.signTextField.text! as AnyObject
                userInfo.pice = price as AnyObject
                UserDefaults.standard.saveCustomObject(customObject: userInfo, key: R_UserInfo)
                self.delegate?.mineInformationChangeUserInfo()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
        }) { (error) in
            
        }
        
    }
    
    //上传头像
    func uploadPhoto(_ image:UIImage){
        headCell.avatarImageView.image = MineInformationVC.resizeImage(image: image, newSize: CGSize(width: 50, height: 50))
//        self.avatarImage = image
//        NetWorkTool.uploadPictures(url: ConstAPI.kAPIUserUpdateUserInfo, parameter: nil, image: image, imageKey: "photo", success: { (json) in
//            let responseData = Mapper<ResponseData>().map(JSONObject: json)
//            if let code = responseData?.code {
//                guard  100 == code else {
//                    SVProgressHUD.showInfo(withStatus: responseData?.message)
//                    return
//                }
//               SVProgressHUD.showSuccess(withStatus: "上传成功")
//            }
//        }) { (error) in
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
            headCell.avatarImageView.sd_setImage(with: NSURL(string: contentArray[indexPath.row] as! String)! as URL, placeholderImage: UIImage.init(named: "ic_all_smallImageDefault"))
            headCell.mineInformationHeadCallBack = { () in
                self.addPickController()
            }
            return headCell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: mineInformationListCell, for: indexPath) as! MineInformationListCell
            cell.mineInformationListCallBack = {(sender:UIButton) in
                self.closeKeyboard()
                if sender.tag == 3 {
                    BRStringPickerView.showStringPicker(withTitle: "星座", dataSource: ["白羊座","金牛座","双子座","巨蟹座","狮子座","处女座","天秤座","天蝎座","射手座","摩羯座","水瓶座","双鱼座"], defaultSelValue: "白羊", isAutoSelect: false, resultBlock: { (data:Any) in
                        let start = data as! String
                        self.starTextField.text = start
                    })
                }else{
                    BRAddressPickerView.showAddressPicker(withDefaultSelected: [10,0], isAutoSelect: false
                        , resultBlock: { (data:Any) in
                            let selectAddressArr = data as! NSArray
                            self.province = selectAddressArr.firstObject as! String
                            self.city = selectAddressArr.lastObject as! String
                            self.positionTextField.text = self.province + "、" + self.city
                    })
                }
            }
            cell.selectionStyle = .none
            cell.headingLabel.text = headingContentArray[indexPath.row]
            cell.textfield.text = contentArray[indexPath.row] as? String
            
            cell.textfield.delegate = self
            cell.textfieldButton.tag = indexPath.row
            if indexPath.row == 1 {
                self.nicknameTextField = cell.textfield
            }else if indexPath.row == 2 {
                self.ageTextField = cell.textfield
                cell.textfield.keyboardType = .numberPad
            }else if indexPath.row == 3 {
                cell.textfield.isEnabled = false
                cell.textfieldButton.isHidden = false
                self.starTextField = cell.textfield
            }else if indexPath.row == 4 {
                 cell.textfield.isEnabled = false
                 cell.textfieldButton.isHidden = false
                self.positionTextField = cell.textfield
            }else if indexPath.row == 5 {
                self.signTextField = cell.textfield
            }
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
    
    func addPickController(){
        let alertAction = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        alertAction.addAction(UIAlertAction.init(title: "相册", style: .default, handler: { (alertCamera) in
            let pickerVC = UIImagePickerController()
            pickerVC.delegate = self
            pickerVC.sourceType = .photoLibrary
            pickerVC.allowsEditing = true
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.present(pickerVC, animated: true, completion: nil)
            } else {
                SVProgressHUD.show(withStatus: "请允许访问相册")
            }
            
        }))
        alertAction.addAction(UIAlertAction.init(title: "相机", style: .default, handler: { (alertPhoto) in
            let pickerVC = UIImagePickerController()
            pickerVC.delegate = self
            pickerVC.sourceType = .camera
            pickerVC.allowsEditing = true
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.present(pickerVC, animated: true, completion: nil)
            }  else {
                SVProgressHUD .show(withStatus: "请允许访问相机")
            }
        }))
        alertAction.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (alertCancel) in
            
        }))
        self.present(alertAction, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
            self.uploadPhoto(chosenImage)
        }
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

    class func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
}
