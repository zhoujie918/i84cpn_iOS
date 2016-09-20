//
//  CPChangePhoneNumViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/18.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPChangePhoneNumViewController: CMBaseViewController, GetSMSCodeButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "手机号修改"
        view.addSubview(changeNumView)
        changeNumView.verifyButton.delegate = self
        changeNumView.frame = view.frame
        changeNumView.finishButton.addTarget(self, action: #selector(finish), forControlEvents: .TouchUpInside)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func getSMSCode() {
        let phoneNum: String = changeNumView.phoneTextField.text!
        
        if phoneNum.characters.count == 11 {
            CPAFHTTPSessionManager.postWithUrlString(Constants.getSMSCodeOfNewPhoneNumURL, parameter: Constants.getSMSCodeOfNewPhoneNumParamWithPhoneNum(phoneNum), progressBlock: { (progress) in
                
                }, successBlock: { (respondData) in
                    let dic:NSDictionary = respondData as! NSDictionary
                    if dic.objectForKey("success") as! Bool == true {
                        
                    } else {
                        self.changeNumView.verifyButton.remainingSeconds = 0
                        var msg = dic.objectForKey("msg") as! String
                        if msg == "40001" {
                            msg = "今日短信发送已达上限"
                        } else if msg == "50001" {
                            msg = "短信服务异常"
                        }
                        self.alertView = UIAlertView(title: "提示", message: msg, delegate: self, cancelButtonTitle: "确定")
                        self.alertView?.show()
                    }
                }, failureBlock: { (error) in
                    self.changeNumView.verifyButton.remainingSeconds = 0
                    print(error)
            })
        } else {
            changeNumView.verifyButton.remainingSeconds = 0
            alertView = UIAlertView(title: "提示", message: "请输入新的手机号，并检查手机号是否正确", delegate: self, cancelButtonTitle: "确定")
            alertView?.show()
        }
    }
    
    func finish(button: UIButton) {
        let phoneNum: String = changeNumView.phoneTextField.text!
        let SMSCode: String = changeNumView.verifyTextField.text!
        
        if phoneNum.characters.count == 11 {
            if SMSCode.characters.count != 0 {
                CPAFHTTPSessionManager.postWithUrlString(Constants.changePhoneNumURL, parameter: Constants.changePhoneNumWithNewPhoneNum(phoneNum, SMSCode: SMSCode), progressBlock: { (progress) in
                    
                    }, successBlock: { (respondData) in
                        let dic:NSDictionary = respondData as! NSDictionary
                        let rsp: Bool = dic["success"] as! Bool
                        if rsp {
                            let objData: NSDictionary = dic["result"] as! NSDictionary
                            let suc: Bool = objData.objectForKey("success") as! Bool
                            if suc {
                                CPUserModel.encryptedPhoneNum = self.encrypePhoneNum(phoneNum)
                                let hud = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
                                hud.labelText = "修改成功"
                                self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
                                hud.hide(true, afterDelay: 0.7)
                            } else {
                                if objData.objectForKey("msg") != nil {
                                    self.msg = objData.objectForKey("msg") as? String
                                    
                                } else {
                                    self.msg = "验证码错误"
                                }
                                
                                self.alertView = UIAlertView(title: "提示", message: self.msg, delegate: self, cancelButtonTitle: "确定")
                                self.alertView?.show()
                            }
                        }
                    }, failureBlock: { (error) in
                        print(error)
                })
            }  else {
                alertView = UIAlertView(title: "提示", message: "请输入短信验证码", delegate: self, cancelButtonTitle: "确定")
                alertView?.show()
            }
            
        } else {
            alertView = UIAlertView(title: "提示", message: "请输入新的手机号，并检查手机号是否正确", delegate: self, cancelButtonTitle: "确定")
            alertView?.show()
        }
    }
    
    func encrypePhoneNum(phoneNum: String) -> String {
        var enPhoneNum: String = phoneNum
        enPhoneNum.replaceRange(Range(enPhoneNum.startIndex.advancedBy(3)..<enPhoneNum.startIndex.advancedBy(3+4)), with: "****")
        return phoneNum
    }
    
    private let changeNumView = CPChangeNumView()
    private var alertView: UIAlertView?
    private var msg: String?
}
