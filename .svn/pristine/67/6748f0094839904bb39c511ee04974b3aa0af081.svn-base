//
//  CPMyOrdersViewController.swift
//  i84cpn
//  我的订单
//  Created by BenjaminRichard on 16/5/24.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPMyOrdersViewController: CMBaseViewController, UnPaidViewDelegate, PaidViewDelegate, UnsubscribedViewDelegate, CanceledViewDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的订单"
        view.addSubview(myOrdersView)
        myOrdersView.scrollView.addSubview(unPaidVC.view)
        myOrdersView.scrollView.addSubview(paidVC.view)
        myOrdersView.scrollView.addSubview(unsubcribedVC.view)
        myOrdersView.scrollView.addSubview(canceledVC.view)

        myOrdersView.frame = view.frame
        
        unPaidVC.view.frame = view.frame
        paidVC.view.frame = view.frame
        paidVC.view.frame.origin.x = view.frame.size.width
        unsubcribedVC.view.frame = view.frame
        unsubcribedVC.view.frame.origin.x = Constants.screenWidth * 2
        canceledVC.view.frame = view.frame
        canceledVC.view.frame.origin.x = Constants.screenWidth * 3
        
        
        unPaidVC.delegate = self
        paidVC.delegate = self
        unsubcribedVC.delegate = self
        canceledVC.delegate = self
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        unPaidVC.getData()
        paidVC.getData()
        unsubcribedVC.getData()
        canceledVC.getData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func popView() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    // 跳转到订单详情页代理函数
    func pushView(index: Int, orderId: Int, status: Int) {
        let vc = CPPaidDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.orderId = orderId
        vc.status = status
    }
    func pushView(index: Int, orderId: Int)  {
        
        switch index {
        case 1:
            let vc = CPUnPaidDetailViewController()
            vc.hideNavi = true
            self.navigationController?.pushViewController(vc, animated: true)
            vc.orderId = orderId
            vc.title = "待付款"
        case 3:
            let vc = CPCanceledDetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            vc.orderId = orderId
            vc.title = "已退订"
        case 4:
            let vc = CPCanceledDetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            vc.orderId = orderId
            vc.title = "已取消"
        default:
            break
        }
    }

    
    private let myOrdersView = CPMyOrdersView()
    
    let unPaidVC: CPUnPaidViewController = {
        let vc = CPUnPaidViewController()
        vc.view.backgroundColor = Constants.paleBGColor
        vc.title = "待付款"
        return vc
    }()
    let paidVC: CPPaidViewController = {
        let vc = CPPaidViewController()
        vc.view.backgroundColor = Constants.paleBGColor
        vc.title = "已付款"
        return vc
    }()
    let unsubcribedVC: CPUnsubscribedViewController = {
        let vc = CPUnsubscribedViewController()
        vc.view.backgroundColor = Constants.paleBGColor
        vc.title = "已退订"
        return vc
    }()
    let canceledVC: CPCanceledViewController = {
        let vc = CPCanceledViewController()
        vc.view.backgroundColor = Constants.paleBGColor
        vc.title = "已取消"
        return vc
    }()
}
