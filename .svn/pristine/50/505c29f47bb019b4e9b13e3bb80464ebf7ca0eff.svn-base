//
//  CPCustomLineView.swift
//  i84cpn
//
//  Created by 周杰 on 16/5/26.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPCustomLineView: UIView,ZHDropDownMenuDelegate {
    var scrollView=UIScrollView()
    var contentView=UIView()
    
    var schoolKey=UILabel()
    var schoolValue=ZHDropDownMenu()
    var gradeKey=UILabel()
    var gradeValue=ZHDropDownMenu()
    var startAddressKey=UILabel()
    var startAddressValue=IQTextView()
    var expectTimeKey=UILabel()
    var expectTimeValue=IQTextView()
    var acceptStationBtn=UIButton()
    var acceptStationLb=UILabel()
    var nearStationKey=UILabel()
    var nearStationValue=ZHDropDownMenu()
    var needBackTripBtn=UIButton()
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        //---------srollView------
        self.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(self).offset(UIEdgeInsetsZero)
        }
        //---------contentView--------
        scrollView.addSubview(contentView)
        contentView.backgroundColor=COLOR_BACKGROUND_GRAY
        contentView.snp_makeConstraints { (make) in
            make.edges.equalTo(scrollView).offset(UIEdgeInsetsZero)
            make.width.equalTo(self.bounds.size.width)
            make.height.equalTo(self.bounds.size.height)
        }
        //-------UIKit---------
        //学校
        contentView.addSubview(schoolKey)
        schoolKey.font=UIFont.systemFontOfSize(14)
        schoolKey.text="您的学校"
        schoolKey.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(HEIGHT_DYNAMIC(30))
            make.left.equalTo(contentView).offset(WIDTH_DYNAMIC(25))
        }
        
//        contentView.addSubview(<#T##view: UIView##UIView#>)
        schoolValue.delegate=self
        gradeValue.delegate=self
        nearStationValue.delegate=self
        
        
        
        //---------contentView.snp_bottom----------
        contentView.snp_updateConstraints { (make) in
//            make.bottom.equalTo(<#T##other: CGFloat##CGFloat#>).offset(<#T##amount: CGFloat##CGFloat#>)
        }
        
    }
 
    //选择完后回调
    func dropDownMenu(menu: ZHDropDownMenu!, didChoose index: Int, dropMenuTag: Int) {
        
    }

    
    //编辑完成后回调
    func dropDownMenu(menu: ZHDropDownMenu!, didInput text: String!) {
        //        print("\(menu) input text \(text)")
    }

}
