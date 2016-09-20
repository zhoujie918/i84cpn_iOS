//
//  LifeCirCleViewController.swift
//  Bus
//
//  Created by 周杰 on 16/4/25.
//  Copyright © 2016年 周杰. All rights reserved.
//

import UIKit

class CPLifeCirCleController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let lifeTableView=UITableView()
    private var imageArray=["hello","hello","hello","hello"]
    private var titleArray=["萌巴士","线路征集","同学号优秀车长评选","商业街"]
    private var descriptionArray=["以学生科技创新为题材的校园漫画","小伙伴喊你一起搭车回家啦","谁是你心目中的老司机?","别烦恼，让我为您解决生活里的琐碎"]
    private var headerView=UIView()
    var pleaseWaitValue=UILabel()
    var comeSoonPicView=UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(lifeTableView)
        lifeTableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.right.equalTo(self.view).offset(0)
            make.height.equalTo(self.view.bounds.size.height)
        }
        lifeTableView.backgroundColor=COLOR_BACKGROUND_GRAY
        lifeTableView.dataSource=self
        lifeTableView.delegate=self
        lifeTableView.tableFooterView=UIView(frame: CGRectZero)
//        comeSoon picture
//        self.view.addSubview(comeSoonPicView)
//        comeSoonPicView.image=UIImage(named: "comeSoon")
//        comeSoonPicView.snp_makeConstraints { (make) in
//            make.edges.equalTo(self.view).offset(UIEdgeInsetsZero)
//        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor=COLOR_MAIN
        self.navigationController?.navigationBar.tintColor=UIColor.blackColor()
        self.view.backgroundColor=COLOR_BACKGROUND_GRAY
        navigationItem.leftBarButtonItem=UIBarButtonItem.item(self, action: #selector(MessageReminding), image: "icon_msg", highImage: "icon_msg")
        navigationItem.rightBarButtonItem=UIBarButtonItem.item(self, action: #selector(test), image: "icon_ring", highImage: "icon_ring")
    }
    
    func MessageReminding() {
        if CPUserModel.isLogin {
            let vc = CPMessageRemindingViewController()
            self.navigationController!.navigationBar.barTintColor = Constants.whiteBGColor
            vc.hidesBottomBarWhenPushed=true
            self.navigationController!.pushViewController(vc, animated: true)
            //        vc.hideNavi = true
        } else {
            gotoLoginAlertView()
        }
    }
    
    func test() {
        let alertView = UIAlertView(title: "提示", message: "暂待开发", delegate: self, cancelButtonTitle: "确定")
        alertView.show()
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell=lifeTableView.dequeueReusableCellWithIdentifier("cell") as! CPLifeTableViewCell!
        if(cell==nil){
            cell=CPLifeTableViewCell(style: UITableViewCellStyle.Default
                , reuseIdentifier: "cell")
        }
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        cell!.dataLoad(imageArray[indexPath.row], title: titleArray[indexPath.row], description: descriptionArray[indexPath.row])
        return cell!
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let moeVC = CPMoeBusController()
            moeVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(moeVC, animated: true)
        case 1:
            let lineVC = CPLineCollectionController()
            lineVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(lineVC, animated: true)
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func gotoLoginAlertView() {
        view.addSubview(CPNotLoginView(nav: self.navigationController!))
    }
    
}