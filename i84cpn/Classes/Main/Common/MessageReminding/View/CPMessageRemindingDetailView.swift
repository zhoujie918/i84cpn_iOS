//
//  CPMessageRemindingDetailView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/6/13.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPMessageRemindingDetailView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        
//        containView.addSubview(imageView)
//        containView.addSubview(titleLabel)
//        containView.addSubview(line)
        containView.addSubview(detailLabel)
        
        self.addSubview(containView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(title: String, content: String) {
        
        
        let attributeString = NSMutableAttributedString(string: content)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 9
        attributeString.addAttributes([NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, content.characters.count))
        detailLabel.attributedText = attributeString
    }
  
    override func layoutSubviews() {
        containView.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.equalTo(self)
            make.bottom.equalTo(detailLabel.snp_bottom).offset(20)
        }
        
//        imageView.snp_makeConstraints { (make) in
//            make.centerY.equalTo(titleLabel)
//            make.right.equalTo(titleLabel.snp_left).offset(-10)
//        }
//        
//        titleLabel.snp_makeConstraints { (make) in
//            make.top.equalTo(containView.snp_top).offset(20)
//            make.centerX.equalTo(self)
//        }
//        
//        line.snp_makeConstraints { (make) in
//            make.top.equalTo(titleLabel.snp_bottom).offset(10)
//            make.left.right.equalTo(self)
//            make.height.equalTo(1)
//        }
        
        detailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(self).offset(-10)
//            make.top.equalTo(line).offset(20)
            make.top.equalTo(containView).offset(20)
        }
    }

    private let containView = Constants.containView()
//    private let imageView: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage(named: "icon_announce")
//        return view
//    } ()
//    
//    private let titleLabel: UILabel = {
//        let view = UILabel()
//        view.font = Constants.mediumFont
//        view.textColor = Constants.blackWordColor
//        return view
//    } ()
//    
//    private let line = Constants.splitLine()
    
    private let detailLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        return view
    } ()
}
