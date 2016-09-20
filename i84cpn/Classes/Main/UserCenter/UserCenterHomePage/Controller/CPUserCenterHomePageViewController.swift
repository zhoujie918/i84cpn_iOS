//
//  CPUserCenterHomePageViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/9.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPUserCenterHomePageViewController: CMBaseViewController, UITableViewDelegate, UITableViewDataSource, UserModelDelegate, SwitchCityDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(userCenterHomePageView)
        userCenterHomePageView.frame = view.frame
        userCenterHomePageView.tableView.frame = view.frame
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        
        userCenterHomePageView.tableView.delegate = self
        userCenterHomePageView.tableView.dataSource = self
        
        navigationItem.leftBarButtonItem=UIBarButtonItem.item(self, action: #selector(MessageReminding), image: "icon_msg", highImage: "icon_msg")
        navigationItem.rightBarButtonItem=UIBarButtonItem.item(self, action: #selector(test), image: "icon_ring", highImage: "icon_ring")
        CPUserModel.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(userInfoReloadData),
                                                         name: "reloadUserInfo", object: nil)
        
        
        userCenterHomePageView.headViewBGButton.addTarget(self, action: #selector(personInfo), forControlEvents: .TouchUpInside)
        userCenterHomePageView.personInfomationButton.addTarget(self, action: #selector(personInfo), forControlEvents: .TouchUpInside)
        userCenterHomePageView.quitButton.addTarget(self, action: #selector(quit), forControlEvents: .TouchUpInside)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController!.navigationBar.barTintColor = Constants.mainColor
        
        // 查看是否可以更新
        getVersion()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if firstReloadData {
            userCenterHomePageView.tableView.reloadData()
            firstReloadData = !firstReloadData
        }
    }
    
    
    func getVersion() {
        if canUpdate {
            userCenterHomePageView.reloadData()
            return
        }
        CPAFHTTPSessionManager.postWithUrlString(Constants.noauthApiURL, parameter: Constants.getVersion(), progressBlock: nil, successBlock: { (respondData) in
            let dic:NSDictionary = respondData as! NSDictionary
            let rsp: Bool = dic["success"] as! Bool
            if rsp { 
                let objData: NSDictionary = dic["result"] as! NSDictionary
                if objData.objectForKey("success") as! Bool {
                    if objData.count > 1 {
                        let code = objData.objectForKey("code")  as! Int
//                        if NSUserDefaults.standardUserDefaults().valueForKey("build") == nil {
//                            NSUserDefaults.standardUserDefaults().setObject(20160615, forKey: "build")
//                            //设置同步
//                            NSUserDefaults.standardUserDefaults().synchronize()
//                        }
//                        let buildVersion = NSUserDefaults.standardUserDefaults().valueForKey("build") as! Int
                        let buildVersion = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
                        self.updateUrlStr = objData.objectForKey("url") as! String
//                        if code >= buildVersion {
                        if String(code) != buildVersion {
                            self.canUpdate = true
                            NSUserDefaults.standardUserDefaults().setObject(code, forKey: "build")
                            //设置同步
                            NSUserDefaults.standardUserDefaults().synchronize()
                            let indexPath = NSIndexPath(forRow: 2, inSection: 2)
                            self.userCenterHomePageView.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                        }
                    }
                }
            }
            self.userCenterHomePageView.reloadData()
        }) { (error) in
            Constants.dPrint(error)
        }
    }
    
    func userInfoReloadData() {
         userCenterHomePageView.reloadData()
    }
    
    func changeCityName() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 1)
        userCenterHomePageView.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
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
    
    func openURL(urlStr: String) {
        let url = NSURL.init(string: urlStr)
        UIApplication.sharedApplication().openURL(url!)
    }
        
    // 事件响应

    func quit(button: UIButton) {
        if CPUserModel.getLoginState() {
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            CPAFHTTPSessionManager.getJsonWithUrlString(Constants.userLogoutURL, parameter: nil, progressBlock: { (progress) in
                
                }, successBlock: { (respondData) in
                    
                    let dic:NSDictionary = respondData as! NSDictionary
                    let success: Bool = dic["success"] as! Bool
                    if success == true {
                        hud.labelText = "退出成功"
                        hud.hide(true, afterDelay: 1)
                        CPUserModel.clearData()
                        NSUserDefaults.standardUserDefaults().setObject("", forKey: "UserNameKey")
                        NSUserDefaults.standardUserDefaults().setObject("", forKey: "PwdKey")
                        
                        //设置同步
                        NSUserDefaults.standardUserDefaults().synchronize()
                        self.userCenterHomePageView.reloadData()
                        JPUSHService.setAlias(nil, callbackSelector: nil, object: self)
                    }
            }) { (error) in
                print(error)
            }
        }
        
    }
    
    func personInfo(button: UIButton) {
        if !CPUserModel.getLoginState() {
            gotoLoginAlertView()
        } else {
            let vc = CPUserInfoViewController()
            self.hidesBottomBarWhenPushed=true
            self.navigationController!.navigationBar.barTintColor = Constants.whiteBGColor
            self.navigationController?.pushViewController(vc, animated: true)
            self.hidesBottomBarWhenPushed=false
        }
    }
    
    func gotoLoginAlertView() {
        view.addSubview(CPNotLoginView(nav: self.navigationController!))
    }
    
    //MARK:--  datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return titleArray1.count
        case 1:
            return titleArray2.count
        case 2:
            return titleArray3.count
        case 3:
            return titleArray4.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell
//        if indexPath.section == 0 && indexPath.row == 0 { // 巴币
//            let cell = CPCoinCell()
//            cell.titileLabel.text = titleArray1[indexPath.row]
////            cell.coinLabel.text = "1000"
//            let line = Constants.splitLine()
//            cell.addSubview(line)
//            line.snp_makeConstraints(closure: { (make) in
//                make.bottom.equalTo(cell.snp_bottom)
//                make.left.equalTo(cell).offset(inset)
//                make.right.equalTo(cell).offset(-inset)
//                make.height.equalTo(1)
//            })
//            return cell
//        } else
        if indexPath.section == 2 && indexPath.row != 0 {
            if indexPath.row == 1 { // 客服热线
                cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "ab")
//                cell.textLabel?.font = Constants.mediumFont
                cell.detailTextLabel?.text = "服务时间6:00-21:00"
                cell.detailTextLabel?.font = Constants.superSmallFont
                let line = Constants.splitLine()
                cell.addSubview(line)
                line.snp_makeConstraints(closure: { (make) in
                    make.bottom.equalTo(cell.snp_bottom)
                    make.left.equalTo(cell).offset(inset)
                    make.right.equalTo(cell).offset(-inset)
                    make.height.equalTo(1)
                })
                cell.selectionStyle = .None
            } else { // 版本
                let cell = CPVersionCell()
                cell.titleLabel.text = titleArray3[indexPath.row]
                cell.detailLabel.text = NSUserDefaults.standardUserDefaults().valueForKey("appVersion") as? String
                if canUpdate {
                    cell.setShow()
                }
                let line = Constants.splitLine()
                cell.addSubview(line)
                line.snp_makeConstraints(closure: { (make) in
                    make.bottom.equalTo(cell.snp_bottom)
                    make.left.equalTo(cell).offset(inset)
                    make.right.equalTo(cell).offset(-inset)
                    make.height.equalTo(1)
                })
                cell.selectionStyle = .None
                return cell
            }
        } else if indexPath.section == 1  {
            let cell = CPCityCell()
            if NSUserDefaults.standardUserDefaults().valueForKey("defaultCityName") != nil {
                cell.cityLabel.text = NSUserDefaults.standardUserDefaults().valueForKey("defaultCityName") as? String
            } else {
                cell.cityLabel.text = "福州"
            }
            let line = Constants.splitLine()
            cell.addSubview(line)
            line.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(cell.snp_bottom)
                make.left.equalTo(cell).offset(inset)
                make.right.equalTo(cell).offset(-inset)
                make.height.equalTo(1)
            })
            cell.selectionStyle = .None
            return cell
        } else {
            cell = UITableViewCell()
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            let line = Constants.splitLine()
            cell.addSubview(line)
            line.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(cell.snp_bottom)
                make.left.equalTo(cell).offset(inset)
                make.right.equalTo(cell).offset(-inset)
                make.height.equalTo(1)
            })
        }
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = titleArray1[indexPath.row]
        case 1:
            cell.textLabel?.text = titleArray2[indexPath.row]
        case 2:
            cell.textLabel?.text = titleArray3[indexPath.row]
        case 3:
            cell.textLabel?.text = titleArray4[indexPath.row]
        default:
            cell.textLabel?.text = ""
        }
