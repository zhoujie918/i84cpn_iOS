//
//  CPPasswordChangeViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/12.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPPasswordChangeViewController: CMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "密码修改"
        view.addSubview(passwordChangeView)
        saveButton = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Done, target: self, action: #selector(saveNewPassword))
        self.navigationItem.rightBarButtonItem = saveButton
        passwordChangeView.frame = view.frame
        passwordChangeView.oldPasswordButton.addTarget(self, action: #selector(showOldPassword), forControlEvents: .TouchUpInside)
        passwordChangeView.newPasswordButton.addTarget(self, action: #selector(showNewPassword), forControlEvents: .TouchUpInside)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func saveNewPassword(button: UIBarButtonItem) {
        let oldPassword: String = passwordChangeView.oldPasswordTextField.text!
        let newPassword: String = passwordChangeView.newPasswordTextField.text!
        
        if oldPassword.characters.count > 5 {
            if newPassword.characters.count > 5 {
                passwordChangeView.tipLabel.hidden = true
                CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.changePasswordParamWithOldPassword(oldPassword, newPassword: newPassword), progressBlock: { (progress) in
                    
                    }, successBlock: { (respondData) in
                        let dic:NSDictionary = respondData as! NSDictionary
                        let rsp: Bool = dic["success"] as! Bool
                        if rsp {
                            let objData: NSDictionary = dic["result"] as! NSDictionary
                            let suc: Bool = objData.objectForKey("success") as! Bool
                            let msg: String
                            if suc {
                                
                                let hud = MBProgressHUD.showHUDAddedTo(self.navigationController!.view, animated: true)
                                hud.labelText = "修改成功"
                                self.navigationController?.popViewControllerAnimated(true)
                                hud.hide(true, afterDelay: 0.7)
                            } else {
                                msg = objData.objectForKey("msg") as! String
                                self.alertView = UIAlertView(title: "提示", message: msg, delegate: self, cancelButtonTitle: "确定")
                                self.alertView?.show()
                            }
                        }
                    }, failureBlock: { (error) in
                        print(error)
                })
            } else {
                passwordChangeView.tipLabel.text = "新密码不能少于6位"
                passwordChangeView.tipLabel.hidden = false
            }
        } else {
            passwordChangeView.tipLabel.text = "请确定输入的原密码是否正确"
            passwordChangeView.tipLabel.hidden = false
        }
    }
    
    // MARK: -- 响应方法
    func showOldPassword(button: UIButton) {
        if passwordChangeView.oldPasswordTextField.secureTextEntry {
            passwordChangeView.oldPasswordTextField.secureTextEntry = false
            passwordChangeView.oldPasswordButton.setImage(UIImage(named: "icon_open"), forState: .Normal)
        } else {
            passwordChangeView.oldPasswordTextField.secureTextEntry = true
            passwordChangeView.oldPasswordButton.setImage(UIImage(named: "icon_close"), forState: .Normal)
        }
    }
    
    func showNewPassword(button: UIButton) {
        if passwordChangeView.newPasswordTextField.secureTextEntry {
            passwordChangeView.newPasswordTextField.secureTextEntry = false
            passwordChangeView.newPasswordButton.setImage(UIImage(named: "icon_open"), forState: .Normal)
        } else {
            passwordChangeView.newPasswordTextField.secureTextEntry = true
            passwordChangeView.newPasswordButton.setImage(UIImage(named: "icon_close"), forState: .Normal)
        }
    }
    
    private let passwordChangeView = CPPasswordChangeView()
    private let petNameView = CPPetNameView()
    private var saveButton:UIBarButtonItem?
    private var alertView: UIAlertView?
}
