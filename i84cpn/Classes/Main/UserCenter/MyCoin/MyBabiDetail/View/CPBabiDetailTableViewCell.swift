//
//  CPBabiDetailTableViewCell.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/11.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPBabiDetailTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(titleLabel)
        self.addSubview(timeLabel)
        self.addSubview(babiLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(20)
        }
        
        timeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(3)
        }
        
        babiLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(-40)
        }
    }
    
    let titleLabel: UILabel = UILabel()
    let timeLabel = UILabel()
    let babiLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.mediumFont
        return label
    } ()
}
