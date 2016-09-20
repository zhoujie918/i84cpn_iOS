//
//  CPMessageRemindingViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/6/6.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPMessageRemindingViewController: CMBaseViewController, MessageListDelegate, MessageRemindingEndLoadDelegate {

    static let shareInstance = CPMessageRemindingViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "消息提醒"
        view.addSubview(messageRemindingView)
        messageRemindingView.frame = view.frame
        msgRemindingModel.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        msgRemindingModel.loadData()
        messageRemindingView.view1.pushDelegate = self
        messageRemindingView.view2.pushDelegate = self
        messageRemindingView.view3.pushDelegate = self
        messageRemindingView.view4.pushDelegate = self
        chooseIndex(index)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        messageRemindingView.view1.pushDelegate = nil
        messageRemindingView.view2.pushDelegate = nil
        messageRemindingView.view3.pushDelegate = nil
        messageRemindingView.view4.pushDelegate = nil
        super.viewWillDisappear(animated)
    }
    
    func loadData(index: Int) {
        messageRemindingView.loadData(msgRemindingModel, index: index)
    }
    /**
     极光通知响应跳转
     
     - parameter index: 跳到第几个页面
     - parameter type:  是否跳转
     */
    func setIndx(index: Int, type: Bool) {
        self.index = index
        chooseType = type
    }
    
    func chooseIndex(index: Int) {
        if chooseType == true {
            messageRemindingView.chooseIndex(index)
            chooseType = false
        }
    }
    
    // delegate
    func pushView(index: Int, cmrId: Int, msgType: Int) {
        if index != 3 {
            let vc = CPMessageRemindingDetailViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.cmrId = cmrId
            vc.msgType = msgType
        } else { // 消息关联
            let vc = CPRelavanceViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.cmrId = cmrId
            vc.msgType = msgType
        }
    }
    
    //MARK: -- 属性
    private lazy var msgRemindingModel = CPMessageRemindingModel()
    var index = 0
    var chooseType = false
    var hideNavi = false
    private let messageRemindingView = CPMessageRemindingView()
}