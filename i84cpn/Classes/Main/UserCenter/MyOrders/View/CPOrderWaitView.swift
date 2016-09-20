//
//  CPOrderWaitView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/25.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPOrderWaitView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        self.addSubview(imageView)
        self.addSubview(statusLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 显示无数据内容
    func setNotDataView() {
        imageView.image = UIImage(named: "img_null")
        statusLabel.text = "暂无数据"
    }
    
    func setLoadingDataView() {
        imageView.image = UIImage(named: "img_loading")
        statusLabel.text = "数据加载中..."
    }
    
    override func layoutSubviews() {
        imageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(100)
        }
        
        statusLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(self)
            make.top.equalTo(imageView.snp_bottom).offset(20)
        }
    }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_null")
        return view
    } ()
    
    let statusLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = Constants.smallFont
        view.textColor = Constants.blackWordColor
        view.textAlignment = NSTextAlignment.Center
        view.text = "暂无数据"
        return view
    } ()
  }
