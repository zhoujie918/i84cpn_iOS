//
//  CPLoginView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/6.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPLoginView: UIView, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.whiteBGColor
        self.addSubview(logoView)
        self.addSubview(phoneNumView)
        self.addSubview(phoneNumTextField)
        self.addSubview(phoneNumLine)
        self.addSubview(phoneNumTableView)
        self.addSubview(lockView)
        self.addSubview(passwordTextField)
        self.addSubview(passwordLine)
        self.addSubview(tipLabel)
        self.addSubview(loginButton)
        self.addSubview(signUpButton)
        self.addSubview(forgetButton)
        
        phoneNumTextField.delegate = self
        phoneNumTableView.dataSource = self
        phoneNumTableView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // delegate
    func textFieldDidBeginEditing(textField: UITextField) {
        if acountArray != nil && acountArray.count > 0 {
            IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = tableViewHeight
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 10
        phoneNumTableView.hidden = true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //获取输入的字符串
        var account = textField.text;
        account = account?.stringByAppendingString(string)
        self.actString = account;
        if string == "" { //判断是否是退各符
            account = account?.substringToIndex(account!.endIndex.advancedBy(-1))
        }
        self.actString = account
        matchArray.removeAll()
        if acountArray != nil {
            for act in acountArray {
                let actStr = act["acct"] as! String
                let st = actStr.rangeOfString(actString!)?.startIndex
                if st != nil && st == actStr.startIndex {
                    matchArray.append(actStr)
                }
            }
        }
        if matchArray.count > 0 {
            phoneNumTableView.hidden = false
            self.bringSubviewToFront(phoneNumTableView)
        } else {
            phoneNumTableView.hidden = true
        }
        
        //重新加载数据
        phoneNumTableView.reloadData()
        return true
    }
    
    // tableview delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        phoneNumTextField.text = matchArray[indexPath.row]
        tableView.hidden = true
    }
    
    // tableview datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = matchArray[indexPath.row]
        return cell
    }
    
    private let tableViewHeight: CGFloat = 150
    private let acountArray = SSKeychain.accountsForService(Constants.keychainServerName)
    private var matchArray = Array<String>()
    private var actString: String?
    //MARK: --布局
    override func layoutSubviews()  {
        // 6s 6p
        if Constants.screenHeight > 640 {
            logoView.snp_makeConstraints { (make) in
                make.top.equalTo(self).offset(60)
                make.centerX.equalTo(self)
                make.left.equalTo(115)
                make.right.equalTo(-115)
            }
            
            phoneNumView.snp_makeConstraints { (make) in
                make.centerY.equalTo(self).offset(-40)
                make.left.equalTo(30)
                make.width.equalTo(20)
                make.height.equalTo(32)
            }
            
            phoneNumTextField.snp_makeConstraints { (make) in
                make.left.equalTo(phoneNumView.snp_right).offset(25)
                make.top.equalTo(phoneNumView)
                make.height.equalTo(phoneNumView)
                make.right.equalTo(-30)
            }
            
            phoneNumLine.snp_makeConstraints { (make) in
                make.left.equalTo(phoneNumTextField)
                make.right.equalTo(phoneNumTextField)
                make.top.equalTo(phoneNumTextField.snp_bottom)
                make.height.equalTo(1)
            }
            
            phoneNumTableView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(phoneNumLine.snp_bottom)
                make.left.right.equalTo(phoneNumTextField)
                make.height.equalTo(tableViewHeight)
            })
            
            lockView.snp_makeConstraints { (make) in
                make.left.equalTo(phoneNumView)
                make.top.equalTo(phoneNumLine).offset(40)
                make.width.height.equalTo(phoneNumView)
            }
            
            passwordTextField.snp_makeConstraints { (make) in
                make.left.equalTo(lockView.snp_right).offset(25)
                make.top.equalTo(lockView)
                make.right.equalTo(-30)
                make.width.height.equalTo(phoneNumTextField)
            }
            
            passwordLine.snp_makeConstraints { (make) in
                make.left.equalTo(passwordTextField)
                make.right.equalTo(passwordTextField)
                make.top.equalTo(passwordTextField.snp_bottom)
                make.height.equalTo(1)
            }
            
            tipLabel.snp_makeConstraints { (make) in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.top.equalTo(lockView.snp_bottom).offset(20)
            }
            
            loginButton.snp_makeConstraints { (make) in
                make.left.equalTo(30)
                make.top.equalTo(tipLabel.snp_bottom).offset(20)
                make.right.equalTo(-30)
                make.height.equalTo(40)
            }
            
            signUpButton.snp_makeConstraints { (make) in
                make.left.equalTo(50)
                make.top.equalTo(loginButton.snp_bottom).offset(40)
                make.height.equalTo(30)
            }
            
            forgetButton.snp_makeConstraints { (make) in
                make.right.equalTo(-50)
                make.left.equalTo(signUpButton.snp_right).offset(30)
                make.bottom.equalTo(signUpButton)
                make.width.height.equalTo(signUpButton)
            }
        } else {    // 4s 5s
            logoView.snp_makeConstraints { (make) in
                make.top.equalTo(self).offset(70)
                make.centerX.equalTo(self)
                make.left.equalTo(100)
                make.right.equalTo(-100)
                make.height.equalTo(120)
            }
            
            phoneNumView.snp_makeConstraints { (make) in
                make.centerY.equalTo(self)
                make.left.equalTo(30)
                make.width.equalTo(15)
                make.height.equalTo(25)
            }
            
            phoneNumTextField.snp_makeConstraints { (make) in
                make.left.equalTo(phoneNumView.snp_right).offset(25)
                make.top.equalTo(phoneNumView)
                make.height.equalTo(phoneNumView)
                make.right.equalTo(-30)
            }
            
            phoneNumLine.snp_makeConstraints { (make) in
                make.left.equalTo(phoneNumTextField)
                make.right.equalTo(phoneNumTextField)
                make.top.equalTo(phoneNumTextField.snp_bottom)
                make.height.equalTo(1)
            }
            
            phoneNumTableView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(phoneNumLine.snp_bottom)
                make.left.right.equalTo(phoneNumTextField)
                make.height.equalTo(tableViewHeight)
            })
            
            lockView.snp_makeConstraints { (make) in
                make.left.equalTo(phoneNumView)
                make.top.equalTo(phoneNumLine).offset(20)
                make.width.height.equalTo(phoneNumView)
            }
            
            passwordTextField.snp_makeConstraints { (make) in
                make.left.equalTo(lockView.snp_right).offset(25)
                make.top.equalTo(lockView)
                make.right.equalTo(-30)
                make.width.height.equalTo(phoneNumTextField)
            }
            
            passwordLine.snp_makeConstraints { (make) in
                make.left.equalTo(passwordTextField)
                make.right.equalTo(passwordTextField)
                make.top.equalTo(passwordTextField.snp_bottom)
                make.height.equalTo(1)
            }
            
            tipLabel.snp_makeConstraints { (make) in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.top.equalTo(lockView.snp_bottom).offset(10)
            }
            
            loginButton.snp_makeConstraints { (make) in
                make.left.equalTo(30)
                make.top.equalTo(tipLabel.snp_bottom).offset(10)
                make.right.equalTo(-30)
                make.height.equalTo(30)
            }
            
            signUpButton.snp_makeConstraints { (make) in
                make.left.equalTo(50)
                make.top.equalTo(loginButton.snp_bottom).offset(20)
                make.height.equalTo(40)
            }
            
            forgetButton.snp_makeConstraints { (make) in
                make.right.equalTo(-50)
                make.left.equalTo(signUpButton.snp_right).offset(30)
                make.bottom.equalTo(signUpButton)
                make.width.height.equalTo(signUpButton)
            }
        }
        
    }
    
    //MARK: -- 属性
    private let logoView: UIImageView = {
        let view: UIImageView  = UIImageView(image: UIImage(named: "img_logo.png"))
        return view
    } ()
    
    private let phoneNumView: UIImageView = {
        let view: UIImageView = UIImageView(image: UIImage(named: "icon_phone"))
        return view
    } ()
    
    let phoneNumTextField: UITextField = {
        let view: UITextField = UITextField()
        view.placeholder = "请输入手机号"
        view.font = Constants.smallFont
        view.keyboardType = .NumberPad
        view.clearButtonMode = UITextFieldViewMode.WhileEditing
        return view
    } ()
    
    private let phoneNumLine: UIView = Constants.splitLine()
    
    private let phoneNumTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = Constants.whiteBGColor
        view.hidden = true
        return view
    } ()
    
    let passwordTextField: UITextField = {
        let view: UITextField = UITextField()
        view.secureTextEntry = true
        view.placeholder = "请输入密码"
        view.font = Constants.smallFont
        view.clearButtonMode = UITextFieldViewMode.WhileEditing
        return view
    }()
    
    private let passwordLine: UIView = Constants.splitLine()
    
    private let lockView: UIImageView = {
        let view: UIImageView = UIImageView(image: UIImage(named: "icon_lock"))
        return view;
    } ()
    
    let tipLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "用户名或密码有误"
        label.font = Constants.smallFont
        label.textAlignment = NSTextAlignment.Center
        label.textColor = Constants.redWordColor
        label.hidden = true
        return label
    } ()
    
    let loginButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setTitle("登录", forState: .Normal)
        btn.setTitleColor(Constants.whiteWordColor, forState: .Normal)
        btn.layer.cornerRadius = 16
        btn.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "btn_login_pre"), forState: .Highlighted)
        return btn
    } ()
    
    let signUpButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.hidden = true   // true为关闭注册
        btn.setImage(UIImage(named: "btn_register_nor"), forState: .Normal)
        btn.setImage(UIImage(named: "btn_register_pre"), forState: .Highlighted)
        return btn
    } ()
    
    let forgetButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setImage(UIImage(named: "btn_forget_nor"), forState: .Normal)
        btn.setImage(UIImage(named: "btn_forget_pre"), forState: .Highlighted)
        return btn
    } ()
}
