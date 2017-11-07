//
//  FoodReservationCodeCell.swift
//  FoodFamily
//
//  Created by tam on 2017/11/7.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

import UIKit

class FoodReservationCodeCell: UITableViewCell {
    var foodReservationCodeCallBack:(()->())?;
    var time:Int = 60
    @IBOutlet weak var getCodeBtn: UIButton!
    @IBOutlet weak var headingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getCodeBtn.layer.borderColor = UIColor.R_UIRGBColor(red: 67, green: 66, blue: 67, alpha: 1).cgColor
        getCodeBtn.layer.borderWidth = 1
    }

    @IBAction func getCodeClick(_ sender: UIButton) {
        if foodReservationCodeCallBack != nil {
            foodReservationCodeCallBack!()
        }
        self.getCodeBtn.isEnabled = false
        self.setTimeCountDown()
    }
    
    func setTimeCountDown() {
        // 在global线程里创建一个时间源
        let timer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        // 设定时间源的触发事件
        timer.setEventHandler(handler: {
            // 每秒计时一次
            self.time = self.time - 1
            DispatchQueue.main.async {
                self.getCodeBtn.setTitle("\(self.time)秒", for: .normal)
            }
            // 时间到了取消时间源
            if self.time <= 0 {
                timer.cancel()
                // 返回主线程处理一些事件，更新UI等等
                DispatchQueue.main.async {
                    self.getCodeBtn.setTitle("获取验证码", for: .normal)
                    self.getCodeBtn.isEnabled = true
                    self.time = 60
                }
            }
        })
        // 启动时间源
        timer.resume()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
