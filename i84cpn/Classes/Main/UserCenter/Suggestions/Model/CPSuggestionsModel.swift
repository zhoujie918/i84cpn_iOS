//
//  CPSuggestionsModel.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/6/7.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

protocol SuggestionsLoadDataDelegate : NSObjectProtocol {
    func loadData()
}
// 意见反馈列表
class CPSuggestionsModel: NSObject {
    
    class CPSuggestionsListModel : NSObject {
        var cumId = 0                                  // id
        var totalContent : String?       // 显示内容
        var replyContent : String?      // 回复内容
        var imgs: NSArray?                     // 图片集合
        var category : String?              // 问题分类
        var content : String?                // 留言内容
    }
    var start = 0
    weak var delegate:SuggestionsLoadDataDelegate?
    var sugesstionsList = Array<CPSuggestionsListModel>()
    func getLineList() {
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.getSuggestionsList(), progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    self.sugesstionsList .removeAll()
                    let dicResult: NSDictionary = dic["result"] as! NSDictionary
                    if dicResult.objectForKey("success") as! Bool {
                        let list = dicResult["list"] as! NSArray
                        for dic in list {
//                            let modelTool = DictModelManager.sharedManager
//                            let sug = modelTool.objectWithDictionary(dic as! NSDictionary, cls: CPSuggestionsListModel.self) as? CPSuggestionsListModel
                            let sug = CPSuggestionsListModel()
                            sug.cumId = dic.objectForKey("cumId") as! Int
                            sug.totalContent = dic.objectForKey("totalContent") as? String
                            sug.replyContent = dic.objectForKey("replyContent") as? String
                            sug.imgs = dic.objectForKey("imgs") as? NSArray
                            sug.category = dic.objectForKey("category") as? String
                            sug.content = dic.objectForKey("content") as? String
                            self.sugesstionsList.append(sug)
                            
//                            Constants.dPrint("start: \(self.start) totalContent: \(sug.totalContent)")
                        }
                        if self.delegate != nil {
                            self.delegate?.loadData()
                        }
//
//                        self.start = self.start + list.count
                    }
                }else {
                    let errorCode = dic.objectForKey("errorCode") as? String
                    if errorCode == "00001" {
                        CPUserModel.clearData()
                        CPUserModel.userLogin()
                    }
                    
                }
            }, failureBlock: { (error) in
                print(error)
        })
    }
}
