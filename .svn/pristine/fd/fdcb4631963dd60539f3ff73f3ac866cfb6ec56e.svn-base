//
//  CPBabiDetailView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/11.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPBabiDetailView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
    
        containView1.addSubview(dateButton)
        containView1.addSubview(searchButton)
        
        containView2.addSubview(operationTitleLabel)
        containView2.addSubview(balanceTitleLabel)
        self.addSubview(containView1)
        self.addSubview(containView2)
        self.addSubview(line)
        self.addSubview(tableView)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        containView1.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self).offset(64)
            make.bottom.equalTo(self.snp_centerY).offset(-30)
        }
        
        dateButton.snp_makeConstraints { (make) in
            make.left.equalTo(50)
            make.top.equalTo(20)
        }
        
        searchButton.snp_makeConstraints { (make) in
            make.left.equalTo(dateButton.snp_right).offset(20)
            make.top.equalTo(dateButton)
        }
        
        containView2.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(containView1.snp_bottom).offset(20)
            make.bottom.equalTo(operationTitleLabel.snp_bottom).offset(10)
        }
        
        operationTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(containView2.snp_top).offset(10)
        }
        
        balanceTitleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(operationTitleLabel)
            make.right.equalTo(self).offset(-30)
        }
        
        line.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(containView2.snp_bottom)
        }
        
        tableView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self)
            make.top.equalTo(line).offset(1)
        }
        
    }

    private let containView1:UIView = {
        let view = UIView()
        view.backgroundColor = Constants.whiteWordColor
        return view
    } ()
    
    let dateButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setTitle("2016年04月", forState: .Normal)
        btn.setTitleColor(Constants.blackWordColor, forState: .Normal)
        return btn
    } ()
    let searchButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setTitle("查 询", forState: .Normal)
        btn.setTitleColor(Constants.yellowWordColor, forState: .Normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = Constants.yellowWordColor.CGColor
        btn.contentEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 15)
        return btn
    } ()
    
    private let containView2: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.whiteBGColor
        return view
    } ()
    
    private let operationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "操作记录"
        label.font = UIFont.systemFontOfSize(14)
        return label
    } ()
    
    private let balanceTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(14)
        label.text = "余 额"
        return label
    } ()
    
    private let line: UIView = {
        let line = UIView()
        line.backgroundColor = Constants.mainColor
        return line
    } ()
    
    let tableView: UITableView = {
        let view: UITableView = UITableView()
        view.separatorStyle = UITableViewCellSeparatorStyle.None
        view.rowHeight = 70
        return view
    } ()
}
