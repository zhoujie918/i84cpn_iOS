//
//  CPCanceledViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/25.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit
protocol CanceledViewDelegate : NSObjectProtocol {
    func pushView(index:Int, orderId: Int)
}
class CPCanceledViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(statusView)
        statusView.imageView.image = UIImage(named: "img_loading")
        statusView.statusLabel.text = "正在拼命加载中\n请稍等"
        statusView.imageView.hidden = true
        
        view.addSubview(orderListView)
        orderListView.hidden = true
        
        orderListView.frame = view.frame
        statusView.frame = view.frame
        statusView.imageView.hidden = false
        
        orderListView.tableView.registerClass(CPOrdersTableViewCell.self, forCellReuseIdentifier: cellId)
        orderListView.tableView.dataSource = self
        orderListView.tableView.delegate = self
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let orderId = dataArray![indexPath.row].objectForKey("order_id") as! Int
        if (delegate != nil) {
            delegate?.pushView(4,  orderId: orderId)
        }
    }
    
    func getData() {
        CPAFHTTPSessionManager.postWithUrlString(Constants.userInfoURL, parameter: Constants.getOrderList(4), progressBlock: { (progress) in
            
            }, successBlock: { (respondData) in
                let dic:NSDictionary = respondData as! NSDictionary
                let rsp: Bool = dic["success"] as! Bool
                if rsp {
                    self.dataArray = dic["result"] as? NSArray
                    if self.dataArray?.count != 0 {
                        self.statusView.hidden = true
                        self.orderListView.hidden = false
                        self.orderListView.tableView.reloadData()
                    } else {
                        self.statusView.hidden = false
                        self.orderListView.hidden = true
                        self.statusView.imageView.image = UIImage(named: "img_null")
                        self.statusView.statusLabel.text = "这里没有任何订单哦！"
                    }
                } else {
                    print(dic)
                }
            }, failureBlock: { (error) in
                print(error)
        })
    }
    
    //MARK:-- datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArray == nil {
            return 0
        }
        return dataArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CPOrdersTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellId) as! CPOrdersTableViewCell
        cell.routeLabel.text = dataArray![indexPath.row].objectForKey("lineName") as? String
        cell.detailLabel.text = (dataArray![indexPath.row].objectForKey("order_time") as! String) + "下单"
        let status = dataArray![indexPath.row].objectForKey("order_state") as! String
        cell.setStatus(atoi(status))
        return cell
    }
    
    weak var delegate:CanceledViewDelegate?
    private let cellId = "orderCellId"
    private let orderListView = CPOrderListView()
    private var dataArray: NSArray?
    private let statusView = CPOrderWaitView()
}
