//
//  CPRealNameView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/12.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPRealNameView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        self.addSubview(scrollView)
        
        containView.addSubview(certNumTextField)
        containView.addSubview(line)
        containView.addSubview(nameTextField)
        
        scrollView.addSubview(tipLabel1)
        scrollView.addSubview(containView)
        scrollView.addSubview(tipLabel2)
        scrollView.addSubview(validateButton)
        scrollView.addSubview(promiseTitleLabel)
        scrollView.addSubview(promiseLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        scrollView.snp_makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.bottom.right.equalTo(self)
        }
        
        tipLabel1.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(20)
        }
        
        containView.snp_makeConstraints { (make) in
            make.top.equalTo(tipLabel1.snp_bottom).offset(10)
            make.left.right.equalTo(self)
            make.bottom.equalTo(nameTextField.snp_bottom).offset(20)
        }
        
        certNumTextField.snp_makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(containView.snp_top).offset(20)
            make.right.equalTo(0)
        }
        
        line.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(certNumTextField.snp_bottom).offset(20)
            make.height.equalTo(1)
        }
        
        nameTextField.snp_makeConstraints { (make) in
            make.left.right.equalTo(certNumTextField)
            make.top.equalTo(line.snp_bottom).offset(20)
        }
        
        tipLabel2.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(containView.snp_bottom).offset(20)
        }
        
        validateButton.snp_makeConstraints { (make) in
            make.left.right.equalTo(line)
            make.top.equalTo(tipLabel2.snp_bottom).offset(40)
        }
        
        promiseTitleLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(validateButton.snp_bottom).offset(40)
        }
        
        promiseLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(promiseTitleLabel.snp_bottom).offset(20)
        }
        
        scrollView.contentSize = CGSizeMake(Constants.screenWidth, promiseLabel.frame.origin.y + promiseLabel.frame.height + 80)
    }

    private let scrollView = UIScrollView()
    
    private let tipLabel1: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFontOfSize(13)
        view.textColor = Constants.paleWordColor
        view.text = "为了能更好更准确地为您服务，请完成实名认证:"
        return view
    } ()
    
    private let containView = Constants.containView()
    
    let certNumTextField: UITextField = {
        let view = UITextField()
        view.font = UIFont.systemFontOfSize(13)
        view.placeholder = "请输入18位身份证号码"
        return view
    } ()
    
    private let line = Constants.splitLine()
    
    let nameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "请输入身份证上的姓名"
        view.font = UIFont.systemFontOfSize(13)
        return view
    } ()
    
    let tipLabel2: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFontOfSize(13)
        view.textColor = Constants.redWordColor
        view.text = "实名认证信息不可修改，请谨慎输入"
        view.textAlignment = NSTextAlignment.Center
        return view
    } ()
    
    let validateButton: UIButton = {
        let view = UIButton()
        view.setTitle("验 证", forState: .Normal)
        view.layer.cornerRadius = 16
        view.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: .Normal)
        return view
    } ()
    
    private let promiseTitleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = NSTextAlignment.Center
//        view.text = "郑重承诺 :"
        return view
    } ()
    
    private let promiseLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.tipWordColor
        view.font = UIFont.systemFontOfSize(14)
        view.textAlignment = NSTextAlignment.Center
        view.numberOfLines = 0
        view.text = "为了防止不法分子窃取您孩子的出行信息。\n同学号将配合公安部门提供安全实名认证服务，\n请确认您的认证信息真实有效。"
        return view
    } ()
}