//        cell.selectionStyle = .None
        return cell
    }
    
    func getViewWithIndex(indexPath: NSIndexPath) -> UIViewController {
        var vc: UIViewController?
        self.navigationController!.navigationBar.barTintColor = Constants.whiteBGColor
        if indexPath.section == 0 {
//            if indexPath.row == 0 {
//                vc = CPMyCoinViewController()
//            } else if indexPath.row == 1 {
//                vc  = CPMyOrdersViewController()
//            } else if indexPath.row == 2 {
//                vc = CPMyCollectionViewController()
//            } else if indexPath.row == 3 {
//                vc = CPPassengerInfoViewController()
//            }
            if indexPath.row == 0 {
                vc = CPMyOrdersViewController()
            } else if indexPath.row == 1 {
                vc  = CPMyCollectionViewController()
            } else if indexPath.row == 2 {
                vc = CPPassengerInfoViewController()
            }
        } else if indexPath.section == 1 {
//            if indexPath.row == 0 {
//                vc = CPMyCoinViewController()
//            } else if indexPath.row == 1 {
//                vc = CPCitySwitchViewController()
//            }
            vc = CPCitySwitchViewController()
            (vc as! CPCitySwitchViewController).delegate = self;
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                vc = CPAbout5i84ViewController()
            }
        } else if indexPath.section == 3 {
            if indexPath.row == 0 {
                vc = CPSuggestionsViewController()
            } else if indexPath.row == 1 {
                vc = CPFAQsViewController()
            }
        }
        return vc!
    }
    
    // MARK:-- delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 && indexPath.row != 0 {
            if indexPath.row == 1 {
                let phoneCallUrl = NSURL(string: "tel://4008885284")
                UIApplication.sharedApplication().openURL(phoneCallUrl!)
            } else {
                if canUpdate {
                    let updateUrl = NSURL(string: updateUrlStr)
                    UIApplication.sharedApplication().openURL(updateUrl!)
                }
            }
        } else {
            if indexPath.section == 3 && indexPath.row == 1 {
                let vc = CPFAQsViewController()
                self.navigationController!.navigationBar.barTintColor = Constants.whiteBGColor
                vc.hidesBottomBarWhenPushed=true
                self.navigationController!.pushViewController(vc, animated: true)
            } else if !CPUserModel.getLoginState() && indexPath.section != 1 && indexPath.section != 2 {
                gotoLoginAlertView()
            } else {
                let vc = getViewWithIndex(indexPath)
                vc.hidesBottomBarWhenPushed=true
                self.navigationController!.pushViewController(vc, animated: true)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    //MARK: -- 属性
    private var firstReloadData = true
    private var canUpdate = false
    private var updateUrlStr = ""
    let userCenterHomePageView: CPUserCenterHomePageView = CPUserCenterHomePageView()

    private let inset = 15
//    let titleArray: Array = ["我的巴币", "我的订单", "我的线路", "乘客信息" ,"首页菜单设置", "城市切换", "关于我们", "点击拨打热线客服电话", "当前版本", "意见反馈", "常见问题及解答"];
//    private let titleArray1: Array = ["我的巴币", "我的订单", "我的征集", "乘客信息"];
    private let titleArray1: Array = ["我的订单", "我的征集", "乘客信息"];
//    private let titleArray2: Array = ["首页菜单设置", "城市切换"];
    private let titleArray2: Array = ["城市切换"];
    private let titleArray3: Array = ["关于我们", "点击拨打客服热线", "当前版本"];
//    let titleArray3: Array = ["关于我们", "点击拨打热线客服电话"];
    private let titleArray4: Array = ["意见反馈", "常见问题及解答"];
}
