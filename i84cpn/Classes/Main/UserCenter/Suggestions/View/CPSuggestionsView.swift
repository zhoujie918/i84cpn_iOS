//
//  CPSuggestionsView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/20.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPSuggestionsView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        
        self.addSubview(tableView)
        self.addSubview(tipLabel)
        self.addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.right.equalTo(0)
            make.bottom.equalTo(tipLabel.snp_top).offset(-30)
        }
        
        tipLabel.snp_makeConstraints { (make) in
            make.left.equalTo(20)
        }
        
        button.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(self).offset(-100)
            make.top.equalTo(tipLabel.snp_bottom).offset(10)
        }
    }
    
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = Constants.paleBGColor
        view.separatorStyle = UITableViewCellSeparatorStyle.None
        view.estimatedRowHeight = 120
        view.rowHeight = UITableViewAutomaticDimension
        return view
    } ()
    
    private let tipLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.redWordColor
        view.text = "提意见送巴币活动正在进行中..."
        return view
    } ()
    
    let button: UIButton = {
        let view = UIButton()
        view.setTitle("我有话说: ", forState: .Normal)
        view.setTitleColor(Constants.paleWordColor, forState: .Normal)
        view.backgroundColor = Constants.whiteBGColor
        return view
    } ()
}
