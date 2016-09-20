//
//  CPAddressManageTableViewCell.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/16.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPAddressManageTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(addressLabel)
        self.addSubview(defaultImage)
        self.addSubview(defaultTipLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        addressLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(30)
            make.right.equalTo(defaultImage.snp_left).offset(-30)
        }
        
        defaultImage.snp_makeConstraints { (make) in
            make.centerY.equalTo(addressLabel)
            make.right.equalTo(defaultTipLabel.snp_left).offset(-10)
            make.width.height.equalTo(25)
        }
        
        defaultTipLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(addressLabel)
            make.right.equalTo(-20)
            make.width.equalTo(60)
        }
    }

    // 设置
    func setPropertyWithAddress(address: String, isDefault: Bool) {
        let text:NSMutableAttributedString = NSMutableAttributedString(string: address)
        
        //设置行距
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9;//行距
        text.addAttributes([NSParagraphStyleAttributeName: style], range: NSMakeRange(0, text.length))
        
        addressLabel.attributedText = text
        setDefaultButtonImage(isDefault)
    }
    
    // 设置图片
    func setDefaultButtonImage(def: Bool) {
        if def {
            defaultImage.image = UIImage(named: "icon_sel")
            defaultTipLabel.text = "默认地址"
            defaultTipLabel.textColor = Constants.yellowWordColor
        } else {
            defaultImage.image = UIImage(named: "icon_unsel")
            defaultTipLabel.textColor = Constants.paleWordColor
            defaultTipLabel.text = "设为默认"
        }
        
    }
    // 属性
    private let addressLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = Constants.mediumFont
        return view
    } ()
    
    private let defaultImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_unsel")
        return view
    } ()
    
    private let defaultTipLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.paleWordColor
        view.font = Constants.mediumFont
        view.text = "设为默认"
        return view
    } ()
}
