//
//  CPTakeBabiView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/11.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPTakeBabiView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(scrollView)
        scrollView.addSubview(cell1)
        scrollView.addSubview(cellLine1)
        scrollView.addSubview(cell2)
        scrollView.addSubview(cellLine2)
        scrollView.addSubview(cell3)
        scrollView.addSubview(cellLine3)
        scrollView.addSubview(cell4)
        scrollView.addSubview(cellLine4)
        scrollView.addSubview(cell5)
        scrollView.addSubview(cellLine5)
        
        self.backgroundColor = Constants.paleBGColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        scrollView.frame = self.frame
        
        cell1.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(scrollView)
            make.width.equalTo(Constants.screenWidth)
            make.height.equalTo(80)
        }
        cellLine1.snp_makeConstraints { (make) in
            make.left.right.equalTo(cell1)
            make.top.equalTo(cell1.snp_bottom)
            make.height.equalTo(1)
        }
        
        cell2.snp_makeConstraints { (make) in
            make.left.right.equalTo(cell1)
            make.top.equalTo(cellLine1.snp_bottom)
            make.height.equalTo(cell1)
        }
        cellLine2.snp_makeConstraints { (make) in
            make.left.right.equalTo(cell1)
            make.top.equalTo(cell2.snp_bottom)
            make.height.equalTo(1)
        }
        
        cell3.snp_makeConstraints { (make) in
            make.left.right.equalTo(cell1)
            make.top.equalTo(cellLine2.snp_bottom)
            make.height.equalTo(cell1)
        }
        cellLine3.snp_makeConstraints { (make) in
            make.left.right.equalTo(cell1)
            make.top.equalTo(cell3.snp_bottom)
            make.height.equalTo(1)
        }
        
        cell4.snp_makeConstraints { (make) in
            make.left.right.equalTo(cell1)
            make.top.equalTo(cellLine3.snp_bottom)
            make.height.equalTo(cell1)
        }
        cellLine4.snp_makeConstraints { (make) in
            make.left.right.equalTo(cell1)
            make.top.equalTo(cell4.snp_bottom)
            make.height.equalTo(1)
        }
        
        cell5.snp_makeConstraints { (make) in
            make.left.right.equalTo(cell1)
            make.top.equalTo(cellLine4.snp_bottom)
            make.height.equalTo(cell1)
        }
        cellLine5.snp_makeConstraints { (make) in
            make.left.right.equalTo(cell1)
            make.top.equalTo(cell5.snp_bottom)
            make.height.equalTo(1)
        }
        
        scrollView.contentSize = CGSizeMake(Constants.screenWidth, cellLine5.frame.origin.y + 30)
    }
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    let cell1:CPTakeBabiCellView = {
        let view: CPTakeBabiCellView = CPTakeBabiCellView()
        view.setImageName("icon_01", title: "消费返巴币", detail: "购学生专线、商务专线即可返巴币", buttonNormalImageName: "icon_in02", buttonHightLightedImageName: "")
        return view
    } ()
    
    let cellLine1 = Constants.splitLine()
    
    let cell2:CPTakeBabiCellView = {
        let view: CPTakeBabiCellView = CPTakeBabiCellView()
        view.setImageName("icon_02", title: "每日签到领巴币", detail: "每天有10巴币等你拿", buttonNormalImageName: "icon_in02", buttonHightLightedImageName: "")
        return view
    } ()
    
    let cellLine2 = Constants.splitLine()
    
    let cell3:CPTakeBabiCellView = {
        let view: CPTakeBabiCellView = CPTakeBabiCellView()
        view.setImageName("icon_03", title: "邀请好友注册赠巴币", detail: "邀请一个获赠50巴币，暂不上限哦", buttonNormalImageName: "icon_in02", buttonHightLightedImageName: "")
        return view
    } ()
    
    let cellLine3 = Constants.splitLine()
    
    let cell4:CPTakeBabiCellView = {
        let view: CPTakeBabiCellView = CPTakeBabiCellView()
        view.setImageName("icon_04", title: "提建议赚巴币", detail: "5个工作日内建议审核通过即送", buttonNormalImageName: "icon_in02", buttonHightLightedImageName: "")
        return view
    } ()
    
    let cellLine4 = Constants.splitLine()
    
    let cell5:CPTakeBabiCellView = {
        let view: CPTakeBabiCellView = CPTakeBabiCellView()
        view.setImageName("icon_05", title: "商品街花巴币", detail: "前往巴币商品街购买您中意的商品", buttonNormalImageName: "icon_in02", buttonHightLightedImageName: "")
        return view
    } ()
    
    let cellLine5 = Constants.splitLine()
    
}
