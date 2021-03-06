//
//  CPSignUpView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/6.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPSignUpView: UIView, UITextFieldDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        self.addSubview(phoneNumTextField)
        self.addSubview(phoneNumLine)
        self.addSubview(verifyCodeTextField)
        self.addSubview(verifyCodeButton)
        self.addSubview(verifyCodeLine)
        self.addSubview(SMSTextField)
        self.addSubview(SMSButton)
        self.addSubview(SMSLine)
        self.addSubview(passwordTextField)
        self.addSubview(showPasswordButton)
        self.addSubview(tipLabel)
        self.addSubview(signUpButton);
        self.insertSubview(backgroundView, atIndex: 0)
        
        phoneNumTextField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Constants.dPrint(self)
    }
    
    // delegate  当手机号长度为11的时候验证手机号是否可以注册
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let phoneNum = textField.text?.stringByAppendingString(string)
        if phoneNum!.characters.count == 11 && string != "" {
            CPAFHTTPSessionManager.postWithUrlString(Constants.noauthApiURL, parameter: Constants.phoneNumSignUpAbleParamsWithPhoneNum(phoneNum!), progressBlock: { (progress) in
                
                }, successBlock: { (respondData) in
                    let dic:NSDictionary = respondData as! NSDictionary
                    let rsp: Bool = dic["success"] as! Bool
                    if rsp {
                        let objData: NSDictionary = dic["result"] as! NSDictionary
                        if objData.objectForKey("success")  as! Bool {
                            
                        } else {
                            self.phoneNumTextField.text = ""
                            let alertView = UIAlertView(title: "提示", message: objData.objectForKey("msg") as? String, delegate:  self, cancelButtonTitle: "确定")
                            alertView.show()
                        }
                    }
                }, failureBlock: { (error) in
                    print(error)
            })
        } else if phoneNumTextField.text?.characters.count > 11 {
            tipLabel.hidden = false
        }
        
        return true
    }
    
    func setVerifyCodeImage() {
        CPAFHTTPSessionManager.getWithUrlString(Constants.captchaImageURL, parameter: nil, progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let img = UIImage(data: respondData as! NSData)
                self.verifyCodeButton.setBackgroundImage(img, forState: .Normal)
            }, failureBlock: { (error) in
                print(error)
        })
    }
    
