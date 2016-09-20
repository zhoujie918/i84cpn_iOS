//
//  CPUserModel.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/17.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

protocol UserModelDelegate {
    func userInfoReloadData()
}

class CPUserModel: NSObject, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate {
    static var delegate: UserModelDelegate?
    
//    class func shareUserInfoModel() -> CPUserModel{
//        struct Singleton{
//            static var onceToken : dispatch_once_t = 0
//            static var single:CPUserModel?
//        }
//        dispatch_once(&Singleton.onceToken,{
//            Singleton.single=shareUserInfoModel()
//            }
//        )
//        return Singleton.single!
//    }
    
    static func clearData()  {
        realName = nil
        imageName = nil
        petName = nil
        idNo = nil
        phoneNum = nil
        authDate = nil
        isLogin = false
        isBuyTicket = false
        isHaveOrder = 0
    }
    
    
    
    static func getUserInfo() {
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.getUserInfoParam as [NSObject : AnyObject], progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    let objData: NSDictionary = dic["result"] as! NSDictionary
                    let imageName = objData.valueForKey("userPicture")
                    let petName = objData.valueForKey("nickName")
                    let realName = objData.valueForKey("realName")
                    let idNo = objData.valueForKey("idNo")
                    let mobile = objData.valueForKey("mobile")
                    
                    if (imageName != nil) {
                        CPUserModel.imageName = imageName as? String
                    }
                    if (petName != nil) {
                        CPUserModel.petName = petName as? String
                    }
                    if (realName != nil) {
                        CPUserModel.realName = realName as? String
                    }
                    if (idNo != nil) {
                        CPUserModel.idNo = idNo as? String
                    }
                    if (mobile != nil) {
                        CPUserModel.encryptedPhoneNum = mobile as? String
                    }
                    
                    if delegate != nil {
                        delegate?.userInfoReloadData()
                    } else {
                        NSNotificationCenter.defaultCenter().postNotificationName("reloadUserInfo",
                        object: self, userInfo: nil)
                    }
                } else {
                    Constants.dPrint(dic)
                    CPUserModel.clearData()
                    let errorCode = dic.objectForKey("errorCode") as? String
                    if errorCode == "00001" {
//                        CPUserModel.userLogin()
                    }
                }
        }) { (error) in
            print(error)
        }
    }
    
    static func login() {
        isLogin = true
    }
    
    
    
    static func userLogin() {
        let userName = NSUserDefaults.standardUserDefaults().valueForKey("UserNameKey") as! String!
        let pwd = NSUserDefaults.standardUserDefaults().valueForKey("PwdKey") as! String!
        if NSUserDefaults.standardUserDefaults().valueForKey("cityId") == nil {
            NSUserDefaults.standardUserDefaults().setObject(350100, forKey: "cityId")
            //设置同步
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        let cityId = NSUserDefaults.standardUserDefaults().valueForKey("cityId") as! Int
        Constants.cityId = cityId
        if  pwd != nil && pwd.characters.count != 0 {
   
            CPAFHTTPSessionManager.postWithUrlString(Constants.loginURL , parameter: Constants.loginParms(userName, password: pwd, cityId: cityId), progressBlock: { (progress) in
                
                }, successBlock: { (respondData) in
                    let dic:NSDictionary = respondData as! NSDictionary
                    let success: Bool = dic["success"] as! Bool
                    if success == true {
                        CPUserModel.isLogin = true
                        Constants.dPrint("login success")
                        CPUserModel.getUserInfo()
                        if dic.objectForKey("id") != nil {
//                            JPUSHService.setAlias("417eac30", callbackSelector: nil, object: self)
                            JPUSHService.setAlias(dic.objectForKey("id") as! String, callbackSelector: nil, object: self)
                        }
//                        CPUserModel.hasPaidOrder()
                        if dic.objectForKey("isHaveOrder") != nil {
                            isHaveOrder = dic.objectForKey("isHaveOrder") as! Int
                            if isHaveOrder == 0 {
                                NSNotificationCenter.defaultCenter().postNotificationName("HideRealtimeCar",
                                    object: self, userInfo: nil)
                            } else {
                                NSNotificationCenter.defaultCenter().postNotificationName("ShowRealtimeCar",
                                    object: self, userInfo: nil)
                            }
                        }
                    } else {
                        Constants.dPrint(dic)
                        NSNotificationCenter.defaultCenter().postNotificationName("HideRealtimeCar",
                            object: self, userInfo: nil)
                        if dic.objectForKey("msg") != nil {
                            let alertView = UIAlertView(title: "提示", message: dic.objectForKey("msg") as? String, delegate: self, cancelButtonTitle: "确定")
                            alertView.show()
                        }
                        // 自动登录失败-清除自动登录帐号密码
                        CPUserModel.clearData()
                        NSUserDefaults.standardUserDefaults().setObject("", forKey: "UserNameKey")
                        NSUserDefaults.standardUserDefaults().setObject("", forKey: "PwdKey")
                        //设置同步
                        NSUserDefaults.standardUserDefaults().synchronize()
                    }
                }, failureBlock: { (error) in
                    NSNotificationCenter.defaultCenter().postNotificationName("HideRealtimeCar",
                        object: self, userInfo: nil)
                    print(error)
            })
            
        }else{
            NSNotificationCenter.defaultCenter().postNotificationName("HideRealtimeCar",
                                                                      object: self, userInfo: nil)
        }
    }
    
    static func hasPaidOrder() {

        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.getOrderList(2), progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    let dataArray = dic["result"] as? NSArray
                    if dataArray!.count > 0 {
                        NSNotificationCenter.defaultCenter().postNotificationName("ShowRealtimeCar",
                            object: self, userInfo: nil)
                    } else {
                        NSNotificationCenter.defaultCenter().postNotificationName("HideRealtimeCar",
                            object: self, userInfo: nil)
                    }
                } else {
                    NSNotificationCenter.defaultCenter().postNotificationName("HideRealtimeCar",
                        object: self, userInfo: nil)
                }
            }, failureBlock: { (error) in
                NSNotificationCenter.defaultCenter().postNotificationName("HideRealtimeCar",
                    object: self, userInfo: nil)
                print(error)
        })
    }


    static func getLoginState() -> Bool{
        return isLogin
    }
    
    static var isLogin = false
    static var phoneNum: String?
    static var password: String?
    static var encryptedPhoneNum: String?
    static var realName: String?
    static var petName: String?
    static var idNo: String?
    static var imageName: String?
    static var authDate: String?
    static var isBuyTicket = false
    static var isHaveOrder = 0
}
