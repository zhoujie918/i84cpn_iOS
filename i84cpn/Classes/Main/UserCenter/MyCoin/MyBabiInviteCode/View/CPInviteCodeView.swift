//
//  CPInviteCodeView.swift
//  i84cpn
//  邀请码
//  Created by BenjaminRichard on 16/5/11.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPInviteCodeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        
        containView.addSubview(tipLabel2)
        containView.addSubview(QRCodeView)
        
        containView2.addSubview(tipLabel3)
        containView2.addSubview(linkTextField)
        containView2.addSubview(copyButton)
        
        self.addSubview(tipLabel1)
        self.addSubview(containView)
        self.addSubview(containView2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        tipLabel1.snp_makeConstraints { (make) in
            make.top.equalTo(80)
            make.left.right.equalTo(0)
        }
        
        containView.snp_makeConstraints { (make) in
            make.top.equalTo(tipLabel1.snp_bottom).offset(20)
            make.left.right.equalTo(0)
            make.bottom.equalTo(QRCodeView.snp_bottom).offset(30)
        }
        
        tipLabel2.snp_makeConstraints { (make) in
            make.top.left.equalTo(containView).offset(20)
        }
        
        QRCodeView.snp_makeConstraints { (make) in
            make.width.height.equalTo(250)
            make.centerX.equalTo(self)
            make.top.equalTo(tipLabel2.snp_bottom).offset(20)
        }
        
        containView2.snp_makeConstraints { (make) in
            make.top.equalTo(containView.snp_bottom).offset(20)
            make.left.right.equalTo(0)
            make.bottom.equalTo(linkTextField.snp_bottom).offset(30)
        }
        
        tipLabel3.snp_makeConstraints { (make) in
            make.left.top.equalTo(containView2).offset(20)
        }
        
        linkTextField.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel3)
            make.top.equalTo(tipLabel3.snp_bottom).offset(20)
        }
        
        copyButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(linkTextField)
            make.right.equalTo(-20)
        }
    }
    
    private let tipLabel1: UILabel = {
        let label = UILabel()
        label.textColor = .redColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(13)
        label.text = "请先让您的好友下载 同学号APP，方可进行一下操作"
        return label
    } ()
    
    private let containView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteColor()
        return view
    } ()
    
    private let tipLabel2: UILabel = {
        let label = UILabel()
        label.text = "让好友扫描二维码进行注册"
        return label
    } ()
    
    private let QRCodeView: UIImageView = {
        let view = UIImageView()
//        let image =
        view.backgroundColor = Constants.paleBGColor
        return view
    } ()
    
    private let containView2: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteColor()
        return view
    } ()
    
    private let tipLabel3:UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFontOfSize(14)
        view.text = "发送以下链接给好友进行注册"
        return view
    } ()
    
    private let linkTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = UITextBorderStyle.Bezel
        view.font = Constants.smallFont
        view.text = "http://www.5i84.cn/register?regType=register"
        return view
    } ()
    
    let copyButton:UIButton = {
        let view = UIButton()
        view.setTitle("复 制", forState: .Normal)
        view.setTitleColor(.orangeColor(), forState: .Normal)
        view.contentEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 15)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.orangeColor().CGColor
        return view
    } ()
}
