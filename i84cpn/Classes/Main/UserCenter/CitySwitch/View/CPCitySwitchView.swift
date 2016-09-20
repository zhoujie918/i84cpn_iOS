//
//  CPCitySwitchView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/20.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPCitySwitchView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        self.addSubview(cityTitleLabel)
        self.addSubview(cityLabel)
        self.addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        cityTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(20)
        }
        
        cityLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(cityTitleLabel)
            make.left.equalTo(cityTitleLabel.snp_right).offset(5)
        }
        
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(cityTitleLabel.snp_bottom).offset(30)
            make.left.right.equalTo(0)
//            make.bottom.equalTo(0)
            make.height.equalTo(275)
        }
    }

    
    private let cityTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "您当前定位的城市："
        return view
    } ()
    
    let cityLabel: UILabel = {
        let view = UILabel()
        view.text = "抚顺"
        view.textColor = Constants.paleWordColor
        return view
    } ()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 55
        view.separatorStyle = UITableViewCellSeparatorStyle.None
        view.backgroundColor = Constants.paleBGColor
        return view
    } ()
}
