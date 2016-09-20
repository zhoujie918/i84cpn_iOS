//
//  CPLineInfoModel.swift
//  i84cpn
//
//  Created by 周杰 on 16/5/19.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPLineInfoModel: NSObject,DictModelProtocol {
    typealias callBackFun=(dateListAr:NSArray,stationListAr:NSArray,passengerListAr:NSArray,lineInfoObj:NSDictionary,model:CPLineInfoModel)->()
    typealias callBackFun2=(orderId:Int)->()
    typealias passGerFun=(resultList:NSArray)->()
    typealias orderInfoResult=(orderInfo:NSDictionary)->()
    typealias callBackFun3=(success:NSDictionary)->()
    
    var dateListAr=NSMutableArray()
    var stationListAr=NSMutableArray()
    var passengerListAr=NSMutableArray()
    var lineInfoObj=NSMutableDictionary()
    var stationList : [StationList]?
    var emptyArray=[String]()
    var emptyDic=Dictionary<String, String>()
    
    //获取普通线路详情
    func lineInfoDataLoad(postURL:String,para:NSMutableDictionary,success:callBackFun,fail:failClosure){
        CPAFHTTPSessionManager.postWithUrlString(postURL, parameter: para as [NSObject : AnyObject], progressBlock: nil, successBlock: { (responseData) in
            self.dateListAr.removeAllObjects()
            self.stationListAr.removeAllObjects()
            self.passengerListAr.removeAllObjects()
            self.lineInfoObj.removeAllObjects()
//            print("responseData=",responseData)
//            print("参数＝",para)
            if(responseData.objectForKey("success") as! Bool){
                if((responseData.objectForKey("result")?.objectForKey("success") as! Bool)&&(responseData.objectForKey("result")?.objectForKey("result")?.count != nil)){
//                    print(responseData)
                    if let info=responseData.objectForKey("result")?.objectForKey("result")?.objectForKey("info"){
                        if info.count != nil{
                            if let dateList=info.objectForKey("dateList") {
                                let stationList=info.objectForKey("stationList")
                                let passengerList=info.objectForKey("passengerList")
                                let lineInfoObj=info.objectForKey("lineInfo")
                                let modelTool = DictModelManager.sharedManager
                                let model = modelTool.objectWithDictionary((responseData.objectForKey("result")!.objectForKey("result")!.objectForKey("info")! as? NSDictionary)!, cls: CPLineInfoModel.self) as? CPLineInfoModel
                                //                            if(dateList != nil)&&(stationList != nil)&&(passengerList != nil)&&(lineInfoObj != nil){
                                success(dateListAr: dateList as! NSArray, stationListAr: stationList as! NSArray, passengerListAr: passengerList as! NSArray, lineInfoObj: lineInfoObj as! NSDictionary,model: model!)
                                //                            }
                            }
                        }
                        else{
                            let alertView=UIAlertView(title: "提示", message: "抱歉，该线路已被删除", delegate: self, cancelButtonTitle: "确定")
                            alertView.show()
                        }
                        
                    }
                    
                    
                }else{
                    print("获取线路查询结果：",responseData)
//                    let msg=responseData.objectForKey("msg") as! String
//                    let alertView=UIAlertView(title: "提示", message: msg, delegate: self, cancelButtonTitle: "确定")
//                    alertView.show()
                }
            }else{
                print("获取线路查询结果：",responseData)
//                let msg=responseData.objectForKey("msg") as! String
//                let alertView=UIAlertView(title: "提示", message: msg, delegate: self, cancelButtonTitle: "确定")
//                alertView.show()
            }

            }) { (error) in
                print(error)
                fail(fail: nil)
        }
        
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["stationList" : "\(StationList.self)"]
    }
    
    //获取乘客列表
    func getPassger(postURL:String,para:[String:AnyObject],success:passGerFun){
        CPAFHTTPSessionManager.postWithUrlString(postURL, parameter: para as [NSObject : AnyObject], progressBlock: nil, successBlock: { (responseData) in
//            print("获取乘客列表:",responseData)
            if(responseData.objectForKey("success") as! Bool){
                if((responseData.objectForKey("result")!.count != nil)&&(responseData.objectForKey("result")!.count != 0)){
                    let resultList=responseData.objectForKey("result")!
                    success(resultList: resultList as! NSArray)
                }
                else{
                    success(resultList: self.emptyArray)
                }
                
            }else{
                print("获取乘客列表结果：",responseData)
//                let msg=responseData.objectForKey("msg") as! String
//                let alertView=UIAlertView(title: "提示", message: msg, delegate: self, cancelButtonTitle: "确定")
//                alertView.show()
            }
            }) { (error) in
                print(error)
        }
    }
    
    //添加通讯地址
    func getPassgerAddress(postURL:String,para:[String:AnyObject],success:passGerFun){
        CPAFHTTPSessionManager.postWithUrlString(postURL, parameter: para as [NSObject : AnyObject], progressBlock: nil, successBlock: { (responseData) in
//            print("添加通讯地址:",responseData)
            if(responseData.objectForKey("success") as! Bool){
                if((responseData.objectForKey("result")?.count != nil)&&(responseData.objectForKey("result")?.count != 0)){
                    let resultList=responseData.objectForKey("result")!
                    success(resultList: resultList as! NSArray)
                }
                else{
                    success(resultList: self.emptyArray)
                }
            }else{
                print("获取地址列表结果:",responseData)
//                let msg=responseData.objectForKey("msg") as! String
//                let alertView=UIAlertView(title: "提示", message: msg, delegate: self, cancelButtonTitle: "确定")
//                alertView.show()
            }

        }) { (error) in
            print(error)
        }
    }
    
    func getAddName(postURL:String,para:NSMutableDictionary,success:callBackFun3){
        CPAFHTTPSessionManager.postWithUrlString(postURL, parameter: para as [NSObject : AnyObject], progressBlock: nil, successBlock: { (responseData) in
//            print(responseData)
            success(success: responseData as! NSDictionary)
            
            
        }) { (error) in
            print(error)
        }
    }
    
    //获取招募中线路详情
    func getJoinLineInfo(postURL:String,para:NSMutableDictionary,success:callBackFun3,fail:failClosure){
        CPAFHTTPSessionManager.postWithUrlString(postURL, parameter: para as [NSObject : AnyObject], progressBlock: nil, successBlock: { (resp) in
            if let result=resp?.objectForKey("result")?.objectForKey("result") as? NSDictionary{
                success(success: result)
            }
            }, failureBlock: { (error) in
                print(error)
                fail(fail: nil)
        })
    }
    
    //获取改签线路详情
    func getOrderInfo(postURL:String,para:NSMutableDictionary,success:orderInfoResult,fail:failClosure){
        CPAFHTTPSessionManager.postWithUrlString(postURL, parameter: para as [NSObject : AnyObject], progressBlock: nil, successBlock: { (responseData) in
            if (responseData.objectForKey("success") as! Bool){
                if let result=responseData?.objectForKey("result")?.objectForKey("result"){
                    success(orderInfo: result as! NSDictionary)
                }
                else {
                    let msg=responseData.objectForKey("result")?.objectForKey("msg") as! String
                    let alertView=UIAlertView(title: "提示", message: msg, delegate: self, cancelButtonTitle: "确定")
                    alertView.show()
                }
            }else {
                let msg=responseData.objectForKey("msg") as! String
                let alertView=UIAlertView(title: "提示", message: msg, delegate: self, cancelButtonTitle: "确定")
                alertView.show()
            }
            
            
            }) { (error) in
                print(error)
                fail(fail: nil)
        }
    }
    
    //获取改签的订单提示信息
    func getChangeOrderInfo(postURL:String,para:NSMutableDictionary,success:orderInfoResult){
        CPAFHTTPSessionManager.postWithUrlString(postURL, parameter: para as [NSObject : AnyObject], progressBlock: nil, successBlock: { (responseData) in
//            print(responseData)
            if (responseData.objectForKey("success") as! Bool){
                if let result=responseData?.objectForKey("result")?.objectForKey("obj"){
                    success(orderInfo: result as! NSDictionary)
                }
                else {
                    let msg=responseData.objectForKey("result")?.objectForKey("msg") as! String
                    let alertView=UIAlertView(title: "提示", message: msg, delegate: self, cancelButtonTitle: "确定")
                    alertView.show()
                }
            }else {
                let msg=responseData.objectForKey("msg") as! String
                let alertView=UIAlertView(title: "提示", message: msg, delegate: self, cancelButtonTitle: "确定")
                alertView.show()
            }
            
            
        }) { (error) in
            print(error)
        }
    }
    
    //获取订单Id
    func getOrderId(postURL:String,para:NSMutableDictionary,success:callBackFun2,fail:failClosure){
        CPAFHTTPSessionManager.postWithUrlString(postURL, parameter: para as [NSObject : AnyObject], progressBlock: nil, successBlock: { (responseData) in
//            print(responseData)
            let dic = responseData as! NSDictionary
            if dic.objectForKey("success") as! Bool {
                if(responseData.objectForKey("result")?.objectForKey("success") as! Bool){
                    if let orderId=responseData.objectForKey("result")?.objectForKey("obj")?.objectForKey("orderId") {
                        print("新增订单成功，orderId=",orderId)
                        success(orderId: orderId as! Int)
                    }
                    else if let orderNo=responseData.objectForKey("result")?.objectForKey("obj")?.objectForKey("orderNo"){
                            print("改签订单成功，orderNo=",orderNo)
                            success(orderId: Int(orderNo as! String)! )
                        
                    }else if responseData.objectForKey("result")?.objectForKey("obj")?.count==0{
                        fail(fail: "退款改签成功")
                    }
//                    else{
//                        print(responseData)
//                        let msg="新增订单失败，请联系开发人员"
//                        let alertView=UIAlertView(title: "提示", message: msg, delegate: self, cancelButtonTitle: "确定")
//                        alertView.show()
//                    }
                    
                }else{
                    let msg=responseData.objectForKey("result")?.objectForKey("msg") as! String
                    let alertView=UIAlertView(title: "提示", message: msg, delegate: self, cancelButtonTitle: "确定")
                    alertView.show()
                }
                
            } else {
                print("获取订单Id失败：",responseData)
                let alertView=UIAlertView(title: "提示", message: "服务异常，请联系客服人员！", delegate: self, cancelButtonTitle: "确定")
                alertView.show()
            }

            }) { (error) in
                print(error)
                fail(fail: nil)
        }
        
    }

}
