//
//  NetWorkTool.swift
//  DHSWallet
//
//  Created by zhengyi on 2017/8/21.
//  Copyright © 2017年 zhengyi. All rights reserved.
//

import UIKit
import Alamofire
import SystemConfiguration
import SVProgressHUD
import SwiftyJSON

class NetWorkTool: NSObject {
    class func request(requestType: HTTPMethod, URLString: String, parameters: [String : Any]?, showIndicator: Bool, success: @escaping (_ response : [String:AnyObject]) -> () , failture: @escaping(_ error: Error) -> ()) {
        var requestParameters = parameters
        if parameters != nil {
            let jsonParameters =  NetWorkTool.getJSONStringFromDictionary(dictionary:parameters! as NSDictionary)
            requestParameters = ["data":jsonParameters]
        }
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.configuration.timeoutIntervalForRequest = 10
        sessionManager.request(URLString, method: requestType, parameters: requestParameters).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                success(value as! [String : AnyObject])
            case .failure(let error):
                failture(error)
                if showIndicator {
                    SVProgressHUD.showError(withStatus: "网络不给力请稍后再试")
                }
            }
        }
    }
    
    //关于文件上传的方法(支持多或者单上传)
    class func uploadPictures(url: String, parameter :[String:Any]?, image: UIImage, imageKey: String,success : @escaping (_ response : [String : AnyObject])->(), fail : @escaping (_ error : Error)->()){
        let requestHead = ["content-type":"multipart/form-data"]
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                if parameter != nil {
                    for (key,value) in parameter!{
                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName:key)
                    }
                }
                let imageName = Tools.getCurrentTime() + ".jpg"
                multipartFormData.append(UIImageJPEGRepresentation(image, 1.0)!, withName: imageKey, fileName: imageName, mimeType: "image/jpeg")
        },
            to: url,
            headers: requestHead,
            encodingCompletion: { result in
                switch result {
                    
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            success(value)
                        }
                    }
                    
                case .failure(let error):
                    fail(error)
                }
        }
        )
    }
    
   class func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
    
}

extension NetWorkTool {

}

