//
//  CPCitySwitchTableViewCell.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/20.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPCitySwitchTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(titleLabel)
        self.addSubview(defaultButton)
        self.addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
 
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalTo(self)
        }
        
        defaultButton.snp_makeConstraints { (make) in
            make.right.equalTo(-30)
            make.centerY.equalTo(titleLabel)
        }
        
        line.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self)
            make.height.equalTo(1)
        }
    }
    
    private let containView = Constants.containView()
    let titleLabel = UILabel()
    let defaultButton: UIButton = UIButton()
    private let line = Constants.splitLine()
}
