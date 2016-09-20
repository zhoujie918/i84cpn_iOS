//
//  CPBabiIntroduceView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/11.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPBabiIntroduceView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(titleLine)
        scrollView.addSubview(babiView)
        scrollView.addSubview(introduceLabel)
        scrollView.addSubview(useBibiTitleLabel)
        scrollView.addSubview(useBabiLine)
        scrollView.addSubview(useBabiLabel)
        self.addSubview(scrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        scrollView.frame = self.frame
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(scrollView).offset(20)
            make.top.equalTo(scrollView).offset(30)
        }
        
        titleLine.snp_makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(5)
            make.height.equalTo(1)
        }
        
        babiView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.width.height.equalTo(120)
            make.top.equalTo(titleLine.snp_bottom).offset(20)
        }
        
        introduceLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(babiView.snp_bottom).offset(10)
        }
        
//        useBibiTitleLabel.snp_makeConstraints { (make) in
//            make.top.equalTo(introduceLabel.snp_bottom).offset(50)
//            make.left.right.equalTo(titleLabel)
//        }
//
//        useBabiLine.snp_makeConstraints { (make) in
//            make.left.right.equalTo(titleLabel)
//            make.top.equalTo(useBibiTitleLabel.snp_bottom).offset(15)
//            make.height.equalTo(1)
//        }
        
//        useBabiLabel.snp_makeConstraints { (make) in
//            make.left.equalTo(titleLabel)
//            make.right.equalTo(introduceLabel)
//            make.top.equalTo(introduceLabel.snp_bottom).offset(30)
//        }
//        
        scrollView.contentSize = CGSizeMake(Constants.screenWidth, introduceLabel.frame.origin.y + introduceLabel.frame.height + 80)
    }
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "什么是巴币?"
        return label
    } ()
    
    let titleLine = Constants.splitLine()
    
    let babiView: UIImageView = {
        let view: UIImageView = UIImageView()
        view.image = UIImage(named: "img_busgold")
        return view
    } ()
    
    let introduceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFontOfSize(16)
        var text:NSMutableAttributedString = NSMutableAttributedString(string: "巴币是福建爱巴士网络科技有限公司为答谢广大新老客户长期以来的支持与厚爱而推出的一项客户回馈服务。\n巴币作为5i84平台的虚拟货币，凡是客户通过在5i84平台上购买了服务与产品、参与活动、邀请好友等都将获得巴币。\n用户可以通过登录同学号或巴士门平台，进行巴币查询、折扣购买5i84业务、兑换5i84产品和订购增值服务")
        text.addAttributes([NSForegroundColorAttributeName: Constants.paleWordColor], range: NSMakeRange(0, text.length))

        //设置缩进、行距
        let style = NSMutableParagraphStyle()
        style.headIndent = 0;//缩进
        style.firstLineHeadIndent = 30;
        style.lineSpacing = 11;//行距
        text.addAttributes([NSParagraphStyleAttributeName: style], range: NSMakeRange(0, text.length))
        
        label.attributedText = text
        return label
    } ()
    
    let useBibiTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "淘金币对大家有什么用？"
        return label
    } ()
    
    let useBabiLine = Constants.splitLine()
    
    let useBabiLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFontOfSize(16)
        var text:NSMutableAttributedString = NSMutableAttributedString(string: "巴币作为5i84平台的虚拟货币，凡是客户通过在5i84平台上购买了服务和产品、参与活动、邀请好友等都将")
        text.addAttributes([NSForegroundColorAttributeName: Constants.paleWordColor], range: NSMakeRange(0, text.length))
        
        //设置缩进、行距
        let style = NSMutableParagraphStyle()
        style.headIndent = 0;//缩进
        style.firstLineHeadIndent = 30;
        style.lineSpacing = 11;//行距
        text.addAttributes([NSParagraphStyleAttributeName: style], range: NSMakeRange(0, text.length))
        
        label.attributedText = text
        return label
    } ()
}
