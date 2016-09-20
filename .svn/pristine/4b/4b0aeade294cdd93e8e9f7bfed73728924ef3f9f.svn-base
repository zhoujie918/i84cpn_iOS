//
//  CPMessageRemindingView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/6/6.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPMessageRemindingView: CPTopTabBarView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonTitle()
        scrollView.addSubview(view1)
        scrollView.addSubview(view2)
        scrollView.addSubview(view3)
        scrollView.addSubview(view4)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(model: CPMessageRemindingModel, index: Int) {
        switch index {
        case 0:
            if model.list1.count != 0 {
                view1.loadData(model.list1)
            } else {
                let statusView = CPStatusView()
                statusView.frame = self.frame
                view1.addSubview(statusView)
            }
        case 1:
            if model.list2.count != 0 {
                view2.loadData(model.list2)
            } else {
                let statusView = CPStatusView()
                statusView.frame = self.frame
                view2.addSubview(statusView)
            }
        case 2:
            if model.list3.count != 0 {
                view3.loadData(model.list3)
            } else {
                let statusView = CPStatusView()
                statusView.frame = self.frame
                view3.addSubview(statusView)
            }
        case 3:
            if model.list4.count != 0 {
                view4.loadData(model.list4)
            } else {
                let statusView = CPStatusView()
                statusView.frame = self.frame
                view4.addSubview(statusView)
            }
        default:
            break
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view1.frame = CGRectMake(0, 0, Constants.screenWidth, Constants.screenHeight)
        view2.frame = view1.frame
        view3.frame = view1.frame
        view4.frame = view1.frame
        view2.frame.origin.x = Constants.screenWidth
        view3.frame.origin.x = Constants.screenWidth * 2
        view4.frame.origin.x = Constants.screenWidth * 3
    }
    
    func setButtonTitle() {
        button1.setTitle("上下车消息", forState: .Normal)
        button2.setTitle("改道消息", forState: .Normal)
        button3.setTitle("换车消息", forState: .Normal)
        button4.setTitle("关联申请", forState: .Normal)
    }
    
//    // MARK: -- 属性
    let view1: CPMessageListView = {
        let view = CPMessageListView()
        return view
    } ()
    let view2: CPMessageListView = {
        let view = CPMessageListView()
        return view
    } ()
    let view3: CPMessageListView = {
        let view = CPMessageListView()
        return view
    } ()
    let view4: CPMessageListView = {
        let view = CPMessageListView()
        view.index = 3
        return view
    } ()
}
