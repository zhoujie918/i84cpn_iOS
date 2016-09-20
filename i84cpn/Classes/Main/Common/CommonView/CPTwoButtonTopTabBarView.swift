//
//  CPTwoButtonTopTabBarView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/6/14.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPTwoButtonTopTabBarView: UIView, UIScrollViewDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        
        containView.addSubview(bottonLine)
        containView.addSubview(button1)
        containView.addSubview(line1)
        containView.addSubview(button2)
        
        self.addSubview(containView)
        self.addSubview(scrollView)
        scrollView.delegate = self
        
        button1.addTarget(self, action: #selector(clickButton), forControlEvents: .TouchUpInside)
        button2.addTarget(self, action: #selector(clickButton), forControlEvents: .TouchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getIndex() -> Int {
        return selectedIndex
    }
    
    func clickButton(button: UIButton) {
        scrollView.setContentOffset(CGPoint(x: Constants.screenWidth * CGFloat(button.tag), y: 0), animated: true)
        
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        changeSelectedButtonByIndex(Int(scrollView.contentOffset.x / scrollView.frame.width))
    }
    
    func changeSelectedButtonByIndex(index: Int) {
        if index != selectedIndex {
            switch selectedIndex {
            case 0:
                button1.setTitleColor(Constants.blackWordColor, forState: .Normal)
            case 1:
                button2.setTitleColor(Constants.blackWordColor, forState: .Normal)
            default:
                break
            }
            selectedIndex = index
            switch selectedIndex {
            case 0:
                button1.setTitleColor(Constants.yellowWordColor, forState: .Normal)
            case 1:
                button2.setTitleColor(Constants.yellowWordColor, forState: .Normal)
            default:
                break
            }
            
            UIView.beginAnimations(nil, context: nil)
            bottonLine.frame.origin.x = buttonWidth * CGFloat(selectedIndex)
            
            UIView.commitAnimations()
        }
    }
    
    override func layoutSubviews() {
        containView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(button1)
        }
        
        button1.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(containView)
            make.width.equalTo(buttonWidth)
            make.height.equalTo(35)
        }
//        line1.snp_makeConstraints { (make) in
//            make.left.equalTo(button1.snp_right)
//            make.top.bottom.equalTo(button1)
//            make.width.equalTo(1)
//            
//        }
        bottonLine.snp_makeConstraints { (make) in
            make.width.equalTo(buttonWidth)
            make.top.equalTo(button1.snp_bottom)
            make.height.equalTo(1)
            make.left.equalTo(button1)
        }
        
        button2.snp_makeConstraints { (make) in
            make.left.equalTo(button1.snp_right)
            make.top.equalTo(button1)
            make.width.equalTo(buttonWidth)
            make.height.equalTo(button1)
        }
        
        scrollView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(containView.snp_bottom).offset(15)
            make.bottom.equalTo(0)
        }
        scrollView.contentSize = CGSizeMake(Constants.screenWidth * 2, scrollView.frame.height - 80)
    }
    
    
    //MARK: --属性
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.pagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    
    private var selectedIndex = 0;
    private let buttonWidth = (Constants.screenWidth - 1) / 2
    private var bottonLine: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.yellowWordColor
        return view
    } ()
    private let containView = Constants.containView()
    let button1: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = Constants.mediumFont
        view.setTitleColor(Constants.yellowWordColor, forState: .Normal)
        view.tag = 0
        return view
    } ()
    private let line1 = Constants.splitLine()
    
    let button2: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = Constants.mediumFont
        view.setTitleColor(Constants.blackWordColor, forState: .Normal)
        view.tag = 1
        return view
    } ()
 
}
