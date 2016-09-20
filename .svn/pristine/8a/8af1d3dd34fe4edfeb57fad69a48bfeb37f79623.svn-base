//
//  CPRelavanceTableViewCell.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/6/13.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPRelavanceTableViewCell: UITableViewCell {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
        self.addSubview(stateLabel)
    }
    
    func loadData(content:String, createTime:String, status:Int, statusMsg:String, isRead:Bool) {
        titleLabel.text = content
        detailLabel.text = createTime
        stateLabel.text = statusMsg
        if statusMsg == "" {
            stateLabel.snp_remakeConstraints(closure: { (make) in
                make.centerY.equalTo(self)
                make.width.equalTo(0)
                make.height.equalTo(25)
                make.right.equalTo(self).offset(-20)
            })
        } else {
            stateLabel.snp_remakeConstraints(closure: { (make) in
                make.centerY.equalTo(self)
                make.width.equalTo(50)
                make.height.equalTo(25)
                make.right.equalTo(self).offset(-20)
            })
        }
        if isRead == false { // 未读
            titleLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 15)
        } else {
            titleLabel.font = Constants.mediumFont
        }
    }
    
    override func layoutSubviews() {
        titleLabel.snp_makeConstraints { (make) in
            make.top.left.equalTo(20)
            make.right.equalTo(stateLabel.snp_left).offset(-10)
        }
        
        detailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(8)
            make.right.equalTo(stateLabel.snp_left).offset(-10)
        }
        
        
    }
    
    
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.mediumFont
        view.numberOfLines = 0
        return view
    } ()
    
    let detailLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        return view
    } ()
    
    let stateLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.paleWordColor
        view.textAlignment = NSTextAlignment.Center
        view.font = Constants.smallFont
        view.textColor = Constants.yellowWordColor
        view.layer.borderColor = Constants.yellowWordColor.CGColor
        view.layer.borderWidth = 1
        return view
    } ()
}
