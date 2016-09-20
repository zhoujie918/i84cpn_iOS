//
//  CPPassengerInfoView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/23.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPPassengerInfoView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        
        self.addSubview(tipLabel)
        self.addSubview(tableView)
        
        tableView.tableFooterView = containView
        
        containView.addSubview(addButton)
        containView.addSubview(relevanceButton)
        
        addButton.addSubview(addButtonImage)
        addButton.addSubview(addButtonTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        tipLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(20)
        }
        
        tableView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(tipLabel.snp_bottom).offset(20)
            make.bottom.equalTo(0)
        }
        
        containView.frame = CGRectMake(0, 0, Constants.screenWidth, 200)
        
        addButton.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(100)
        }
        
        addButtonImage.snp_makeConstraints { (make) in
            make.centerY.equalTo(addButton)
            make.height.width.equalTo(30)
            make.left.equalTo(20)
        }
        
        addButtonTitle.snp_makeConstraints { (make) in
            make.centerY.equalTo(addButton)
            make.left.equalTo(addButtonImage.snp_right).offset(10)
        }
        
        relevanceButton.snp_makeConstraints { (make) in
            make.left.equalTo(30)
            make.bottom.equalTo(containView).offset(-30)
            make.top.equalTo(addButton.snp_bottom).offset(30)
            make.width.equalTo(Constants.screenWidth - 30 * 2)
        }
    }
    
    private let tipLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = Constants.smallFont
        
        var text:NSMutableAttributedString = NSMutableAttributedString(string: "请如实上传乘客照片填写姓名\n驾驶员将根据照片及姓名核对乘车人")
        text.addAttributes([NSForegroundColorAttributeName: Constants.redWordColor], range: NSMakeRange(0, text.length))
        
        //设置缩进、行距
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9;//行距
        text.addAttributes([NSParagraphStyleAttributeName: style], range: NSMakeRange(0, text.length))
        style.alignment = NSTextAlignment.Center
        view.attributedText = text
        return view
    } ()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 90
        view.separatorStyle = UITableViewCellSeparatorStyle.None
        view.contentInset = UIEdgeInsetsMake(0, 0, 250, 0)
        view.backgroundColor = Constants.paleBGColor
        return view
    } ()
    
    let addButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.whiteBGColor
        return view
    } ()
    
    private let addButtonImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_add")
        return view
    } ()
    
    private let addButtonTitle: UILabel = {
        let view = UILabel()
        view.text = "添加新乘客"
        view.textColor = Constants.yellowWordColor
        return view
    } ()
    
    private let containView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.paleBGColor
        return view
    } ()
    
    let relevanceButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setTitle("关联乘客信息", forState: .Normal)
        btn.tintColor = Constants.whiteWordColor
        btn.layer.cornerRadius = 16
        btn.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: .Normal)
        return btn
    } ()
}
