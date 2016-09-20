//
//  CPSelectAreaView.swift
//  i84cpn
//  选择地址界面
//  Created by BenjaminRichard on 16/5/13.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPSelectAreaView: CMBaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.clearBlackBGColor
        
        self.addSubview(areaPickerView)
        self.addSubview(containView)
        containView.addSubview(cancelButton)
        containView.addSubview(OKButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        areaPickerView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        containView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(areaPickerView.snp_top)
            make.height.equalTo(35)
        }
        
        cancelButton.snp_makeConstraints { (make) in
            make.left.equalTo(30)
            make.centerY.equalTo(containView)
        }
        
        OKButton.snp_makeConstraints { (make) in
            make.right.equalTo(-30)
            make.centerY.equalTo(cancelButton)
        }
    }

    
    private let containView = Constants.containView()
    
    let cancelButton: UIButton = {
        let view = UIButton()
        view.setTitle("取消", forState: .Normal)
        view.titleLabel?.font = UIFont.systemFontOfSize(13)
        view.setTitleColor(Constants.yellowWordColor, forState: .Normal)
        return view
    } ()
    
    let OKButton: UIButton = {
        let view = UIButton()
        view.setTitle("完成", forState: .Normal)
        view.titleLabel?.font = UIFont.systemFontOfSize(13)
        view.setTitleColor(Constants.yellowWordColor, forState: .Normal)
        return view
    } ()
    
    let areaPickerView: UIPickerView = {
        let view = UIPickerView()
        view.backgroundColor = UIColor.init(white: 0.898, alpha: 1.000)
        return view
    } ()
}
