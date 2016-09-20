//
//  CPRelavanceView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/6/13.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPRelavanceView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        
        containView.addSubview(contentLabel)
        
        self.addSubview(containView)
        self.addSubview(tipLabel)
        self.addSubview(okButton)
        self.addSubview(refuseButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(isReadOnly: Bool, content: String) {
        if isReadOnly == false {
            notHiddenButton()
        }
        contentLabel.text = content
    }
    
    func notHiddenButton() {
        okButton.hidden = false
        refuseButton.hidden = false
    }
    
    override func layoutSubviews() {
        containView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(contentLabel.snp_bottom).offset(30)
        }
        
        contentLabel.snp_makeConstraints { (make) in
            make.left.equalTo(containView).offset(10)
            make.top.equalTo(containView).offset(30)
            make.right.equalTo(containView).offset(-10)
        }
        
        tipLabel.snp_makeConstraints { (make) in
            make.top.equalTo(containView.snp_bottom).offset(20)
            make.left.right.equalTo(self)
        }
        
        okButton.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(tipLabel.snp_bottom).offset(20)
            make.height.equalTo(28)
        }
        
        refuseButton.snp_makeConstraints { (make) in
            make.left.equalTo(okButton.snp_right).offset(30)
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(okButton)
            make.width.equalTo(okButton)
            make.height.equalTo(okButton)
        }
    }
    
    private let containView = Constants.containView()
    private let contentLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        view.numberOfLines = 0
        return view
    } ()
    
    private let tipLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .Center
        view.textColor = Constants.redWordColor
        view.text  = "如果您不认识该用户，请拒绝申请！\n乘车消息会关系到您孩子的人身安全，请慎重决定。"
        view.font = Constants.superSmallFont
        return view
    } ()
    
    let okButton: UIButton = {
        let view = UIButton()
        view.setTitle("同 意", forState: .Normal)
        view.setTitleColor(Constants.whiteWordColor, forState: .Normal)
        view.hidden = true
        view.setBackgroundImage(UIImage(named: "btn_agree_nor"), forState: .Normal)
        view.setBackgroundImage(UIImage(named: "btn_agree_pre"), forState: .Selected)
        return view
    } ()
    
    let refuseButton: UIButton = {
        let view = UIButton()
        view.hidden = true
        view.setTitle("拒 绝", forState: .Normal)
        view.setTitleColor(Constants.blackWordColor, forState: .Normal)
        view.setBackgroundImage(UIImage(named: "btn_refuse_nor"), forState: .Normal)
        view.setBackgroundImage(UIImage(named: "btn_refuse_pre"), forState: .Selected)
        return view
    } ()
}
