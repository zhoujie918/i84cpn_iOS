//
//  CPValidatedView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/12.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPValidatedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        self.addSubview(scrollView)
        scrollView.addSubview(containView)
        
        containView.addSubview(cerTitleLabel)
        containView.addSubview(line)
        containView.addSubview(validatedDateLabel)
        containView.addSubview(validatedDateTitleLabel)
        containView.addSubview(nameTitleLabel)
        containView.addSubview(nameLabel)
        containView.addSubview(certNumTitleLabel)
        containView.addSubview(certNumLabel)
        
        scrollView.addSubview(validatedImageView)
        scrollView.addSubview(validatedStatusLabel)
        scrollView.addSubview(welcomeLabel)
        scrollView.addSubview(containView)
        scrollView.addSubview(closeButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        if CPUserModel.authDate != nil {
            validatedDateLabel.text = CPUserModel.authDate
        }
        
        if CPUserModel.realName != nil {
            nameLabel.text = CPUserModel.realName
        }
        
        if CPUserModel.idNo != nil {
            certNumLabel.text = CPUserModel.idNo
        }
    }

    
    override func layoutSubviews() {
        scrollView.snp_makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.bottom.right.equalTo(self)
        }
        
        
        validatedImageView.snp_makeConstraints { (make) in
            make.top.equalTo(120)
            make.left.equalTo(welcomeLabel).offset(30)
        }
        
        validatedStatusLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(validatedImageView.snp_bottom).offset(-3)
            make.left.equalTo(validatedImageView.snp_right).offset(10)
        }
        
        welcomeLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(validatedImageView.snp_bottom).offset(10)
        }
        
        containView.snp_makeConstraints { (make) in
            make.top.equalTo(welcomeLabel.snp_bottom).offset(70)
            make.left.equalTo(60)
            make.right.equalTo(self).offset(-60)
            make.bottom.equalTo(certNumLabel.snp_bottom).offset(40)
        }
        
        cerTitleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(containView).offset(15)
            make.left.right.equalTo(containView)
        }
        
        line.snp_makeConstraints { (make) in
            make.left.right.equalTo(containView)
            make.top.equalTo(cerTitleLabel.snp_bottom).offset(15)
            make.height.equalTo(1)
        }
        
        validatedDateTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(containView).offset(20)
            make.top.equalTo(line).offset(30)
        }
        
        validatedDateLabel.snp_makeConstraints { (make) in
            make.left.equalTo(validatedDateTitleLabel.snp_right).offset(3)
            make.centerY.equalTo(validatedDateTitleLabel)
//            make.right.equalTo(containView)
        }
        
        nameTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(validatedDateTitleLabel)
            make.top.equalTo(validatedDateTitleLabel.snp_bottom).offset(15)
        }
        
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameTitleLabel.snp_right).offset(3)
            make.centerY.equalTo(nameTitleLabel)
        }
        
        certNumTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(validatedDateTitleLabel)
            make.top.equalTo(nameTitleLabel.snp_bottom).offset(15)
        }
        
        certNumLabel.snp_makeConstraints { (make) in
            make.left.equalTo(certNumTitleLabel.snp_right).offset(3)
            make.centerY.equalTo(certNumTitleLabel)
        }
        
        closeButton.snp_makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(containView.snp_bottom).offset(40)
        }
        
        scrollView.contentSize = CGSizeMake(Constants.screenWidth, closeButton.frame.origin.y + closeButton.frame.height + 80)
    }

    private let scrollView = UIScrollView()
    
    private let validatedImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cer_ok")
        return view
    } ()
    
    private let validatedStatusLabel: UILabel = {
        let view = UILabel()
        view.text = "已通过实名认证"
        return view
    } ()
    
    private let welcomeLabel: UILabel = {
        let view = UILabel()
        view.text = "欢迎您的加入， 您可以享受更多的服务。"
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        view.textAlignment = NSTextAlignment.Center
        return view
    } ()
    
    private let containView = Constants.containView()
    
    private let cerTitleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = NSTextAlignment.Center
        view.text = "您的身份信息"
        return view
    } ()
    
    private let line = Constants.splitLine()
    
    private let validatedDateTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.text = "认证通过时间: "
        
        return view
    } ()
    
    let validatedDateLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.paleWordColor
        view.font = Constants.smallFont
        return view
    } ()
    
    private let nameTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.text = "姓名："
        
        return view
    } ()
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.paleWordColor
        view.font = Constants.smallFont
        
        return view
    } ()
    
    private let certNumTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.text = "身份证号："
        
        return view
    } ()
    
    let certNumLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.paleWordColor
        view.font = Constants.smallFont
        return view
    } ()
    
    let closeButton: UIButton = {
        let view = UIButton()
        view.setTitle("关闭", forState: .Normal)
        view.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: .Normal)
        return view
    } ()
}
