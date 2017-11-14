//
//  FoodEvaluationListCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/14.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit
import YYText
import SVProgressHUD

class FoodEvaluationListCell: UITableViewCell,YYTextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var foodEvaluationListCellBack:(()->())?;
    fileprivate let imageCount:CGFloat = 4
    fileprivate var currentCount:CGFloat = 1
    fileprivate let space:CGFloat = 14
    fileprivate var currentButton = UIButton()
    struct FoodEvaluationListUX {
        static let textViewHeight:CGFloat = 80
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(){
        contentView.addSubview(textView!)
        self.addImage(UIImage.init(named: "ic_mine_addImage")!)
        
        //先计算每次添加图片的宽度
        let width =  (SCREEN_WIDTH - ((imageCount + 1) * space))/imageCount
        
        textView?.snp.makeConstraints({ (make) in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.left.equalTo(contentView.snp.left).offset(14)
            make.right.equalTo(contentView.snp.right).offset(-14)
            make.height.greaterThanOrEqualTo(FoodEvaluationListUX.textViewHeight)
            
        })
        
        currentButton.snp.makeConstraints { (make) in
            make.top.equalTo((textView?.snp.bottom)!).offset(14)
            make.left.equalTo(contentView.snp.left).offset(14)
            make.width.greaterThanOrEqualTo(width)
            make.height.greaterThanOrEqualTo(width)
        }
          let maxY = 15 + FoodEvaluationListUX.textViewHeight + 14 + width + 12
          UserDefaults.standard.set(maxY, forKey: "height")
    }
    
    func addImage(_ image:UIImage){
        let button = UIButton(type: .custom)
        let rect = currentButton.frame
        button.frame = CGRect(x: rect.maxX + space, y: rect.origin.y, width: rect.size.width, height: rect.size.height)
        button.setBackgroundImage(image, for: .normal)
        contentView.addSubview(button)
        currentButton = button
        currentButton.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
    }
    
    lazy var textView:YYTextView? = {
        let view = YYTextView.init(frame: CGRect.init(x: 0, y: 0, width:SCREEN_WIDTH, height: FoodEvaluationListUX.textViewHeight))
        view.delegate = self
        view.placeholderText = "请填写您的评价信息"
        view.placeholderFont = UIFont.systemFont(ofSize: 12)
        view.textColor = UIColor.R_UIRGBColor(red: 104, green: 104, blue: 104, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 12)
        view.layer.masksToBounds = true
        return view
    }()
    
    
    @objc func onClick(_ sender:UIButton){
        guard  self.currentCount != 4 else {
            SVProgressHUD.showInfo(withStatus: "已经不能在添加图片了！")
            return
        }
        self.currentCount += 1
        self.addPickController()
    }
    
    func addPickController(){
        let vc = OCTools.getCurrentVC()
        let alertAction = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        alertAction.addAction(UIAlertAction.init(title: "相册", style: .default, handler: { (alertCamera) in
            let pickerVC = UIImagePickerController()
            pickerVC.delegate = self
            pickerVC.sourceType = .photoLibrary
            pickerVC.allowsEditing = true
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                vc?.present(pickerVC, animated: true, completion: nil)
            } else {
                SVProgressHUD .show(withStatus: "请允许访问相册")
            }
            
        }))
        alertAction.addAction(UIAlertAction.init(title: "相机", style: .default, handler: { (alertPhoto) in
            let pickerVC = UIImagePickerController()
            pickerVC.delegate = self
            pickerVC.sourceType = .camera
            pickerVC.allowsEditing = true
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                vc?.present(pickerVC, animated: true, completion: nil)
            }  else {
                SVProgressHUD .show(withStatus: "请允许访问相机")
            }
        }))
        
        alertAction.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (alertCancel) in
            
        }))
        vc?.present(alertAction, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
         self.addImage(chosenImage)
        }
    }
    
}
