//
//  CPPaidOrderDetailModel.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/6/16.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPPaidOrderDetailModel: NSObject,DictModelProtocol {
    
    
    var lineType: Int?
    var station: String?
    var stationTime: String?
    var offStationId: Int?
    var onStationId: Int?
    var lineName: String?
    var lineId: Int?
    var classId: Int?
    var issueId: Int?
    var antipateMileage: String?
    var antipateTime: Float?
    var stationList: [StationList]?
    
    class func getLineDetailData(dic : NSDictionary) -> CPPaidOrderDetailModel {
        
        let modelTool = DictModelManager.sharedManager
        let model = modelTool.objectWithDictionary(dic, cls: CPPaidOrderDetailModel.self) as? CPPaidOrderDetailModel
        return model!
        
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["stationList" : "\(StationList.self)"]
    }
}



