//
//  CPCityCell.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/6/3.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPCityCell: UITableViewCell {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(titileLabel)
        self.addSubview(inButton)
        self.addSubview(cityLabel)
    }
    
    override func layoutSubviews() {
        titileLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(17)
        }
        
        inButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-15)
        }
        
        cityLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(inButton.snp_left).offset(-15)
        }

    }
    
    let titileLabel: UILabel = {
        let label: UILabel = UILabel()
//        label.font = Constants.mediumFont
        label.text = "城市切换"
        return label
    } ()
    
    let inButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setImage(UIImage(named: "icon_in02"), forState: .Normal)
        return btn
    } ()
    
    let cityLabel: UILabel = {
        let label: UILabel = UILabel()
//        label.font = Constants.mediumFont
        label.textColor = Constants.yellowWordColor
        return label
    } ()
    
}
