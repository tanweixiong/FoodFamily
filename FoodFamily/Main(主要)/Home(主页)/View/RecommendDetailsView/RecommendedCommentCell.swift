//
//  RecommendedCommentCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/6.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class RecommendedCommentCell: UITableViewCell {
    
    var commentDataModel : RecommendCommentListDataModel = RecommendCommentListDataModel()!{
        didSet{
//            avatarImageView.sd_setImage(with: NSURL(string: commentDataModel.userHead!)! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
            contextLabel.text = "阿克索德记录卡技术的科技阿斯利康大家啊就是大家阿克苏河等啊是大家阿克苏河大家看季后赛打框架和大声疾呼的啊时间的哈就是打框架啊说啊还是觉得看哈萨克接电话啊就是打开就是的啊就是电话卡时代"
            nameLabel.text = commentDataModel.nickname
            createTimeLabel.text = commentDataModel.createTime
        }
    }
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var assessImageView1: UIImageView!
    @IBOutlet weak var assessImageView2: UIImageView!
    @IBOutlet weak var imageBackgroundVw: UIView!
    @IBOutlet weak var assessImageView3: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(){
        if commentDataModel.assessPic?.count != 0 {
            self.imageBackgroundVw.isHidden = false
            if commentDataModel.assessPic?.count == 1 {
                assessImageView1.sd_setImage(with: NSURL(string: commentDataModel.assessPic?.firstObject as! String)! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
            }else if commentDataModel.assessPic?.count == 2 {
                assessImageView1.sd_setImage(with: NSURL(string: commentDataModel.assessPic?.firstObject as! String)! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
                assessImageView2.sd_setImage(with: NSURL(string: commentDataModel.assessPic?.lastObject as! String )! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
            }else if commentDataModel.assessPic?.count == 3 {
                assessImageView1.sd_setImage(with: NSURL(string: commentDataModel.assessPic?.firstObject as! String)! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
                assessImageView2.sd_setImage(with: NSURL(string: commentDataModel.assessPic?[1] as! String )! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
                assessImageView3.sd_setImage(with: NSURL(string: commentDataModel.assessPic?.lastObject as! String )! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
            }
        }else{
           self.imageBackgroundVw.isHidden = true
        }
        let size:CGSize = contextLabel.getStringSize(text: contextLabel.text!, size: CGSize(width:SCREEN_WIDTH - 98,height:CGFloat(MAXFLOAT)), font: 14)

        let labelMaxY = size.height + 63
        let sumHeight:CGFloat = commentDataModel.assessPic?.count == 0 ? labelMaxY : labelMaxY + imageBackgroundVw.frame.size.height
         UserDefaults.standard.set(sumHeight + 15 , forKey: "height")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
