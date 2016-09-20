//
//  CPRefundSucView.swift
//  i84cpn
//
//  Created by 杰伦 on 16/5/28.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPRefundSucView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.clearBlackBGColor
        
        self.addSubview(containView)
        containView.addSubview(sucImageView)
        containView.addSubview(titleLabel)
        containView.addSubview(detailLabel)
        containView.addSubview(closeButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        containView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.top.equalTo(sucImageView.snp_top).offset(-20)
            make.bottom.equalTo(closeButton.snp_bottom).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(self).offset(-20)
        }
        
        sucImageView.snp_makeConstraints { (make) in
            make.left.equalTo(containView).offset(20)
            make.top.equalTo(containView).offset(20)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(sucImageView.snp_right).offset(10)
            make.top.equalTo(sucImageView)
        }
        
        detailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(8)
            make.right.equalTo(containView).offset(20)
        }
        
        closeButton.snp_makeConstraints { (make) in
            make.top.equalTo(sucImageView.snp_bottom).offset(30)
            make.left.equalTo(containView).offset(10)
            make.right.equalTo(containView).offset(-10)
            make.height.equalTo(22)
        }
    }
    
    func setDetailLabel(amout: String) {
        let text1: NSMutableAttributedString = NSMutableAttributedString(string: "退款金额为：", attributes: [NSForegroundColorAttributeName: Constants.blackWordColor])
        let text2: NSMutableAttributedString = NSMutableAttributedString(string: amout, attributes: [NSForegroundColorAttributeName: Constants.redWordColor])
        text1.appendAttributedString(text2)
        
        detailLabel.attributedText = text1
    }

    
    private let containView = Constants.containView()
    
    private let sucImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cer_ok")
        return view
    } ()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "退订成功"
        return view
    } ()
    
    private let detailLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.mediumFont
        view.numberOfLines = 0

        return view
    } ()

    let closeButton: UIButton = {
        let view = UIButton()
        view.setTitle("关闭", forState: .Normal)
        view.setTitleColor(Constants.blackWordColor, forState: .Normal)
        view.layer.borderColor = Constants.paleWordColor.CGColor
        view.layer.borderWidth = 1
        view.titleLabel?.font = Constants.smallFont 
        return view
    } ()
}
