//
//  CPFAQsDetailView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/19.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPFAQsDetailView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        
//        self.addSubview(containView)
//        containView.addSubview(titleLabel)
//        containView.addSubview(line)
//        containView.addSubview(detailTextView)
        
        self.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        scrollView.frame = self.frame
        let height = (imageView.image?.size.height)! * Constants.screenWidth / (imageView.image?.size.width)!
        imageView.frame = CGRectMake(0, 10, Constants.screenWidth, height)
        scrollView.contentSize = CGSizeMake(Constants.screenWidth, height + 74)

//        containView.snp_makeConstraints { (make) in
//            make.top.equalTo(80)
//            make.left.right.equalTo(0)
//            make.bottom.equalTo(-30)
//        }
//        
//        titleLabel.snp_makeConstraints { (make) in
//            make.top.left.equalTo(20)
//            make.right.equalTo(-20)
//        }
//        
//        line.snp_makeConstraints { (make) in
//            make.left.right.equalTo(titleLabel)
//            make.top.equalTo(titleLabel.snp_bottom).offset(20)
//            make.height.equalTo(1)
//        }
//        
//        detailTextView.snp_makeConstraints { (make) in
//            make.left.right.equalTo(titleLabel)
//            make.top.equalTo(line).offset(20)
//            make.bottom.equalTo(-20)
//        }
    }

    private let scrollView = UIScrollView()
    let imageView = UIImageView()
    
//    private let containView = Constants.containView()
//    private let titleLabel: UILabel = {
//        let view = UILabel()
//        view.text = "关于退款"
//        return view
//    } ()
//    
//    private let line = Constants.splitLine()
//    private let detailTextView: UITextView = {
//        let view = UITextView()
//        var text:NSMutableAttributedString = NSMutableAttributedString(string: "1、退款政策\n（1）对于已接受预付款的用户，至预订周期开行前5日，应用户要求可退款，退款需支付预退款15%的手续费。\n（2）由于不可抗力影响或运营商原因，造成定制公交行驶路线调整或撤销，使乘客无法实现乘车目的，可全额退款还剩余日的款项。\n（3）由于用户原因，在已开行运营周期内无法继续乘坐的，不接受退款。\n2、退款流程\n（1）用户可拨打\"5i84\"客服电话：400-888-5284申请退款；\n（2）\"5i84\"平台审核通过后，系统将通过短信向用户发送所在订单的退款信息；\n（3）用户凭退款短信至用户与运营方约定的时间和地点领取。")
//        text.addAttributes([NSForegroundColorAttributeName: Constants.paleWordColor], range: NSMakeRange(0, text.length))
//        //设置缩进、行距
//        let style = NSMutableParagraphStyle()
//        style.headIndent = 0;//缩进
//        style.lineSpacing = 11;//行距
//        text.addAttributes([NSParagraphStyleAttributeName: style], range: NSMakeRange(0, text.length))
//        
//        view.attributedText = text
//        view.font = UIFont.systemFontOfSize(16)
//        return view
//    } ()
}
