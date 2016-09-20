//
//  CPRealTimeCarModel.swift
//  i84cpn
//
//  Created by 爱巴士-余夏伟 on 16/6/1.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

typealias failClosure = (fail : String?) -> Void

//MARK: 用户预订路线
class CPRealTimeCarModel: NSObject {
    
    var obj : [UserLineData]?
    
    class func getUserLineData(successClosure:(success: CPRealTimeCarModel?) -> Void , fail: failClosure) {
        
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: ["action" : "order_line_list"], progressBlock: nil, successBlock: { (response) in
            let dicResponse : NSDictionary = response as! NSDictionary
//            print("UserLineData:",dicResponse)
            if (dicResponse["success"]!).intValue == 1{
                let dic = dicResponse["result"] as! NSDictionary
                if  (dic["success"]!).intValue == 1{
                    let obj = dic["obj"] as! NSArray
                    if obj.count != 0{
                        let modeltool = DictModelManager.sharedManager
                        let model  = modeltool.objectWithDictionary(dic, cls: CPRealTimeCarModel.self) as? CPRealTimeCarModel
                        successClosure(success: model)
                    }else{
                        fail(fail: "暂时无法获取线路")
                    }
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
                print(error)
                fail(fail: nil)
        }
    }
}

class UserLineData: NSObject {
    var plate_no: Int = 0   //车号
    var line_id: Int = 0    //线路ID
    var classes_id: Int = 0 //班次id
    var line_no: Int = 0    //线路号   (请求线路信息及GPS信息时用此线路号)
    var is_up_down: Int = 0 //上下行   (0=上行，1=下行)
    var lineName: Int = 0   //线路名
}


//MARK: 线路规划详细信息
class LineDetailModel: NSObject,DictModelProtocol {
    
    var linePointLt: [LinePointList]?  //线路规划的点列表
    var stationLt: [StationList]?      //站点列表
    
    class func getLineDetailData(param : NSDictionary , successClosure:(success: LineDetailModel) -> Void , fail:failClosure) {
        
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter:param as [NSObject : AnyObject], progressBlock: nil, successBlock: { (response) in
            let dicResponse : NSDictionary = response as! NSDictionary
            print("getLineDetailData:",dicResponse)
            if  (dicResponse["result"]?["success"]!)?.intValue == 1 {
                let dic : NSDictionary = dicResponse["result"]!["obj"] as! NSDictionary
                let modelTool = DictModelManager.sharedManager
                let model = modelTool.objectWithDictionary(dic, cls: LineDetailModel.self) as? LineDetailModel
                successClosure(success: model!)
            }else{
                if (dicResponse["msg"] != nil){
                    fail(fail: dicResponse["msg"] as? String)
                }else{
                    fail(fail: "请求出错")
                }
            }
            
        }) { (error) in
            fail(fail: "请求出错")
            
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["linePointLt" : "\(LinePointList.self)", "stationLt" : "\(StationList.self)"]
    }
}

class LinePointList: NSObject {
    var LATITUDE: Double = 0.0  //纬度
    var IS_UP_DOWN: Int = -1    //方向    (0=上行，1=下行)
    var LONGITUDE: Double = 0.0 //经度
    var LIN_NO: Int = 0 //线路号
    var ORDER_NO: Int = 0   //点序
    var DIS: Double = 0.0   //距离
}

class StationList: NSObject {
    var stationName: String?    //站点名称
    var longitude: Double = 0.0 //站点经度
    var latitude: Double = 0.0  //站点纬度
    var stationType: String?    //站点类型  (普通站点=0，学校站点=1)
    var type: String?       //类型   (实际站点=0，辅助站点=1   0表示该线路出售的站点，1表示不出售的站点（用于辅助百度地图画线路)）
    var station: String?    //辅助站点名称
    var departTime: String? //发车时间  (如：06:00)
    var sort: Int = 0       //站点排序
    var station_id: Int = 0 //站点id
}


//MARK: 车辆实时GPS信息
class CarGPSModel: NSObject{
    
    var BUS_NO: Int = 0      //车号
    var LINE_NO: Int = 0     //线路编号
    var FILA_NO: Int = 0     //分公司编号
    var SITE_TIME: Int = 0   //定位时间
    var LNG: Double = 0.0    //经度
    var LAT: Double = 0.0    //纬度
    var IS_UP_DOWN: Int = 0  //方向    (0=上行，1=下行)
    var RUN_STATE: Int = 0   //状态    (1=运营，0=非运营)
    var IS_STATION: Int = 0  //最近到达的站序
    var RUN_DISTANCE: Double = 0.0    //与首站距离 (车辆当前距离首站的线路距离，绝对值<=30米判断为到达站点)
    var INS_TIME: Int = 0    //入库时间
    
    class func getCarGPSData(param : NSDictionary , successClosure:(success: CarGPSModel) -> Void , fail:failClosure) {
        
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter:param as [NSObject : AnyObject], progressBlock: nil, successBlock: { (response) in
            let dicResponse : NSDictionary = response as! NSDictionary
            print("GPSData :",dicResponse)
            if  (dicResponse["result"]?["success"]!)?.intValue == 1 {
                if (dicResponse["result"]?["obj"] as! NSArray).count != 0{
                    let array : NSArray = dicResponse["result"]!["obj"] as! NSArray
                    let modelTool = DictModelManager.sharedManager
                    let model = modelTool.objectWithDictionary(array[0] as! NSDictionary, cls: CarGPSModel.self) as? CarGPSModel
                    successClosure(success: model!)
                }
            }else{
                if (dicResponse["msg"] != nil){
                    fail(fail: dicResponse["msg"] as? String)
                }else{
                    fail(fail: "请求出错")
                }
            }
            
        }) { (error) in
            fail(fail: "请求出错")
        }
    }
}




