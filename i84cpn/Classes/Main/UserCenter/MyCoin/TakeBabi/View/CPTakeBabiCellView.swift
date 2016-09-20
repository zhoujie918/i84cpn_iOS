//
//  CPTakeBabiCellView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/11.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPTakeBabiCellView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
        self.addSubview(button)
        self.backgroundColor = Constants.whiteBGColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageName(viewName: String, title: String, detail: String, buttonNormalImageName: String, buttonHightLightedImageName: String) {
        imageView.image = UIImage(named: viewName)
        titleLabel.text = title
        detailLabel.text = detail
        button.setBackgroundImage(UIImage(named: buttonNormalImageName), forState: .Normal)
//        button.setBackgroundImage(UIImage(named: buttonHightLightedImageName), forState: .Disabled)
    }
    
    override func layoutSubviews() {
        imageView.snp_makeConstraints { (make) in
            make.left.equalTo(25)
            make.centerY.equalTo(self.snp_centerY)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(imageView.snp_right).offset(15)
            make.top.equalTo(imageView.snp_top).offset(2)
        }
        
        detailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp_left)
            make.top.equalTo(titleLabel.snp_bottom).offset(7)
        }
        
        button.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-20)
        }
    }
    
    let imageView: UIImageView = UIImageView()
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFontOfSize(14)
        return label
    } ()
    
    let detailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFontOfSize(13)
        label.textColor = Constants.paleWordColor
        return label
    } ()
    
    let button: UIButton = UIButton()
}
