//
//  CPCanceledDetailViewController.swift
//  i84cpn
//
//  Created by 杰伦 on 16/5/26.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPCanceledDetailViewController: CMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(canceledDetailView)
        canceledDetailView.frame = view.frame
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        canceledDetailView.lookNewButton.addTarget(self, action: #selector(lookLineDetail), forControlEvents: .TouchUpInside)
    }
    
    
    // 事件响应
    // 线路详情
    func lookLineDetail(button: UIButton) {
        let vc = CPLineInfoController()

        self.navigationController?.pushViewController(vc, animated: true)
        let lineInfoDicW: NSMutableDictionary = ["action": "line_detail", "issueId": issueId, "classesId": classId, "lineId": lineId, "isSolicit": "0"]
        vc.lineInfoDicW = lineInfoDicW
    }
    
    func getData() {
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.getOrderDetail(orderId), progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    var objData: NSDictionary = dic["result"] as! NSDictionary
                    objData = objData.objectForKey("result") as! NSDictionary
                    let s: NSArray = objData.objectForKey("lineList") as! NSArray
                    if s.count == 1 {
                        self.lineDetailData = objData
                        let ar: NSArray = objData.objectForKey("lineList") as! NSArray
                        self.classId = ar[0].objectForKey("classId") as! Int
                        self.lineId = ar[0].objectForKey("lineId") as! Int
                        self.issueId = ar[0].objectForKey("issueId") as! Int
                        self.canceledDetailView.reloadData(objData)
                    } else {
                        
                    }
                }else {
                    let alertView = UIAlertView(title: "提示", message: dic.objectForKey("msg") as? String, delegate: self, cancelButtonTitle: "确定")
                    alertView.show()
                }
            }, failureBlock: { (error) in
                print(error)
        })
    }
    
    // MARK:-- 属性
    var orderId:Int = 0
    
    private var issueId: Int = 0
    private var lineId: Int = 0
    private var classId:Int = 0
    
    var lineDetailData:NSDictionary?
    let canceledDetailView = CPCanceledView()
}