//
//  CPRealNameAlertView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/12.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPRealNameAlertView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.4)
        containView.addSubview(imageView)
        containView.addSubview(tipTitleLabel)
        containView.addSubview(subContainView)
        
        subContainView.addSubview(tipLabel)
        subContainView.addSubview(line)
        subContainView.addSubview(closeButton)
        self.addSubview(containView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        containView.snp_makeConstraints { (make) in
            make.top.equalTo(150)
            make.left.equalTo(70)
            make.right.equalTo(-70)
            make.bottom.equalTo(closeButton.snp_bottom).offset(20)
        }
        
        imageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(containView)
            make.top.equalTo(containView).offset(15)
        }
        
        tipTitleLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(containView)
            make.top.equalTo(imageView.snp_bottom).offset(15)
        }
        
        subContainView.snp_makeConstraints { (make) in
            make.left.right.equalTo(containView)
            make.top.equalTo(tipTitleLabel.snp_bottom).offset(15)
            make.bottom.equalTo(closeButton.snp_bottom).offset(20)
        }
        
        tipLabel.snp_makeConstraints { (make) in
            make.top.equalTo(subContainView.snp_top).offset(20)
            make.left.equalTo(subContainView).offset(20)
            make.right.equalTo(subContainView)
        }
        
        line.snp_makeConstraints { (make) in
            make.left.right.equalTo(containView)
            make.top.equalTo(tipLabel.snp_bottom).offset(30)
            make.height.equalTo(1)
        }
        
        closeButton.snp_makeConstraints { (make) in
            make.left.equalTo(line)
            make.top.equalTo(line).offset(10)
            make.width.equalTo(line)
            make.height.equalTo(30)
        }
    }
    
    private let containView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.paleBGColor
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_fail")
        return view
    } ()
    
    private let tipTitleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = NSTextAlignment.Center
        view.textColor = Constants.redWordColor
        view.text = "实名验证失败!"
        return view
    } ()
    
    private let subContainView = Constants.containView()
    private let tipLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFontOfSize(13)
        view.textColor = Constants.paleWordColor
        view.numberOfLines = 0
        let str = String("可能存在的问题：\n1、身份证输入错误\n2、姓名输入错误\n3、您在公安部的登记信息存在异常")
        var attributeString = NSMutableAttributedString(string: str)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 9
        attributeString.addAttributes([NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, str.characters.count))
        view.attributedText = attributeString
        return view
    } ()
    
    private let line = Constants.splitLine()
    
    let closeButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(Constants.paleWordColor, forState: .Normal)
        btn.titleLabel?.textColor = Constants.blackWordColor
        btn.setTitle("关  闭", forState: .Normal)
        return btn
    } ()
}
