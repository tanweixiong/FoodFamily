//
//  Extensions.swift
//  TradingPlatform
//
//  Created by tam on 2017/8/8.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

extension UIColor {

    //自定义16进制颜色
    class func R_UIColorFromRGB(color:Int) -> UIColor {
        return UIColor(red: ((CGFloat)((color & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((color & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(color & 0xFF)) / 255.0,
                       alpha: 1.0)
    }
    
    //RGB的颜色
    class func R_UIRGBColor(red:CGFloat ,green:CGFloat ,blue:CGFloat ,alpha:CGFloat) -> UIColor {
        return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}

extension UIImage {

    //使用颜色创造图片
    class func creatImageWithColor(color: UIColor, size: CGSize, alpha: CGFloat) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size);
        let content = UIGraphicsGetCurrentContext();
        content?.setFillColor(color.cgColor);
        content?.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!;
    }
    
    /**
     *  重设图片大小
     */
    func creatSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    func createScaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return creatSizeImage(reSize: reSize)
    }
}

extension UIView {
    class func botonLine(view:UIView,color:UIColor) {
        let layers = CALayer()
        layers.frame = CGRect(x: 0, y:CGFloat(view.frame.height - 1), width: SCREEN_WIDTH, height: 0.5)
        layers.backgroundColor = color.cgColor
    }
}

//extension LBXScanViewController {
//    func setCustomLBScan() ->LBXScanViewStyle{
//        var style = LBXScanViewStyle()
//        style.centerUpOffset = 60;
//        style.xScanRetangleOffset = 30;
//        if UIScreen.main.bounds.size.height <= 480 {
//            //3.5inch 显示的扫码缩小
//            style.centerUpOffset = 40;
//            style.xScanRetangleOffset = 20;
//        }
//        style.color_NotRecoginitonArea = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.4)
//        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner;
//        style.photoframeLineW = 2.0;
//        style.photoframeAngleW = 16;
//        style.photoframeAngleH = 16;
//        style.isNeedShowRetangle = false;
//        style.anmiationStyle = LBXScanViewAnimationStyle.NetGrid;
//        style.animationImage = UIImage(named: "qrcode_scan_full_net")
//        return style
//    }
//    
//}
//
extension String {
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
    
//    func md5() -> String {
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        CC_MD5(str!, strLen, result)
//        let hash = NSMutableString()
//        for i in 0 ..< digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        result.deinitialize()
//
//        return String(format: hash as String)
//    }
    
//}

extension UserDefaults {
    func saveCustomObject(customObject object: NSCoding, key: String) {
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: object)
        self.set(encodedObject, forKey: key)
        self.synchronize()
    }
    func getCustomObject(forKey key: String) -> AnyObject? {
        let decodedObject = self.object(forKey: key) as? NSData
        
        if let decoded = decodedObject {
            let object = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data)
            return object as AnyObject
        }
        return nil
    }
    
    //获取用户信息
    func getUserInfo()-> UserInfo {
        let userInfo = UserDefaults.standard.getCustomObject(forKey: "userInfo")
        if userInfo == nil {
            let userInfo = UserInfo()
            return userInfo
        }else{
            return UserDefaults.standard.getCustomObject(forKey: "userInfo") as! UserInfo
        }
    }
}

extension UIButton {
    
    class func setBtnBoarderCorner(radius:CGFloat) -> UIButton {
        let btn = UIButton()
        btn.clipsToBounds = (radius != 0 );
        btn.layer.cornerRadius = radius;
        return btn
    }
    
}

extension UILabel {
    
    func getStringSize(text:String ,size:CGSize,font:CGFloat) -> CGSize{
        var newSize = CGSize();
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: font)]
        newSize = text.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes  , context: nil).size;
        return newSize
    }
}

extension UIViewController {
    func setCloseRoundKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closeKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
}

