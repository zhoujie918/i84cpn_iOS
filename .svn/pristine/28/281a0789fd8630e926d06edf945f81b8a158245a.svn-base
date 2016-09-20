//
//  CPHistoryView.swift
//  i84cpn
//
//  Created by Benjamin on 16/5/27.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPHistoryView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        self.addSubview(tableView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews()  {
        tableView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(20)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self)
        }
    }
    
    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 90
        view.separatorStyle = UITableViewCellSeparatorStyle.None
        view.contentInset = UIEdgeInsetsMake(0, 0, 250, 0)
        view.backgroundColor = Constants.paleBGColor
        return view
    } ()
}
