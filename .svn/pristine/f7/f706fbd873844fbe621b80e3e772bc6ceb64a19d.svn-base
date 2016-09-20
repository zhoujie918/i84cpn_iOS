//
//  CPEditPassengerInfoViewController.swift
//  i84cpn
//
//  Created by Benjamin on 16/5/27.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPEditPassengerInfoViewController: CMBaseViewController, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "编辑乘客信息"
        view.addSubview(editPassengerInfoView)
        editPassengerInfoView.frame = view.frame
        
        editPassengerInfoView.OKButton.addTarget(self, action: #selector(saveChange), forControlEvents: .TouchUpInside)
        editPassengerInfoView.deleteButton.addTarget(self, action: #selector(deletePassengerAction), forControlEvents: .TouchUpInside)
        editPassengerInfoView.changeHeadImageButton.addTarget(self, action: #selector(changeHeadImage), forControlEvents: .TouchUpInside)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if firstLoad {
            getData()
            firstLoad = !firstLoad
        }
    }

    
    // 事件响应
    func changeHeadImage(button: UIButton) {
        let isOwned = passengerDetailInfo!["isOwned"] as! Int
        if isOwned == 0 {
            let alertView = UIAlertView(title: "提示", message: "通过关联而添加的乘客\n没有修改头像的权限", delegate: self, cancelButtonTitle: "确定")
            alertView.show()
        } else {
            let alertView = UIAlertView(title: "请选择头像", message: "", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "拍照", "从手机相册选择")
            alertView.tag = 0
            alertView.show()
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
            if alertView.tag == 0 {
                cameraImage()
            } else {
                deletePassengerInfo()
            }
        case 2:
            localPhoto()
        default: break
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.editPassengerInfoView.headImageView.image = info["UIImagePickerControllerEditedImage"] as? UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    func imageWithImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    // 事件响应
    func saveChange(button: UIButton) {
        let psgId = passengerDetailInfo!["psgId"] as! Int
        let isSend = editPassengerInfoView.getIsSend()
        var image = editPassengerInfoView.headImageView.image
        image = imageWithImage(image!, newSize: CGSizeMake(100, 100))
        let imgData = UIImageJPEGRepresentation(image!, 0.7)
        
        let imageDataArray:Array = [imgData!]
        
        CPAFHTTPSessionManager.multiUploadWithUrlString(Constants.fileApiURL, params: Constants.editPassengerInfo(psgId, isSend: isSend), imageDataArray: imageDataArray, progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                var dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    dic = dic["result"] as! NSDictionary
                    if dic.objectForKey("success") as! Bool {
                        let hub = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                        hub.labelText = "保存成功"
                        hub.hide(true, afterDelay: 1)
                        self.navigationController?.popViewControllerAnimated(true)
                    } else {
                        let hub = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                        hub.labelText = dic.objectForKey("msg") as! String
                        hub.hide(true, afterDelay: 1)
                    }
                } else {
                    let hub = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
                    hub.labelText = dic.objectForKey("msg") as! String
                    hub.hide(true, afterDelay: 1)
                    self.navigationController?.popViewControllerAnimated(true)
                }
                
            }, failureBlock: { (error) in
                print(error)
        })
    }
    
    func deletePassengerAction(button: UIButton) {
        if passengerDetailInfo == nil {
            return
        }
        let alertView = UIAlertView(title: "警告", message: "确定删除该用户吗?", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        alertView.tag = 1
        alertView.show()
    }
    
    func deletePassengerInfo() {
        let psgId = passengerDetailInfo!["psgId"] as! Int
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.deletePassengerInfo(psgId), progressBlock: nil, successBlock: { (respondData) in
            var dic:NSDictionary = respondData as! NSDictionary
            let rsp: Bool = dic["success"] as! Bool
            if rsp {
                dic = dic["result"] as! NSDictionary
                if dic.objectForKey("success") as! Bool {
                    let hub = MBProgressHUD.showHUDAddedTo(self.navigationController!.view, animated: true)
                    hub.labelText = "删除成功"
                    hub.hide(true, afterDelay: 1)
                    
                    self.navigationController?.popViewControllerAnimated(true)
                } else {
                    let hub = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hub.labelText = dic.objectForKey("msg") as! String
                    hub.hide(true, afterDelay: 1)
                }
            } else {
                let hub = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                hub.labelText = dic.objectForKey("msg") as! String
                hub.hide(true, afterDelay: 1)
            }
        }) { (error) in
            print(error)
        }
    }
    func getData() {
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.getPassengerDetailInfo(psgId), progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                var dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    dic = dic["result"] as! NSDictionary
                    if dic.objectForKey("success") as! Bool {
                        self.passengerDetailInfo = dic as? Dictionary<String, AnyObject>
                        self.editPassengerInfoView.reloadData(dic)
                    } else {
                        let alertView = UIAlertView(title: "提示", message: dic.objectForKey("msg") as? String, delegate:  self, cancelButtonTitle: "确定")
                        alertView.show()
                    }
                } else {
                    let errorCode = dic.objectForKey("errorCode") as? String
                    if errorCode == "00001" {
                        CPUserModel.clearData()
                        CPUserModel.userLogin()
                    }
                }
            }) { (error) in
                print(error)
        }
    }
    
    private var firstLoad = true
    var psgId: Int = 0
    private var img:UIImage?
    private var passengerDetailInfo: Dictionary<String, AnyObject>?
    private let editPassengerInfoView = CPEditPassengerInfoView()
}
