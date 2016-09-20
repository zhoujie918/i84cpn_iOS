//
//  CPEditPassengerInfoView.swift
//  i84cpn
//
//  Created by Benjamin on 16/5/27.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPEditPassengerInfoView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.paleBGColor
        
        self.addSubview(scrollView)
        
        scrollView.addSubview(containView1)
        containView1.addSubview(photoLabel)
        containView1.addSubview(headImageView)
        containView1.addSubview(changeHeadImageButton)
        
        scrollView.addSubview(containView2)
        containView2.addSubview(idLabel)
        containView2.addSubview(idTextField)
        containView2.addSubview(nameLabel)
        containView2.addSubview(nameTextField)
        
        
        scrollView.addSubview(containView3)
        containView3.addSubview(rideInfoPushLabel)
        containView3.addSubview(rideInfoSwitch)
        
        scrollView.addSubview(deleteButton)
        scrollView.addSubview(OKButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(data: NSDictionary) {
        let imgName = data.objectForKey("psgPhoto") as! String
        let idNo = data.objectForKey("idNo") as! String
        let psgName = data.objectForKey("psgName") as! String
        psgId = data.objectForKey("psgId") as! Int
        let isSend = data.objectForKey("isSend") as! Int
        isOwned = data.objectForKey("isOwned") as! Int
        
        if (imgName.characters.count != 0) {
//            CPAFHTTPSessionManager.getWithUrlString(Constants.getImageURL, parameter: Constants.getImageWithImageName(imgName), progressBlock: { (progress) in
//                
//                }, successBlock: { (respondData) in
//                    let img = UIImage(data: respondData as! NSData)
//                    self.headImageView.image = img
//                }, failureBlock: { (error) in
//                    print(error)
//            })
            headImageView.sd_setImageWithURL(Constants.getSDWebImageURLWithImageName(imgName), placeholderImage: UIImage(named: "img_default"))
        } else {
            headImageView.image = UIImage(named: "img_default")
        }
        
        idTextField.text = idNo
        nameTextField.text = psgName
        if isSend == 1 {
            rideInfoSwitch.on = true
        } else {
            rideInfoSwitch.on = false
        }
    }
    
    func getIsSend() -> Int {
        if rideInfoSwitch.on {
            return 1
        }
        return 0
    }
    
    func getPsgId() -> Int {
        return psgId
    }
    
    func getIsOwned() -> Bool {
        if isOwned == 1 {
            return true
        }
        return false
    }
    
    override func layoutSubviews() {
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        containView1.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(10)
            make.width.equalTo(Constants.screenWidth)
            make.height.equalTo(100)
        }
        
        photoLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(containView1)
            make.left.equalTo(20)
        }
        

        headImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(containView1)
            make.right.equalTo(changeHeadImageButton.snp_left).offset(-20)
            make.width.height.equalTo(80)
        }
        
        changeHeadImageButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(containView1)
            make.right.equalTo(-20)
        }
        
        containView2.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(containView1.snp_bottom).offset(20)
            make.width.equalTo(Constants.screenWidth)
            make.bottom.equalTo(nameLabel.snp_bottom).offset(20)
        }
        
        idLabel.snp_makeConstraints { (make) in
            make.left.equalTo(photoLabel)
            make.top.equalTo(containView2).offset(20)
            make.height.equalTo(50)
        }
        
        idTextField.snp_makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp_right).offset(15)
            make.centerY.equalTo(idLabel)
            make.right.equalTo(-20)
            make.height.equalTo(34)
        }
        
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(idLabel)
            make.top.equalTo(idLabel.snp_bottom).offset(30)
            make.width.equalTo(70)
        }
        
        nameTextField.snp_makeConstraints { (make) in
            make.left.equalTo(idTextField)
            make.centerY.equalTo(nameLabel)
            make.right.equalTo(-20)
            make.height.equalTo(34)
        }
        
        
        containView3.snp_makeConstraints { (make) in
            make.top.equalTo(containView2.snp_bottom).offset(10)
            make.left.equalTo(0)
            make.width.equalTo(Constants.screenWidth)
            make.bottom.equalTo(rideInfoPushLabel.snp_bottom).offset(20)
        }
        
        rideInfoPushLabel.snp_makeConstraints { (make) in
            make.left.equalTo(photoLabel)
            make.top.equalTo(containView3).offset(20)
        }
        
        rideInfoSwitch.snp_makeConstraints { (make) in
            make.centerY.equalTo(rideInfoPushLabel)
            make.right.equalTo(-20)
        }
        
        
        OKButton.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(containView3.snp_bottom).offset(30)
        }
        
        deleteButton.snp_makeConstraints { (make) in
            make.left.equalTo(OKButton.snp_right).offset(40)
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(OKButton)
            make.width.equalTo(OKButton)
        }
        
        scrollView.contentSize = CGSizeMake(Constants.screenWidth, OKButton.frame.origin.y + OKButton.frame.size.height + 80)
    }
    
    private var psgId = 0
    private var isOwned = 0
    let scrollView: UIScrollView = {
        let view: UIScrollView = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.scrollEnabled = true
        return view
    } ()
    
    private let containView1 = Constants.containView()
    private let photoLabel: UILabel = {
        let view = UILabel()
        view.text = "乘客照片"
        return view
    } ()
    
    
    let headImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 80 * 0.5;
        view.layer.masksToBounds = true;
        return view
    } ()
    
    let changeHeadImageButton: UIButton = {
        let view = UIButton()
        view.setTitle("更改", forState: .Normal)
        view.setTitleColor(Constants.yellowWordColor, forState: .Normal)
        view.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        view.layer.borderColor = Constants.yellowWordColor.CGColor
        view.layer.borderWidth = 1
        return view
    } ()
    
    private let containView2 = Constants.containView()
    private let idLabel: UILabel = {
        let view = UILabel()
        view.text = "身份证"
        return view
    } ()
    let idTextField: UITextField = {
        let view = UITextField()
        view.layer.borderColor = Constants.paleBGColor.CGColor
        view.layer.borderWidth = 1
        view.leftView=UIView(frame: CGRectMake(0,0,10,34))
        view.leftViewMode=UITextFieldViewMode.Always
        view.enabled = false
        return view
    } ()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.text = "乘客信息"
        return view
    } ()
    
    let nameTextField: UITextField = {
        let view = UITextField()
        view.layer.borderColor = Constants.paleBGColor.CGColor
        view.layer.borderWidth = 1
        view.leftView=UIView(frame: CGRectMake(0,0,10,34))
        view.leftViewMode=UITextFieldViewMode.Always
        view.enabled = false
        return view
    } ()
    
    
    private let containView3 = Constants.containView()
    private let rideInfoPushLabel: UILabel = {
        let view = UILabel()
        view.text = "乘车信息推送"
        return view
    } ()
    let rideInfoSwitch: UISwitch = {
        let view = UISwitch()
        view.onTintColor = Constants.yellowWordColor
        return view
    } ()
    

    let OKButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setTitle("保存", forState: .Normal)
        btn.tintColor = Constants.whiteWordColor
        btn.layer.cornerRadius = 16
        btn.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: .Normal)
        return btn
    } ()
    
    let deleteButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setTitle("删除", forState: .Normal)
        btn.tintColor = Constants.whiteWordColor
        btn.layer.cornerRadius = 16
        btn.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: .Normal)
        return btn
    } ()

}
