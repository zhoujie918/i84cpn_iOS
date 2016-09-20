//
//  CPAddPassengerViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/23.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPAddPassengerViewController: CMBaseViewController, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "添加乘客"
        view.addSubview(addPassenerView)
        
//        if hideNavi == true {
//            addPassenerView.frame = CGRectMake(0, 64, Constants.screenWidth, SCREEN_HEIGHT)
//        }else{
            addPassenerView.frame = view.frame
//        }
        
//        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        addPassenerView.photoButton.addTarget(self, action: #selector(addHeadImage), forControlEvents: .TouchUpInside)
        addPassenerView.changeHeadImageButton.addTarget(self, action: #selector(addHeadImage), forControlEvents: .TouchUpInside)
        addPassenerView.OKButton.addTarget(self, action: #selector(submit), forControlEvents: .TouchUpInside)
        
        addPassenerView.scrollView.contentSize = CGSizeMake(Constants.screenWidth, addPassenerView.OKButton.frame.origin.y + addPassenerView.OKButton.frame.height + 100)
    }
    
    // 事件响应
    // 添加头像
    func addHeadImage(button: UIButton) {
        let alertView = UIAlertView(title: "请选择头像", message: "", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "拍照", "从手机相册选择")
        alertView.show()
    }
    
   
    
    // 确定提交
    func submit(button: UIButton) {
        let idNo = addPassenerView.idTextField.text
        let name = addPassenerView.nameTextField.text
        let isSend:Int = addPassenerView.rideInfoSwitch.on ?  1 : 0
        let captcha = addPassenerView.verifyCodeTextField.text
        
        if !imgSelected {
            let alertView = UIAlertView(title: "提示", message: "请选择头像", delegate: self, cancelButtonTitle: "确定")
            alertView.show()
        } else if addPassenerView.idTextField.text?.characters.count == 0 || addPassenerView.nameTextField.text?.characters.count == 0 {
            let alertView = UIAlertView(title: "提示", message: "请填写完整身份证或乘客信息", delegate: self, cancelButtonTitle: "确定")
            alertView.show()
        }  else if addPassenerView.verifyCodeTextField.text!.characters.count == 0 {
            let alertView = UIAlertView(title: "提示", message: "请输入验证码", delegate: self, cancelButtonTitle: "确定")
            alertView.show()
        } else {
            let hud = MBProgressHUD.showHUDAddedTo(self.navigationController!.view, animated: true)
//            hud.mode = MBProgressHUDMode.Text
            hud.minShowTime = Constants.hudShowTime
            CPAFHTTPSessionManager.multiUploadWithUrlString(Constants.fileApiURL, params: Constants.addPassengerWithIdNo(idNo!, name: name!, isSend: isSend, captcha: captcha!), imageDataArray: imageDataArray, progressBlock: { (progress) in
                
                }, successBlock: { (respondData) in
                    var dic:NSDictionary = respondData as! NSDictionary
                    let rsp: Bool = dic["success"] as! Bool
                    if rsp {
                        dic = dic["result"] as! NSDictionary
                        if dic.objectForKey("success") as! Bool {
                            hud.labelText = "新增成功"
                            self.navigationController?.popViewControllerAnimated(true)
                            hud.hide(true, afterDelay: 0.7)
                        } else {
                            if dic.objectForKey("msg") != nil {
                                hud.labelText = dic.objectForKey("msg") as! String
                            } else {
                                hud.labelText = "身份证与姓名输入有误"
                            }
                            hud.hide(true, afterDelay: 1)
                            self.addPassenerView.reloadVerifyCode()
                        }
                    } else {
                        self.addPassenerView.reloadVerifyCode()
                        if dic.objectForKey("msg") != nil {
                            hud.labelText = dic.objectForKey("msg") as! String
                            hud.hide(true, afterDelay: 0.7)
                        }
                        let errorCode = dic.objectForKey("errorCode") as? String
                        if errorCode == "00001" {
                            CPUserModel.clearData()
                            CPUserModel.userLogin()
                        }
                        if errorCode == "00006" {
                            let alertView = UIAlertView(title: "提示", message: respondData.objectForKey("msg") as? String, delegate:  self, cancelButtonTitle: "确定")
                            alertView.show()
                            let vc = CPRelevancePassengerRideInfoPushViewController()
                            self.hidesBottomBarWhenPushed=true
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        if errorCode == "00007" {
                            let alertView = UIAlertView(title: "提示", message: respondData.objectForKey("msg") as? String, delegate:  self, cancelButtonTitle: "确定")
                            alertView.show()
                            CPUserModel.clearData()
                            let vc = CPLoginViewController()
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    
                }, failureBlock: { (error) in
                    print(error)
            })

        }
    }
    
    // 打开本地图片
    func localPhoto() {
        let vc = UIImagePickerController()
        vc.allowsEditing = true // 可编辑状态
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve // 页面跳转效果
        vc.delegate = self
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // 拍照
    func cameraImage() {
        let vc = UIImagePickerController()
        vc.sourceType = UIImagePickerControllerSourceType.Camera // 拍照模式，默认为本地照片
        vc.allowsEditing = true // 可编辑状态
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve // 页面跳转效果
        vc.delegate = self
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // delegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 1:
            cameraImage()
        case 2:
            localPhoto()
        default: break
        }
    }
    
    func imageWithImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var img = info["UIImagePickerControllerEditedImage"] as! UIImage
       img = imageWithImage(img, newSize: CGSizeMake(100, 100))
        let imgData = UIImageJPEGRepresentation(img, 0.7)
        
        imageDataArray = [imgData!]
        self.addPassenerView.headImageView.image = info["UIImagePickerControllerEditedImage"] as? UIImage;
        self.addPassenerView.headImageView.hidden = false
        self.addPassenerView.changeHeadImageButton.hidden = false
        self.addPassenerView.photoButton.hidden = true
        imgSelected = true
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    var hideNavi =  false
    private var imgSelected = false
    private var imageDataArray:Array<NSData>?
    private let addPassenerView = CPAddPassengerView()
}
