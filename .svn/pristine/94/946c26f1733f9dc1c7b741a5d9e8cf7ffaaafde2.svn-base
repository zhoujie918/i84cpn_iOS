 //
//  CPHomePageViewController.swift
//  i84cpn
//
//  Created by 周杰 on 16/5/24.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit


class CPHomePageController: UIViewController,homeDelegate {
    private var homePageView=CPHomePageView()
    private var homePageModel=CPHomePageModel()

    var orgOrderId:Int!
    var comId:Int!
    
    var cityIdStr:String=""
    var newCityId:Int!
    var newCityIdStr:String!
    
    //获取接口数据，学校站点名称和年级
    let paraSchoolAction=["action":"line_station"]
    let paraGradeAction=["action":"line_class"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="搜线路"
        self.automaticallyAdjustsScrollViewInsets=false

        self.navigationController?.navigationBar.barTintColor=COLOR_MAIN
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        homePageView.delegate=self
        homePageView.switchButton.canDrawRect=true
        
        if orgOrderId == nil {
            self.navigationItem.leftBarButtonItem=UIBarButtonItem.item(self, action: #selector(self.onClick), image: "icon_msg", highImage: "icon_msg")
            self.navigationItem.rightBarButtonItem=UIBarButtonItem.item(self, action: #selector(test), image: "icon_ring", highImage: "icon_ring")
        }
        self.navigationController?.navigationBar.translucent=false
        self.view.addSubview(homePageView)
        homePageView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).offset(UIEdgeInsetsZero)
        }

        homePageView.initWithClosure({ (tag) in
//            let alert = UIAlertView.init(title: "提示", message: "努力开发中...", delegate: nil, cancelButtonTitle: "取消")
//            alert.show()
            let realTimeVC = CPRealTimeCarController()
            realTimeVC.hidesBottomBarWhenPushed=true
            self.navigationController?.pushViewController(realTimeVC, animated: true)
        })
        self.homePageView.orgOrderId=orgOrderId
    }
    
    func goNextCtl(tag: Int) {
        if tag==11 {
            if homePageView.schoolValue==nil {
                let alertView=UIAlertView(title: "提示", message: "请选择学校", delegate: self, cancelButtonTitle: "确定")
                alertView.show()
            }
            else if homePageView.gradeValue==nil {
                let alertView=UIAlertView(title: "提示", message: "请选择年级", delegate: self, cancelButtonTitle: "确定")
                alertView.show()
            }
            else {
                let addressCtl=CPAddressSearchController()
                addressCtl.schoolValue=homePageView.schoolValue
                addressCtl.gradeValue=homePageView.gradeValue
                addressCtl.singleTrip=homePageView.singleTrip
                addressCtl.switchTag=homePageView.switchButton.switcherTag
                addressCtl.orgOrderId=orgOrderId
                addressCtl.comId=comId
                
                addressCtl.hidesBottomBarWhenPushed=true
                self.navigationController?.pushViewController(addressCtl, animated: true)
            }
        }else if tag==12{
            let vc=CPCustomLineController()
            vc.hidesBottomBarWhenPushed=true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    //获取学校站点
    func getSchoolData(){
        weak var weakSelf=self
        homePageModel.dropSchoolLoadData(Constants.noauthApiURL, para: ["action":"line_station", "cityId":cityIdStr]) { (success) in
            weakSelf?.homePageView.schoolData=success
        }
    }
    //获取年级
    func getGradeData(){
        weak var weakSelf=self
        homePageModel.dropGradeLoadData(Constants.noauthApiURL, para: paraGradeAction) { (success) in
            weakSelf?.homePageView.gradeData=success
        }
    }
    
    func onClick(){
        if CPUserModel.isLogin {
            let vc = CPMessageRemindingViewController()
            self.navigationController!.navigationBar.barTintColor = Constants.whiteBGColor
            vc.hidesBottomBarWhenPushed=true
            self.navigationController!.pushViewController(vc, animated: true)
        } else {
            gotoLoginAlertView()
        }
    }
    
    func test() {
        let alertView = UIAlertView(title: "提示", message: "暂待开发", delegate: self, cancelButtonTitle: "确定")
        alertView.show()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor=COLOR_MAIN
        IQKeyboardManager.sharedManager().enable=false
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(CPHomePageController.showRealtimeCarView),
                                                         name: "ShowRealtimeCar", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(CPHomePageController.hideRealtimeCarView),
                                                         name: "HideRealtimeCar", object: nil)
        if CPUserModel.isLogin == false {
            CPUserModel.userLogin()
        } else {
            CPUserModel.hasPaidOrder()
        }
        
        newCityId = NSUserDefaults.standardUserDefaults().valueForKey("cityId") as! Int
        newCityIdStr=String(newCityId)
        if (cityIdStr != newCityIdStr){
            cityIdStr=newCityIdStr
            getSchoolData()           //获取学校和年级数据
            getGradeData()
        }

    }
    
    func showRealtimeCarView() {
        homePageView.showRealTimeCar()
    }
    
    func hideRealtimeCarView() {
        homePageView.hideRealTimeCar()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.sharedManager().enable=true
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func gotoLoginAlertView() {
        view.addSubview(CPNotLoginView(nav: self.navigationController!))
    }
    
}
