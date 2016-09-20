//
//  CPPaidDetailViewController.swift
//  i84cpn
//
//  Created by Benjamin on 16/5/28.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit


class CPPaidDetailViewController: CMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "已付款"
        
        view.addSubview(paidDetailView)
        
        paidDetailView.frame = view.frame
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        getData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        paidDetailView.scrollView.contentSize = CGSizeMake(Constants.screenWidth, paidDetailView.unsubscribeButton.frame.origin.y + paidDetailView.unsubscribeButton.frame.height + 100)
        paidDetailView.selectSeatButton.addTarget(self, action: #selector(selectSeat), forControlEvents: .TouchUpInside)
        paidDetailView.repayCardButton.addTarget(self, action: #selector(rePayCard), forControlEvents: .TouchUpInside)
        paidDetailView.endorseButton.addTarget(self, action: #selector(endorse), forControlEvents: .TouchUpInside)
        paidDetailView.unsubscribeButton.addTarget(self, action: #selector(unsubscribe), forControlEvents: .TouchUpInside)
        
        // 退订
        unsubscribedAlertView.submitButton.addTarget(self, action: #selector(unsubscribeSubmit), forControlEvents: .TouchUpInside)
        unsubscribedAlertView.closeButton.addTarget(self, action: #selector(closeUnsubscribeAlertView), forControlEvents: .TouchUpInside)
        
        succView.closeButton.addTarget(self, action: #selector(closeSucView), forControlEvents: .TouchUpInside)
        
        // 补卡
        rePayCardView.payButton.addTarget(self, action: #selector(rePayCardSubmit), forControlEvents: .TouchUpInside)
        rePayCardView.closeButton.addTarget(self, action: #selector(closeRePayCardView), forControlEvents: .TouchUpInside)
    }
    
    
    // 主页面事件响应
    // 选座
    func selectSeat(button: UIButton) {
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.seatInitWithLineId(self.lineId, classId: self.classId), progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    let objData: NSDictionary = dic["result"] as! NSDictionary
                    let seatVC = CPChooseSeatController()
                    seatVC.dicData = objData as [NSObject : AnyObject]
                    seatVC.dicParam = ["lineId":self.lineId,"classesId":self.classId,"orderNo":self.orderNo!]
                    self.navigationController?.pushViewController(seatVC, animated: true)
                } else {
                    print(dic)
                }
        }) { (error) in
            print(error)
        }
        
//        let seatVC = CPChooseSeatController()
////        seatVC.dicData = 
//        self.navigationController?.pushViewController(seatVC, animated: true)
    }
    
    // 补卡
    func rePayCard(button: UIButton) {
        view.addSubview(rePayCardView)
        rePayCardView.frame = view.frame
        rePayCardView.getAddressList()
    }
    // 改签
    func endorse(button: UIButton) {
        let vc = CPHomePageController()
        navigationController?.pushViewController(vc, animated: true)
        vc.orgOrderId = orderId
        vc.comId = comId
    }
    
    // 退订
    func unsubscribe(button: UIButton) {
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.getUnsubscribedInfo(orderId), progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    var objData: NSDictionary = dic["result"] as! NSDictionary
                    objData = objData.objectForKey("obj") as! NSDictionary
                    self.refundData = objData
                    self.unsubscribedAlertView.reloadData(objData)
                } else {
                    print(dic)
                }
            }) { (error) in
                print(error)
        }
        
        unsubscribedAlertView.frame = view.frame
        view.addSubview(unsubscribedAlertView)
    }
    
    // 弹出页面事件响应
    // 确认退订
    func unsubscribeSubmit(button: UIButton) {
        unsubscribedAlertView.removeFromSuperview()
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.refundApply(orderId), progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    let objData: NSDictionary = dic["result"] as! NSDictionary
                    if objData.objectForKey("success") as! Bool {
                        self.succView.setDetailLabel(self.refundData!.objectForKey("refundAmout") as! String)
                        self.view.addSubview(self.succView)
                        self.succView.frame = self.view.frame
                    } else {
                        let alertView = UIAlertView(title: "提示", message: objData.objectForKey("msg") as? String, delegate:  self, cancelButtonTitle: "确定")
                        alertView.show()
                    }
                }
        }) { (error) in
            print(error)
        }
    }
    
    func closeUnsubscribeAlertView(button: UIButton) {
        unsubscribedAlertView.removeFromSuperview()
        navigationController?.popViewControllerAnimated(true)
    }
    
    func closeSucView(button: UIButton) {
        succView.removeFromSuperview()
    }
    
    // 补卡支付
    func rePayCardSubmit(button: UIButton) {
        rePayCardView.removeFromSuperview()
        let payType = rePayCardView.getPayType()
        let addressId = rePayCardView.getAddressId()
        
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.rePayCardWithOrderId(orderId, uasId: addressId), progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    var objData: NSDictionary = dic["result"] as! NSDictionary
                    if objData.objectForKey("success") as! Bool {
                        objData = objData.objectForKey("obj") as! NSDictionary
//                        let orderState = objData.objectForKey("orderState") as! String
                        print(objData)
                        if payType == 0 {
                            //支付参数 （lineId,classId为后续选座接口备用,必传）
                            let param:NSDictionary = ["action":"pay_alipay","orderNo":objData.objectForKey("reissuecardNo")!,"sysType":"IOS","orderType":"3","lineId":"","classId":""]
                            
                            //创建支付宝支付Model单例
                            let alipayModel = CPAlipayModel.shareCPAlipayModel()
                            alipayModel.setValuesForKeysWithDictionary(param as! [String : AnyObject])
                            
                            //调起支付模块
                            
                            [alipayModel.alipaySuccessBlock({ (responseObject) in
                                self.alipaySuccess()
                                
                                }, failureBlock: { (error) in
                                    print(error)
                                    self.alipayFail()
                            })];
                        } else {
                            print("跳转到微信支付")
                        }
                    } else {
                        print(objData)
                    }
                }
            }, failureBlock: { (error) in
                print(error)
        })
    }
    
    //支付成功
    func alipaySuccess() {
        print("支付成功")
        let payVC = CPPayResultController()
        self.navigationController?.pushViewController(payVC, animated: true)
    }
    
    //支付失败
    func alipayFail() {
        print("支付失败")
        let payFailVC = CPPayFailResultController()
        self.navigationController?.pushViewController(payFailVC, animated: true)
    }
    
    func closeRePayCardView(button: UIButton) {
        rePayCardView.removeFromSuperview()
    }
    
    func getData() {
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.getOrderDetail(orderId), progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    var objData: NSDictionary = dic["result"] as! NSDictionary
                    objData = objData.objectForKey("result") as! NSDictionary
                    
                    self.comId = objData.objectForKey("comId") as! Int
                    let s: NSArray = objData.objectForKey("lineList") as! NSArray
                    if s.count == 1 {
                        self.lineDetailData = objData
                        let ar: NSArray = objData.objectForKey("lineList") as! NSArray
                        self.classId = ar[0].objectForKey("classId") as! Int
                        self.lineId = ar[0].objectForKey("lineId") as! Int
                        self.issueId = ar[0].objectForKey("issueId") as! Int
                        self.orderNo = objData.objectForKey("orderNo") as? String
                        if self.status == 1 {
                            self.paidDetailView.unsubscribeButton.hidden = false
                        } else {
                            self.paidDetailView.unsubscribeButton.hidden = true
                            self.paidDetailView.endorseButton.hidden = true
                        }
                        self.paidDetailView.reloadData(objData)
                    } else {
                        
                    }
                } else {
                    let alertView = UIAlertView(title: "提示", message: dic.objectForKey("msg") as? String, delegate: self, cancelButtonTitle: "确定")
                    alertView.show()
                }
            }, failureBlock: { (error) in
                print(error)
        })
    }
    
    
    //MARK:-- 属性
    var orderId:Int = 0
    var status: Int = 0
    private var comId = 0 // 企业ID
    private var orderNo: String?
    private var issueId: Int = 0
    private var lineId: Int = 0
    private var classId:Int = 0
    
    private var seatData:NSDictionary?
    private var lineDetailData:NSDictionary?
    private var refundData: NSDictionary?
    private let paidDetailView = CPPaidDetailView()
    private let unsubscribedAlertView = CPUnsubscribedAlertView()
    private let succView = CPRefundSucView()
    private let rePayCardView = CPRePayCardView()
}
