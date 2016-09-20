//
//  HomePageObject.swift
//  i84cpn
//
//  Created by 周杰 on 16/5/9.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

//闭包类型别名

class CPHomePageModel: NSObject {
    typealias callBackFun=(success:NSMutableArray)->()  //闭包逆向传值
    
    var stationName:String!             //学校站点名称
    var dict_name:String!               //年级名称
    var dict_code:String!               //年级代码

    var stationNameArray=NSMutableArray()
    var dictNameArray=NSMutableArray()
    var emptyArray=NSMutableArray()
    
    //过滤model中不存在的键值
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    //学校站点数据加载，闭包逆向传值
    func dropSchoolLoadData(postURL:String,para:NSMutableDictionary,closure:callBackFun){
        CPAFHTTPSessionManager.postWithUrlString(postURL, parameter: para as [NSObject : AnyObject], progressBlock: nil, successBlock: { (responseData) in
            if responseData == nil{
                return
            }
            self.stationNameArray.removeAllObjects()
            if(responseData.objectForKey("success") as! Bool){
                if (responseData.objectForKey("result")?.count != nil)&&(responseData.objectForKey("result")?.count != 0){
                    let result=responseData.objectForKey("result")!
                    for i in 0...result.count-1 {
                        self.setValuesForKeysWithDictionary((result as! NSArray)[i] as! [String : AnyObject])
                        self.stationNameArray.addObject(self.stationName)
                    }
                    closure(success: self.stationNameArray)
                }else{
                   closure(success: self.emptyArray)
                }
                
            }
            else{
                print("学校站点数据结果:",responseData)
                let msg=responseData.objectForKey("msg") as! String
                let alertView=UIAlertView(title: "提示", message: msg, delegate: self, cancelButtonTitle: "确定")
                alertView.show()
            }
            }) { (error) in
                print(error)
        }
    }
    
    
    //年级下拉框数据加载，闭包传值
    func dropGradeLoadData(postURL:String,para:[String:AnyObject],closure:callBackFun)  {
        CPAFHTTPSessionManager.postWithUrlString(postURL, parameter: para, progressBlock: nil, successBlock: { (responseData) in
            if responseData == nil{
                return
            }
            self.dictNameArray.removeAllObjects()
            if(responseData.objectForKey("success") as! Bool){
                if (responseData.objectForKey("result")?.count != nil)&&(responseData.objectForKey("result")?.count != 0){
                    let result=responseData.objectForKey("result")!
                    for i in 0...result.count-1 {
                        self.setValuesForKeysWithDictionary((result as! NSArray)[i] as! [String : AnyObject])
                        self.dictNameArray.addObject(self.dict_name)
                    }
                    closure(success: self.dictNameArray)
                }else{
                    closure(success: self.emptyArray)
                }
                
            }
            else{
                print("年级下拉框数据结果:",responseData)
                let msg=responseData.objectForKey("msg") as! String
                let alertView=UIAlertView(title: "提示", message: msg, delegate: self, cancelButtonTitle: "确定")
                alertView.show()
            }
        }) { (error) in
            print(error)
        }
    }

    
}
