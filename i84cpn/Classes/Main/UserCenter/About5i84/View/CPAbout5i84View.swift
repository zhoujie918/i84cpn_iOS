//
//  CPAbout5i84View.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/19.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPAbout5i84View: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        self.addSubview(scrollView)
        self.addSubview(copyRightLabel)
        
        scrollView.addSubview(logoImage)
        scrollView.addSubview(versionLabel)
        scrollView.addSubview(codeImage)
        scrollView.addSubview(codeLabel)
        scrollView.addSubview(containView)
        containView.addSubview(titleLabel)
        containView.addSubview(line)
        containView.addSubview(detailLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        scrollView.frame = self.frame
        
        logoImage.snp_makeConstraints { (make) in
            make.top.equalTo(50)
            make.width.height.equalTo(80)
            make.right.equalTo(codeImage.snp_left).offset(-60)
        }
        
        versionLabel.snp_makeConstraints { (make) in
            make.left.equalTo(logoImage)
            make.top.equalTo(logoImage.snp_bottom).offset(15)
        }
        
        codeImage.snp_makeConstraints { (make) in
            make.top.equalTo(50)
            make.width.height.equalTo(80)
            make.left.equalTo(Constants.screenWidth / 2 + 30)
        }
        
        codeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(codeImage)
            make.top.equalTo(codeImage.snp_bottom).offset(15)
        }
        
        containView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.width.equalTo(Constants.screenWidth)
            make.top.equalTo(versionLabel.snp_bottom).offset(30)
            make.bottom.equalTo(detailLabel.snp_bottom).offset(30)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.equalTo(0)
            make.right.equalTo(0)
        }
        
        line.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(titleLabel.snp_bottom).offset(20)
            make.height.equalTo(1)
        }
        
        detailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.equalTo(Constants.screenWidth - 15 * 2)
            make.top.equalTo(line).offset(20)
        }
        
        copyRightLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(containView.snp_bottom).offset(20)
        }
        
        scrollView.contentSize = CGSizeMake(Constants.screenWidth, copyRightLabel.frame.height + copyRightLabel.frame.origin.y + 80)
    }
    
    private let logoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "5i84_logo")
        return view
    } ()
    
    private let versionLabel: UILabel = {
        let view = UILabel()
        view.text = "同学号 v1.0"
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        return view
    } ()
    
    private let codeImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_code")
        return view
    } ()
    
    private let codeLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.text = "扫码下载同学号"
        view.textColor = Constants.paleWordColor
        return view
    } ()
    
    let scrollView: UIScrollView = {
        let view: UIScrollView = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.scrollEnabled = true
        return view
    } ()
    
    private let containView = Constants.containView()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "同学号，承载爱心，驱动未来"
        view.textAlignment = NSTextAlignment.Center
        return view
    } ()
    
    private let line = Constants.splitLine()
    
    private let detailLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        
        var text:NSMutableAttributedString = NSMutableAttributedString(string: "“同学号”是福建爱巴士网络科技有限公司研发的首个数字化校车整体服务平台。我们与国内最优秀的巴士运输企业合作，秉承着“用教育的理念经营校车”，利用先进的互联网技术，重新诠释校车出行，解决了家长接送子女的出行难题，为学生安全出行保驾护航。\n“同学号”实现校车预订和线路征集功能，增加学生上下车信息推送、车辆实时位置查询等安全闭环功能，解决了传统校车的安全弊端，实现了一人一座、舒适直达。 ")
        
        text.addAttributes([NSForegroundColorAttributeName: Constants.paleWordColor], range: NSMakeRange(0, text.length))
        //设置缩进、行距
        let style = NSMutableParagraphStyle()
        style.headIndent = 0;//缩进
        style.firstLineHeadIndent = 20;
        style.lineSpacing = 12;//行距
        text.addAttributes([NSParagraphStyleAttributeName: style], range: NSMakeRange(0, text.length))
        
        view.attributedText = text
        return view
    } ()
    
    private let copyRightLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.paleWordColor
        view.textAlignment = .Center
        view.font = Constants.superSmallFont
        view.text = "Copyright©2014-2016福建爱巴士网络科技有限公司版权所有"
        return view
    } ()
}
