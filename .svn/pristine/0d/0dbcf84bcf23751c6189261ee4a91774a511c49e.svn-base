//
//  CPVersionCell.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/10.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPVersionCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(titleLabel)
        self.addSubview(tipImageView)
        self.addSubview(detailLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        titleLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(17)
        }
        
        tipImageView.snp_makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_top)
            make.left.equalTo(titleLabel.snp_right).offset(2)
        }
        
        detailLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-15)
        }

    }
    
    func setShow() {
        tipImageView.hidden = false
    }
    
    func setHidden() {
        tipImageView.hidden = true
    }
    
    let titleLabel: UILabel = {
        let view = UILabel()
//        view.font = Constants.mediumFont
        return view
    } ()
    
    let tipImageView: UIImageView = {
        let view: UIImageView = UIImageView()
        view.image = UIImage(named: "icon_red")
        view.hidden = true
        return view
    } ()
    
    let detailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = Constants.paleWordColor
        label.font = Constants.superSmallFont
        return label
    } ()
    
}
