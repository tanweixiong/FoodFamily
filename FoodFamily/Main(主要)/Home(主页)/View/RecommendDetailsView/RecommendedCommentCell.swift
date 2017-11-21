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
            avatarImageView.sd_setImage(with: NSURL(string: commentDataModel.userHead!)! as URL, placeholderImage: UIImage.init(named: "ic_all_imageDefault"))
            contextLabel.text = commentDataModel.context
            nameLabel.text = commentDataModel.nickname
            createTimeLabel.text = commentDataModel.createTime
        }
    }
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
