//
//  CPRealNameViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/12.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPRealNameViewController: CMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "实名认证"
        view.addSubview(realNameView)
        realNameView.frame = view.frame
        validatedView.frame = view.frame
        failView.frame = view.frame
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        realNameView.validateButton.addTarget(self, action: #selector(validation), forControlEvents: .TouchUpInside)
        validatedView.closeButton.addTarget(self, action: #selector(removeValidatedView), forControlEvents: .TouchUpInside)
        failView.closeButton.addTarget(self, action: #selector(removeFailAlertView), forControlEvents: .TouchUpInside)
    }
    
    // 事件响应
    func validation(button: UIButton) {
        let idNo: String = realNameView.certNumTextField.text!
        let name: String = realNameView.nameTextField.text!
        if idNo.characters.count == 18 {
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "验证中..."
            CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.checkCertParamWithIdNo(idNo, name: name), progressBlock: { (progress) in
                
                }, successBlock: { (respondData) in
                    
                    let dic:NSDictionary = respondData as! NSDictionary
                    let rsp: Bool = dic["success"] as! Bool
                    if rsp {
                        let objData: NSDictionary = dic["result"] as! NSDictionary
                        let suc: Bool = objData.objectForKey("success") as! Bool
                        if suc {
                            CPUserModel.authDate = objData.objectForKey("authDate") as? String
                            CPUserModel.idNo = objData.objectForKey("idNo") as? String
                            CPUserModel.realName = (objData.objectForKey("name") as! String)
                            self.validatedView.reloadData()
                            self.view.addSubview(self.validatedView)
                        } else {
                            self.view.addSubview(self.failView)
                        }
                        hud.hide(true)
                    } else {
                        if dic.objectForKey("msg") != nil {
                            hud.labelText = dic.objectForKey("msg") as! String
                            hud.hide(true, afterDelay: 1)
                        } else {
                            hud.hide(true)
                        }
                        if dic.objectForKey("errorCode") != nil {
                            if dic.objectForKey("errorCode") as! String == "00007" {
                                CPUserModel.clearData()
                            }
                        }
                    }
                }, failureBlock: { (error) in
                    print(error)
            })
        } else {
            let alertView = UIAlertView(title: "提示", message: "身份证长度不正确，请重新输入!", delegate: self, cancelButtonTitle: "确定")
            alertView.show()
        }
        
        
    }
    
    func removeFailAlertView(button: UIButton) {
        failView.removeFromSuperview()
    }
    
    func removeValidatedView(button: UIButton) {
        validatedView.removeFromSuperview()
        navigationController?.popViewControllerAnimated(true)
    }
    
    private let realNameView = CPRealNameView()
    private let validatedView = CPValidatedView()
    private let failView = CPRealNameAlertView()
}
