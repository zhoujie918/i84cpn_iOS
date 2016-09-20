//
//  CPMyCollectionViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/6/14.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPMyCollectionViewController: CMBaseViewController, MyCollectionListDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的征集"
        view.addSubview(myCollectionView)
        myCollectionView.frame = view.frame
        myCollectionView.collectionLineView.collectionListDelegate = self
        myCollectionView.partakeLineView.collectionListDelegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        myCollectionModel.loadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        myCollectionView.loadData(myCollectionModel)
    }
    
    func collection(type: Int, index: Int) {
        self.type = type
        self.index = index
    }
    
    func cancelAction(type: Int, index: Int, attendMsg: String) {
        self.type = type
        self.index = index
        cancelAlertView = CPCollectionCancelAlertView()
        cancelAlertView!.setContent(attendMsg)
        cancelAlertView?.frame = CGRectMake(0, 0, Constants.screenWidth, Constants.screenHeight)
        view.addSubview(cancelAlertView!)
        cancelAlertView?.okButton.addTarget(self, action: #selector(unsubscribe), forControlEvents: .TouchUpInside)
        cancelAlertView?.closeButton.addTarget(self, action: #selector(closeAlertView), forControlEvents: .TouchUpInside)
    }
    
    // 确定退订
    func unsubscribe(button: UIButton) {
        var param: Dictionary<String, AnyObject>?
        
        if type == 0 {
            param = Constants.cancelCollectionLineWithlclrId(myCollectionModel.collectionLineList[index].lclrId!)
        } else {
            param = Constants.cancelMyParTakeLineWithlclrId(myCollectionModel.parTakeLineList[index].attendId!, type: myCollectionModel.parTakeLineList[index].type!)
        }
        cancelAlertView?.removeFromSuperview()
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.mode = MBProgressHUDMode.Text
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: param, progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    let objData: NSDictionary = dic["result"] as! NSDictionary
                    if objData.objectForKey("success")  as! Bool {
                        hud.labelText = "取消成功"
                        hud.hide(true, afterDelay: 1)
                        if self.type == 0 {
                            self.myCollectionView.collectionLineView.removeMyCollectionLineListAtIndex(self.index)
                        } else {
                            self.myCollectionView.partakeLineView.removePartakeLineListAtIndex(self.index)
                        }
                    } else {
                        hud.labelText = objData.objectForKey("msg") as? String
                        hud.hide(true, afterDelay: 1)
                    }
                } else {
                    hud.hide(false)
                }
            }, failureBlock: { (error) in
                print(error)
        })
    }
    
    func closeAlertView(button: UIButton) {
        cancelAlertView?.removeFromSuperview()
    }
    

    
    var type = 0
    var index = 0
    var myCollectionModel = CPMyCollectionModel()
    private let myCollectionView = CPMyCollectionView()
    private var cancelAlertView: CPCollectionCancelAlertView?
}