//MARK: --布局
    override func layoutSubviews() {
        phoneNumTextField.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(110)
            make.right.equalTo(-20)
        }
        
        phoneNumLine.snp_makeConstraints { (make) in
            make.left.equalTo(phoneNumTextField)
            make.right.equalTo(phoneNumTextField)
            make.top.equalTo(phoneNumTextField.snp_bottom).offset(20)
            make.height.equalTo(1)
        }
        
        verifyCodeTextField.snp_makeConstraints { (make) in
            make.left.equalTo(phoneNumTextField)
            make.top.equalTo(phoneNumLine.snp_bottom).offset(20)
        }
        
        verifyCodeButton.snp_makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(verifyCodeTextField)
            make.left.equalTo(verifyCodeTextField.snp_right).offset(20)
            make.height.equalTo(SMSButton)
            make.width.equalTo(SMSButton)
        }
        
        verifyCodeLine.snp_makeConstraints { (make) in
            make.left.equalTo(verifyCodeTextField.snp_left)
            make.right.equalTo(verifyCodeButton.snp_right)
            make.top.equalTo(verifyCodeTextField.snp_bottom).offset(20)
            make.height.equalTo(1)
        }

        SMSTextField.snp_makeConstraints { (make) in
            make.left.equalTo(phoneNumTextField.snp_left)
            make.top.equalTo(verifyCodeLine.snp_bottom).offset(20)
        }
        
        SMSButton.snp_makeConstraints { (make) in
            make.left.equalTo(verifyCodeButton)
            make.right.equalTo(verifyCodeButton)
            make.centerY.equalTo(SMSTextField)
            make.width.equalTo(120)
            make.height.equalTo(35)
        }
        
        SMSLine.snp_makeConstraints { (make) in
            make.left.equalTo(SMSTextField)
            make.right.equalTo(SMSButton)
            make.top.equalTo(SMSTextField.snp_bottom).offset(20)
            make.height.equalTo(1)
        }
        
        passwordTextField.snp_makeConstraints { (make) in
            make.left.equalTo(phoneNumTextField)
            make.top.equalTo(SMSLine.snp_bottom).offset(20)
            make.right.equalTo(SMSButton.snp_left).offset(-20)
        }
        
        showPasswordButton.snp_makeConstraints { (make) in
            make.top.equalTo(passwordTextField)
            make.right.equalTo(SMSButton)
        }
        
        backgroundView.snp_makeConstraints { (make) in
            make.top.equalTo(phoneNumTextField.snp_top).offset(-20)
            make.bottom.equalTo(passwordTextField.snp_bottom).offset(20)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        tipLabel.snp_makeConstraints { (make) in
            make.top.equalTo(backgroundView.snp_bottom).offset(10)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        signUpButton.snp_makeConstraints { (make) in
            make.left.equalTo(phoneNumTextField)
            make.right.equalTo(SMSButton)
            make.top.equalTo(tipLabel.snp_bottom).offset(10)
        }
    }
    
//MARK: -- 属性
    private let backgroundView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = Constants.whiteBGColor
        return view
    } ()
    
    // 手机号
    let phoneNumTextField: UITextField = {
        let view: UITextField = UITextField()
        view.placeholder = "请输入11位手机号"
        view.font = Constants.smallFont
        view.keyboardType = UIKeyboardType.NamePhonePad
        view.clearButtonMode = UITextFieldViewMode.WhileEditing
        return view
    } ()
    
    private let phoneNumLine: UIView = Constants.splitLine()
    
    //验证码
    let verifyCodeTextField: UITextField = {
        let view: UITextField = UITextField()
        view.placeholder = "请输入右侧验证码"
        view.clearButtonMode = UITextFieldViewMode.WhileEditing
        view.font = Constants.smallFont
        return view
    } ()
    
    let verifyCodeButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.backgroundColor = Constants.paleBGColor
        CPAFHTTPSessionManager.getWithUrlString(Constants.captchaImageURL, parameter: nil, progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let img = UIImage(data: respondData as! NSData)
                btn.setBackgroundImage(img, forState: .Normal)
            }, failureBlock: { (error) in
                print(error)
        })
        return btn
    } ()
    
    private let verifyCodeLine: UIView = Constants.splitLine()
    
    //短信验证码
    let SMSTextField: UITextField = {
        let view: UITextField = UITextField()
        view.placeholder = "请输入短信验证码"
        view.clearButtonMode = UITextFieldViewMode.WhileEditing
        view.font = Constants.smallFont
        return view
    } ()
    
//    let SMSButton: UIButton = {
//        let btn: UIButton = UIButton()
//        btn.titleLabel?.font = Constants.smallFont
//        btn.setTitle("再次获取验证码", forState: .Normal)
//        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5)
//        btn.setTitleColor(Constants.yellowWordColor, forState: .Normal)
//        btn.layer.borderColor = Constants.yellowWordColor.CGColor
//        btn.layer.borderWidth = 1
//        return btn
//    } ()
    
    let SMSButton = CPGetSMSCodeButton()
    
    private let SMSLine: UIView = Constants.splitLine()
    
    //密码
    let passwordTextField: UITextField = {
        let view: UITextField = UITextField()
        view.secureTextEntry = true
        view.font = Constants.smallFont
        view.placeholder = "请输入6位以上密码"
        view.clearButtonMode = UITextFieldViewMode.WhileEditing
        return view
    } ()
    
    let showPasswordButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setImage(UIImage(named: "icon_close"), forState: .Normal)
        return btn
    } ()
    
    // 错误提示
    let tipLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = Constants.redWordColor
        label.text = "输入的手机号少于11位"
        label.textAlignment = NSTextAlignment.Center
        label.hidden = true
        return label
    } ()
    
    // 注册
    let signUpButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setTitle("注   册", forState: .Normal)
        btn.setTitleColor(Constants.whiteWordColor, forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "btn_login_pre"), forState: .Highlighted)
        btn.layer.cornerRadius = 16
        return btn
    } ()
}
