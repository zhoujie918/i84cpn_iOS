//
//  CPMyCollectionModel.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/6/14.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit


class CPMyCollectionModel: NSObject {
    
    class MyCollectionLineModel: NSObject {
        var lclrId: Int?
        var lineName: String?
        var content: String?
        var replyContent: String?
        var attendMsg: String?
    }
    
    class MyParTakeLineModel: NSObject {
        var attendId: Int?
        var type: Int?
        var lineName: String?
        var attendMsg: String?
        var replyContent: String?
    }
    
    var collectionLineList = Array<MyCollectionLineModel>()
    var parTakeLineList = Array<MyParTakeLineModel>()
    
    func loadData() {
        getMyCollectionLineList()
        getMyParTakeLineList()
    }
    
    func getMyCollectionLineList() {
        collectionLineList.removeAll()
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.getMyCollectionLineListWithStart(), progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    let objData: NSDictionary = dic["result"] as! NSDictionary
                    if objData.objectForKey("success")  as! Bool {
                        let collectionLine = MyCollectionLineModel()
                        let list = objData["list"] as! NSArray
                        for dic in list {
                            collectionLine.lclrId = dic.objectForKey("lclrId") as? Int
                            collectionLine.lineName = dic.objectForKey("lineName") as? String
                            collectionLine.content = dic.objectForKey("content") as? String
                            collectionLine.replyContent = dic.objectForKey("replyContent") as? String
                            collectionLine.attendMsg = dic.objectForKey("attendMsg") as? String
                            self.collectionLineList.append(collectionLine)
                        }

                    } else {
                        let alertView = UIAlertView(title: "提示", message: objData.objectForKey("msg") as? String, delegate:  self, cancelButtonTitle: "确定")
                        alertView.show()
                    }
                }
            }, failureBlock: { (error) in
                print(error)
        })
    }
    
    func getMyParTakeLineList() {
        parTakeLineList.removeAll()
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.getMyParTakeLineListWithStart(), progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    let objData: NSDictionary = dic["result"] as! NSDictionary
                    if objData.objectForKey("success")  as! Bool {
                        let partakeLine = MyParTakeLineModel()
                        let list = objData["list"] as! NSArray
                        for dic in list {
                            partakeLine.attendId = dic.objectForKey("attendId") as? Int
                            partakeLine.type = dic.objectForKey("type") as? Int
                            partakeLine.lineName = dic.objectForKey("lineName") as? String
                            partakeLine.replyContent = dic.objectForKey("replyContent") as? String
                            partakeLine.attendMsg = dic.objectForKey("attendMsg") as? String
                            self.parTakeLineList.append(partakeLine)
                        }

                    } else {
                        let alertView = UIAlertView(title: "提示", message: objData.objectForKey("msg") as? String, delegate:  self, cancelButtonTitle: "确定")
                        alertView.show()
                    }
                }
            }, failureBlock: { (error) in
                print(error)
        })

    }
}
