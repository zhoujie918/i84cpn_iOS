//
//  CPBabiDetailViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/11.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPBabiDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "巴币明细"
        view.addSubview(babiDetailView)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        babiDetailView.frame = view.frame
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        babiDetailView.tableView.delegate = self
        babiDetailView.tableView.dataSource = self
        babiDetailView.tableView.registerClass(CPBabiDetailTableViewCell.self, forCellReuseIdentifier: cellId)
        babiDetailView.tableView.reloadData()
    }
    
    // MARK: -- delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: -- datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell:CPBabiDetailTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellId) as! CPBabiDetailTableViewCell

        cell.titleLabel.text = "购买学生专线"
        cell.timeLabel.text = "2015年9月12日12:23:05"
        cell.babiLabel.text = String(indexPath.row)
        cell.babiLabel.textColor = Constants.greenWordColor
        return cell
    }
    
    // MARK: -- 属性
    let babiDetailView: CPBabiDetailView = CPBabiDetailView()
    let cellId:String = "babiDetailCell"
}
