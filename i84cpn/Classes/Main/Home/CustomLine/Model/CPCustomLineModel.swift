//
//  CPCustomLineModel.swift
//  i84cpn
//
//  Created by 爱巴士-余夏伟 on 16/6/12.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPCustomLineModel: NSObject,DictModelProtocol {

    var stations: [stationsData]?
    var nameList = [String]()
    
    class func getNearStationData(param : NSDictionary,successClosure:(success: CPCustomLineModel?) -> Void , fail: failClosure) {
        
        CPAFHTTPSessionManager.postWithUrlString(Constants.noauthApiURL, parameter: param as [NSObject : AnyObject], progressBlock: nil, successBlock: { (response) in
            let dicResponse : NSDictionary = response as! NSDictionary
//            print("getNearStationData:",dicResponse)
            if (dicResponse["success"]!).intValue == 1{
                let dic = dicResponse["result"] as! NSDictionary
                if  (dic["success"]!).intValue == 1{
                    let modeltool = DictModelManager.sharedManager
                    let model  = modeltool.objectWithDictionary(dic, cls: CPCustomLineModel.self) as? CPCustomLineModel
                    if model?.stations != nil{
                        for name in (model?.stations)! {
                            model?.nameList.append(name.stationName!)
                        }
                    }
                    successClosure(success: model)
                }else{
                    if (dic["msg"] != nil){
                        fail(fail: dic["msg"] as? String)
                    }else{
                        fail(fail: "请求出错")
                    }
                }
            }else{
                if (dicResponse["msg"] != nil){
                    let str = dicResponse["msg"] as? String
                    fail(fail: str)
                }else{
                    fail(fail: "请求出错")
                }
            }
            
        }) { (error) in
            fail(fail: nil)
        }
    }
    
    func swapInValues<T>(inout a:T, inout b: T) {
        let temp = a
        a = b
        b = temp
    }

    
    static func customClassMapping() -> [String : String]? {
        return ["stations" : "\(stationsData.self)"]
    }
}

class stationsData: NSObject {
    var distance: Double = 0    //距离
    var stationId: Int = 0      //站点id
    var longitude: Double = 0   //经度
    var latitude: Double = 0    //纬度
    var stationName: String?    //站点名称
}

