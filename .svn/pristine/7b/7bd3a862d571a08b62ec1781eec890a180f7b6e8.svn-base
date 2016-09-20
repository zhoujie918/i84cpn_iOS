//
//  CPHistoryViewController.swift
//  i84cpn
//
//  Created by Benjamin on 16/5/27.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPHistoryViewController: CMBaseViewController, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "申请记录"
        view.addSubview(historyView)
        historyView.frame = view.frame
        
        historyView.tableView.registerClass(CPHistoryTableViewCell.self, forCellReuseIdentifier: cellId)
        historyView.tableView.dataSource = self
        historyView.tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(getData))
        historyView.tableView.mj_header.beginRefreshing()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
   
    
    func getData() {
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.getHistoryOfRelevanceInfo(), progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    self.arrayData = dic["result"] as? NSArray
                    self.historyView.tableView.reloadData()
                } else {
                    let errorCode = dic.objectForKey("errorCode") as? String
                    if errorCode == "00001" {
                        CPUserModel.clearData()
                        CPUserModel.userLogin()
                    }
                }
                self.historyView.tableView.mj_header.endRefreshing()
            }) { (error) in
                self.historyView.tableView.mj_header.endRefreshing()
                print(error)
        }
    }
    
    // datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayData == nil || arrayData?.count == 0 {
            if statusView == nil {
                statusView = CPStatusView()
                statusView!.frame = self.view.frame
                self.view.addSubview(statusView!)
            }
            return 0
        } else {
            if statusView != nil {
                statusView?.removeFromSuperview()
            }
        }
        return (arrayData?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let date = arrayData![indexPath.row].objectForKey("applyDate") as! String
        let phoneNum = arrayData![indexPath.row].objectForKey("mobile") as! String
        let name = arrayData![indexPath.row].objectForKey("psgName") as! String
        let detail = arrayData![indexPath.row].objectForKey("applyContent") as! String
        let state = arrayData![indexPath.row].objectForKey("applyStatus") as! Int
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId) as! CPHistoryTableViewCell
        cell.setCell(date, phoneNum: phoneNum, name:  name, detail: detail, state: state)
        return cell
    }
    
    let cellId = "historyCell"
    private var arrayData: NSArray?
    private var statusView : CPStatusView?
    let historyView = CPHistoryView()
}
