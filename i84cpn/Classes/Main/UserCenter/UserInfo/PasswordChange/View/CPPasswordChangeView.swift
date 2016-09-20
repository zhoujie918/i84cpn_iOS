//
//  CPPasswordChangeView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/12.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPPasswordChangeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        
        self.addSubview(containView)
        self.addSubview(tipLabel)
        containView.addSubview(oldPasswordTextField)
        containView.addSubview(oldPasswordButton)
        containView.addSubview(line)
        containView.addSubview(newPasswordTextField)
        containView.addSubview(newPasswordButton)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        containView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(20)
            make.bottom.equalTo(newPasswordTextField.snp_bottom).offset(20)
        }
        
        oldPasswordTextField.snp_makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(containView.snp_top).offset(topOffset)
            make.right.equalTo(oldPasswordButton.snp_left).offset(-10)
        }
        
        oldPasswordButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(oldPasswordTextField)
            make.right.equalTo(-20)
        }
        
        line.snp_makeConstraints { (make) in
            make.left.equalTo(oldPasswordTextField)
            make.right.equalTo(oldPasswordButton)
            make.top.equalTo(oldPasswordTextField.snp_bottom).offset(topOffset)
            make.height.equalTo(1)
        }
        
        newPasswordTextField.snp_makeConstraints { (make) in
            make.left.equalTo(oldPasswordTextField)
            make.top.equalTo(line.snp_bottom).offset(topOffset)
            make.width.equalTo(oldPasswordTextField)
        }
        
        newPasswordButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(newPasswordTextField)
            make.centerX.equalTo(oldPasswordButton)
            make.width.equalTo(oldPasswordButton)
        }
        
        tipLabel.snp_makeConstraints { (make) in
            make.top.equalTo(containView.snp_bottom).offset(30)
            make.left.right.equalTo(0)
        }
    }
    
    private let topOffset = 20.0
    
    private let containView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.whiteBGColor
        return view
    } ()
    
    let oldPasswordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "请输入原登录密码"
        view.font = Constants.mediumFont
        view.secureTextEntry = false
        return view
    } ()
    
    private let line = Constants.splitLine()
    
    let oldPasswordButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "icon_open"), forState: .Normal)
        return view
    } ()
    
    let newPasswordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "请输入新密码，不少于六位字符"
        view.font = Constants.mediumFont
        view.secureTextEntry = true
        return view
    } ()
    
    let newPasswordButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "icon_close"), forState: .Normal)
        return view
    } ()
    
    let tipLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = NSTextAlignment.Center
        view.font = Constants.mediumFont
        view.textColor = Constants.redWordColor
        view.text = "原登录密码错误，是否有大小写"
        view.hidden = true
        return view
    } ()
}
