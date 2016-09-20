//
//  CPUnsubscribedAlertView.swift
//  i84cpn
//
//  Created by 杰伦 on 16/5/28.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPUnsubscribedAlertView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.clearBlackBGColor
        
        self.addSubview(containView)
        containView.addSubview(msgLabel)
        containView.addSubview(submitButton)
        containView.addSubview(closeButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func layoutSubviews() {
        containView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.top.equalTo(msgLabel.snp_top).offset(-20)
            make.bottom.equalTo(submitButton.snp_bottom).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(self).offset(-20)
        }
        
        msgLabel.snp_makeConstraints { (make) in
            make.left.equalTo(containView).offset(10)
            make.right.equalTo(containView).offset(-10)
        }
        
        submitButton.snp_makeConstraints { (make) in
            make.top.equalTo(msgLabel.snp_bottom).offset(20)
            make.left.equalTo(msgLabel)
        }
        
        closeButton.snp_makeConstraints { (make) in
            make.top.equalTo(submitButton)
            make.left.equalTo(submitButton.snp_right).offset(20)
            make.right.equalTo(msgLabel)
            make.width.equalTo(submitButton)
        }
    }
    
    func reloadData(dicData: NSDictionary) {
        let deduct = dicData.objectForKey("deduct") as! String
        let takeDays = dicData.objectForKey("takeDays") as! Int
        let takeAmout = dicData.objectForKey("takeAmout") as! String
        let refundAmout = dicData.objectForKey("refundAmout") as! String
        let deductRate = dicData.objectForKey("deductRate") as! String
//        let payType = dicData.objectForKey("payType") as! String
        let orderPrice = dicData.objectForKey("orderPrice") as! String
//        let deductAmout = Int(orderPrice)!  - Int(takeAmout)! - Int(deduct)!
//        if deductRate.characters.count != 0 {
//            deductRate = String(Float(deductRate))
//        }
//        let s: String! = deductRate
        let text1: NSMutableAttributedString = NSMutableAttributedString(string: "您确定要退订吗？\n购票金额：", attributes: [NSForegroundColorAttributeName: Constants.blackWordColor])
        let text2: NSMutableAttributedString = NSMutableAttributedString(string: orderPrice + "元", attributes: [NSForegroundColorAttributeName: Constants.redWordColor])
        let text3: NSMutableAttributedString = NSMutableAttributedString(string: "，违约金为价格的", attributes: [NSForegroundColorAttributeName: Constants.blackWordColor])
        let text4: NSMutableAttributedString = NSMutableAttributedString(string: deductRate + "%", attributes: [NSForegroundColorAttributeName: Constants.redWordColor])
        let text5: NSMutableAttributedString = NSMutableAttributedString(string: "，计", attributes: [NSForegroundColorAttributeName: Constants.blackWordColor])
        let text6: NSMutableAttributedString = NSMutableAttributedString(string: String(deduct) + "元", attributes: [NSForegroundColorAttributeName: Constants.redWordColor])
        let text7: NSMutableAttributedString = NSMutableAttributedString(string: "，您已乘坐", attributes: [NSForegroundColorAttributeName: Constants.blackWordColor])
        let text8: NSMutableAttributedString = NSMutableAttributedString(string: String(takeDays), attributes: [NSForegroundColorAttributeName: Constants.redWordColor])
        let text9: NSMutableAttributedString = NSMutableAttributedString(string: "趟次，计", attributes: [NSForegroundColorAttributeName: Constants.blackWordColor])
        let text10: NSMutableAttributedString = NSMutableAttributedString(string: takeAmout + "元", attributes: [NSForegroundColorAttributeName: Constants.redWordColor])
        let text11: NSMutableAttributedString = NSMutableAttributedString(string: "，应退金额", attributes: [NSForegroundColorAttributeName: Constants.blackWordColor])
        let text12: NSMutableAttributedString = NSMutableAttributedString(string: refundAmout + "元", attributes: [NSForegroundColorAttributeName: Constants.redWordColor])
        let text13: NSMutableAttributedString = NSMutableAttributedString(string: "。金额将于三个工作日内退至您的支付宝账户内。", attributes: [NSForegroundColorAttributeName: Constants.blackWordColor])
        
        text1.appendAttributedString(text2)
        text1.appendAttributedString(text3)
        text1.appendAttributedString(text4)
        text1.appendAttributedString(text5)
        text1.appendAttributedString(text6)
        text1.appendAttributedString(text7)
        text1.appendAttributedString(text8)
        text1.appendAttributedString(text9)
        text1.appendAttributedString(text10)
        text1.appendAttributedString(text11)
        text1.appendAttributedString(text12)
        text1.appendAttributedString(text13)
        
        //设置缩进、行距
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 11;//行距
        text1.addAttributes([NSParagraphStyleAttributeName: style], range: NSMakeRange(0, text1.length))
        
        msgLabel.attributedText = text1
    }
    
    private let containView = Constants.containView()
    let msgLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
//        view.font = Constants.mediumFont
        return view
    } ()
    
    let submitButton: UIButton = {
        let view = UIButton()
        view.setTitle("确定", forState: .Normal)
        view.setTitleColor(Constants.blackWordColor, forState: .Normal)
        view.layer.borderColor = Constants.paleWordColor.CGColor
        view.layer.borderWidth = 1
        return view
    } ()
    
    let closeButton: UIButton = {
        let view = UIButton()
        view.setTitle("关闭", forState: .Normal)
        view.setTitleColor(Constants.blackWordColor, forState: .Normal)
        view.layer.borderColor = Constants.paleWordColor.CGColor
        view.layer.borderWidth = 1
        return view
    } ()
}
