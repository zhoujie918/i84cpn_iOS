//
//  CPRelavanceViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/6/13.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPRelavanceViewController: CMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(relavanceView)
        relavanceView.frame = view.frame
        title = "关联申请"
        relavanceView.okButton.addTarget(self, action: #selector(agreeRelavance), forControlEvents: .TouchUpInside)
        relavanceView.refuseButton.addTarget(self, action: #selector(refuseRelance), forControlEvents: .TouchUpInside)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // 拒绝2 同意3
    func agreeRelavance(button: UIButton) {
        submitResult(3)
    }
    
    func refuseRelance(button: UIButton) {
        submitResult(2)
    }
    
    func submitResult(msgStatus: Int) {
        let hud = MBProgressHUD.showHUDAddedTo(self.navigationController!.view, animated: true)
        hud.mode = MBProgressHUDMode.Text
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.replyToRelevanceWithCmrId(cmrId, msgStatus: msgStatus), progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    let objData: NSDictionary = dic["result"] as! NSDictionary
                    if objData.objectForKey("success")  as! Bool {
                        hud.labelText = "提交成功"
                        self.navigationController?.popViewControllerAnimated(true)
                    } else {
                        let alertView = UIAlertView(title: "提示", message: objData.objectForKey("msg") as? String, delegate:  self, cancelButtonTitle: "确定")
                        alertView.show()
                    }
                }
                hud.hide(true, afterDelay: 1)
            }, failureBlock: { (error) in
                hud.hide(true, afterDelay: 1)
                print(error)
        })
    }
    
    func loadData() {
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.getMsgRemindingDetailContentWithCmrId(cmrId, msgType: msgType), progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    let objData: NSDictionary = dic["result"] as! NSDictionary
                    if objData.objectForKey("success")  as! Bool {
                        let content = objData.objectForKey("content") as! String
                        let isReadOnly = objData.objectForKey("isReadOnly") as! Bool
                        self.cmrId = objData.objectForKey("cmrId") as! Int
                        self.relavanceView.loadData(isReadOnly, content: content)
                    } else {
                        let alertView = UIAlertView(title: "提示", message: objData.objectForKey("msg") as? String, delegate:  self, cancelButtonTitle: "确定")
                        alertView.show()
                    }
                }
            }, failureBlock: { (error) in
                print(error)
        })
    }
    
    var cmrId = 0
    var msgType = 0
    let relavanceView = CPRelavanceView()
}
