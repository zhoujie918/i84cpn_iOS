//
//  CPRelevancePassengerRideInfoPushViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/24.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPRelevancePassengerRideInfoPushViewController: CMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "关联乘客乘车信息推送"
        view.addSubview(relevancePassengerRideInfoView)
        relevancePassengerRideInfoView.frame = view.frame
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        relevancePassengerRideInfoView.submitButton.addTarget(self, action: #selector(submit), forControlEvents: .TouchUpInside)
        relevancePassengerRideInfoView.historyButton.addTarget(self, action: #selector(historyAction), forControlEvents: .TouchUpInside)
    }
    
    // 事件响应
    func submit(button: UIButton) {
        let phoneNum = relevancePassengerRideInfoView.phoneNumTextField.text
        let name = relevancePassengerRideInfoView.nameTextField.text
//        let cardId = relevancePassengerRideInfoView.cardNumTextField.text
        
        if phoneNum?.characters.count == 0 || name?.characters.count == 0  {
            let alertView = UIAlertView(title: "提示", message: "请填写完整信息", delegate: self, cancelButtonTitle: "确定")
            alertView.show()
        } else {
            let hud = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "关联申请中..."
            CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.relevancePassengerInfoWithPhoneNum(phoneNum!, psgName: name!), progressBlock: { (progress) in
                
                }, successBlock: { (respondData) in
                    var dic:NSDictionary = respondData as! NSDictionary
                    let rsp: Bool = dic["success"] as! Bool
                    if rsp {
                        dic = dic["result"] as! NSDictionary
                        if dic.objectForKey("success") as! Bool {
                            hud.labelText = "关联成功"
                            self.navigationController?.popViewControllerAnimated(true)
                            hud.hide(true, afterDelay: 1)
                        } else {
                            hud.labelText = dic.objectForKey("msg") as? String
                            hud.hide(false, afterDelay: 2)
                        }
                    } else {
                        hud.hide(false)
                        let errorCode = dic.objectForKey("errorCode") as? String
                        if errorCode == "00001" {
                            CPUserModel.clearData()
                            CPUserModel.userLogin()
                        }
                    }
                }, failureBlock: { (error) in
                    print(error)
            })
        }
    }
    
    func historyAction(button: UIButton) {
        let vc = CPHistoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private let relevancePassengerRideInfoView = CPRelevancePassengerRideInfoPushView()
}
