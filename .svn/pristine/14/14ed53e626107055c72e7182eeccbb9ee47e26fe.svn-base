//
//  CPMyCoinViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/10.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPMyCoinViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        self.title = "我的巴币"
        self.navigationController?.navigationBarHidden = false
        view.backgroundColor = Constants.paleBGColor
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        tableView.frame = CGRectMake(0, 80, Constants.screenWidth, tableView.rowHeight * CGFloat(titleArray.count) + 20)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    //MARK: -- 事件响应
    
    
    //MARK: -- delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc:UIViewController
        switch indexPath.row {
        case 0:
            vc = CPBabiIntroduceViewController()
        case 1:
            vc = CPBabiDetailViewController()
        case 2:
            vc = CPTakeBabiViewController()
        default:
            vc = CPBabiIntroduceViewController()
        }
        self.hidesBottomBarWhenPushed=true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    //MARK: --  datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    //MARK: -- 属性
    let tableView: UITableView = {
        let view: UITableView = UITableView()
        view.scrollEnabled = false
        view.contentInset = UIEdgeInsetsMake(-55, 0, 0, 0)
        view.rowHeight = 52
        return view
    } ()
    
    let titleArray: Array = ["巴币介绍", "巴币明细", "玩转巴币"]
}
