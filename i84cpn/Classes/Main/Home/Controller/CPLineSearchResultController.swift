//
//  CPLineSearchResultController.swift
//  i84cpn
//
//  Created by 周杰 on 16/5/10.
//  Copyright © 2016年 5i84. school rights reserved.
//  线路查询结果

import UIKit

class CPLineSearchResultController: UIViewController,lineSearchResultDelegate,UIAlertViewDelegate {
    
    //地址搜索页传递过来的请求参数
    var schoolAddress:String?
    var houseAddress:String?
    var grade:String?
    var gradeNo:String!
    var houseLon:Double?
    var houseLat:Double?
    var rang:Int?
    var departType:Int?     //1出发地，0目的地
    
    //线路查询结果页得到的线路参数，即将作为线路详情页的请求参数
    var issueId:AnyObject!
    var classesId:AnyObject!
    var lineId:Int!
    var issueIdBack:AnyObject!
    var classesIdBack:AnyObject!
    var lineIdBack:Int!
    
    var issueIdArrayRecom=NSMutableArray()
    var classesIdArrayRecom=NSMutableArray()
    var lineIdArrayRecom=NSMutableArray()
    
    var issueIdArraySchool=NSMutableArray()
    var classesIdArraySchool=NSMutableArray()
    var lineIdArraySchool=NSMutableArray()
    
    var issueIdArrayRecomBack=NSMutableArray()
    var classesIdArrayRecomBack=NSMutableArray()
    var lineIdArrayRecomBack=NSMutableArray()
    
    var issueIdArraySchoolBack=NSMutableArray()
    var classesIdArraySchoolBack=NSMutableArray()
    var lineIdArraySchoolBack=NSMutableArray()
    
    var selectedRowRecom:Int!            //线路搜索页推荐线路选中的行数
    var selectedRowSchool:Int!            //线路搜索页学校线路选中的行数
    
    var recommadLineDic=NSMutableDictionary()
    var schoolLineDic=NSMutableDictionary()
    var lineInfoDicW=NSMutableDictionary()
    var lineInfoDicF=NSMutableDictionary()
    
    var orgOrderId:Int!
    var comId:Int!
    var comIdString:String!
    var cityId:Int!
    var cityIdString:String!
    
    //分页参数
    var startIndexRec=0
    var startIndexScho=0
    var limit=10
    
    private var recommandLineController=UIViewController()      //推荐线路controller
    private var schoolLineController=UIViewController()            //全部线路controller
    
    private var recommandLineResultView=CPLineSearchResultView()//推荐线路view
    private var schoolLineResultView=CPLineSearchResultView()      //全部线路view
    
    private var lineSearchResultModel=CPLineSearchResultModel() //model层
    private var lineSearchResultSchoolModel=CPLineSearchResultModel() //model层
    private var lineResultCell=CPLineResultTableViewCell()
    private let statusView = CPOrderWaitView()  //等待加载页
    
    var skScNavC=SKScNavViewController(show: true)
    var scNavBar:SKScNavBar!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor=COLOR_BACKGROUND_GRAY
        self.navigationController?.navigationBar.barTintColor=UIColor.whiteColor()
        self.title="查询结果"
        
        recommandLineResultView.lineType=1
        schoolLineResultView.lineType=2
        cityId = NSUserDefaults.standardUserDefaults().valueForKey("cityId") as! Int
        
        //设置参数
        setLineInfoParas()
        
        //推荐线路
        recommandLineController.title="推荐线路"
        recommandLineController.view.addSubview(recommandLineResultView)
        recommandLineResultView.backgroundColor=COLOR_BACKGROUND_GRAY
        recommandLineResultView.snp_makeConstraints { (make) in
            make.top.equalTo(recommandLineController.view).offset(0)
            make.left.equalTo(recommandLineController.view).offset(0)
            make.height.equalTo(recommandLineController.view.frame.height)
            make.right.equalTo(recommandLineController.view).offset(0)
        }
        weak var weakSelf = self
        //前往订制路线页面
        recommandLineResultView.initWithClosure({ (tag) in
            let customVC = CPCustomLineController()
            weakSelf?.navigationController?.pushViewController(customVC, animated: true)
        })
        
        //全部线路
        schoolLineController.title="\(schoolAddress!)全部线路"
        schoolLineController.view.addSubview(schoolLineResultView)
        schoolLineResultView.backgroundColor=COLOR_BACKGROUND_GRAY
        schoolLineResultView.snp_makeConstraints { (make) in
            make.top.equalTo(schoolLineController.view).offset(0)
            make.left.equalTo(schoolLineController.view).offset(0)
            make.height.equalTo(schoolLineController.view.frame.height)
            make.right.equalTo(schoolLineController.view).offset(0)
        }
        //前往订制路线页面
        schoolLineResultView.initWithClosure({ (tag) in
            let customVC = CPCustomLineController()
            weakSelf?.navigationController?.pushViewController(customVC, animated: true)
        })
        
        //滑动导航视图
        skScNavC = SKScNavViewController(subViewControllers: [recommandLineController,schoolLineController])
        skScNavC.addParentController(self)
        
            //rang==1,单程
            if(rang==1){
                recomDataLoad()
                schoolDataLoad()
            }
                //rang=0，双程
            else if(rang==0){
                recomDataLoad2()
                schoolDataLoad2()
            }
        if(orgOrderId != nil){
            self.recommandLineResultView.orgOrderId=orgOrderId
            self.schoolLineResultView.orgOrderId=orgOrderId
        }
        lineResultCell.cellGest.addTarget(self, action: #selector(CPLineSearchResultController.goLineInfoCtl))
        
        //分页刷新和下拉刷新
        tableViewRefresh(recommandLineResultView)
        tableViewRefresh(schoolLineResultView)
    }
    
    //列表刷新
    func tableViewRefresh(lineResultView:CPLineSearchResultView){
        let MJHeader=MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.headerRefresh))
        let MJFooter=MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.footerRefresh))
        lineResultView.lineSearchResultTableView.mj_header=MJHeader
        lineResultView.lineSearchResultTableView.mj_footer=MJFooter
        MJHeader.lastUpdatedTimeLabel.hidden=true
        MJHeader.beginRefreshing()

        if lineResultView.lineType==1 {
            MJHeader.tag=51
            MJFooter.tag=61
        }else if lineResultView.lineType==2{
            MJHeader.tag=52
            MJFooter.tag=62
        }
    }
    
    func headerRefresh(header:MJRefreshNormalHeader){
        //单程头部刷新
        if(rang==1){
            if header.tag==51 {
                startIndexRec=0
                recommadLineDic.setValue(startIndexRec, forKey: "start")
                recomDataLoad()
            }else if header.tag==52{
                startIndexScho=0
                schoolLineDic.setValue(startIndexScho, forKey: "start")
                schoolDataLoad()
            }
        }
        //往返程头部刷新
        else if(rang==0){
            if header.tag==51 {
                startIndexRec=0
                recommadLineDic.setValue(startIndexRec, forKey: "start")
                recomDataLoad2()
            }else if header.tag==52{
                startIndexScho=0
                schoolLineDic.setValue(startIndexScho, forKey: "start")
                schoolDataLoad2()
            }
        }
        header.endRefreshing()
    }
    
    //分页刷新
    func footerRefresh(footer:MJRefreshBackNormalFooter){
        if(rang==1){
            if footer.tag==61 {
                startIndexRec+=limit
                recommadLineDic.setValue(startIndexRec, forKey: "start")
                recomDataLoad()
            }else if footer.tag==62{
                startIndexScho+=limit
                schoolLineDic.setValue(startIndexScho, forKey: "start")
                schoolDataLoad()
            }
        }
        else if(rang==0){
            if footer.tag==61 {
                startIndexRec+=limit
                recommadLineDic.setValue(startIndexRec, forKey: "start")
                recomDataLoad2()
            }else if footer.tag==62{
                startIndexScho+=limit
                schoolLineDic.setValue(startIndexScho, forKey: "start")
                schoolDataLoad2()
            }
        }
        footer.endRefreshing()
    }
    
    func gradeChange()->String{
        if (grade != nil) {
            var num:String!
            switch grade! {
            case "一年级":num="1";
            case "二年级":num="2";
            case "三年级":num="3";
            case "四年级":num="4";
            case "五年级":num="5";
            case "六年级":num="6";
            case "初一":num="7";
            case "初二":num="8";
            case "初三":num="9";
            case "高一":num="a";
            case "高二":num="b";
            case "高三":num="c";
            default: num="1"
            }
            gradeNo=num
        }
        return gradeNo
        
    }
    
    //设置线路详情页的请求参数
    func setLineInfoParas(){
        cityIdString=String(cityId)
        comIdString=String(comId)
        
        //推荐线路请求参数
        recommadLineDic.removeAllObjects()
        recommadLineDic.setValue("line_search", forKey: "action")
        recommadLineDic.setValue(schoolAddress, forKey: "schoolAddress")
        recommadLineDic.setValue(grade, forKey: "grade")
        recommadLineDic.setValue("2", forKey: "type")
        recommadLineDic.setValue(departType, forKey: "departType")
        recommadLineDic.setValue(rang, forKey: "rang")
        recommadLineDic.setValue(houseAddress, forKey: "houseAddress")
        recommadLineDic.setValue(houseLon, forKey: "houseLon")
        recommadLineDic.setValue(houseLat, forKey: "houseLat")
        recommadLineDic.setValue(cityIdString, forKey: "cityId")
        recommadLineDic.setValue(startIndexRec, forKey: "start")
        recommadLineDic.setValue(limit, forKey: "limit")
        
        //学校线路请求参数
        schoolLineDic.removeAllObjects()
        schoolLineDic.setValue("line_search", forKey: "action")
        schoolLineDic.setValue(schoolAddress, forKey: "schoolAddress")
        schoolLineDic.setValue(grade, forKey: "grade")
        schoolLineDic.setValue("3", forKey: "type")
        schoolLineDic.setValue(departType, forKey: "departType")
        schoolLineDic.setValue(rang, forKey: "rang")
        schoolLineDic.setValue(houseAddress, forKey: "houseAddress")
        schoolLineDic.setValue(houseLon, forKey: "houseLon")
        schoolLineDic.setValue(houseLat, forKey: "houseLat")
        schoolLineDic.setValue(cityIdString, forKey: "cityId")
        schoolLineDic.setValue(startIndexScho, forKey: "start")
        schoolLineDic.setValue(limit, forKey: "limit")
        
        if (orgOrderId != nil) {
            recommadLineDic.setValue(comIdString, forKey: "comId")
            schoolLineDic.setValue(comIdString, forKey: "comId")
        }
        
        if rang==1{
            //线路详情页请求参数，往
            lineInfoDicW.setValue("line_detail", forKey: "action")
            lineInfoDicW.setValue(houseLon, forKey: "houseLon")
            lineInfoDicW.setValue(houseLat, forKey: "houseLat")
        }else{
            //线路详情页请求参数，往
            lineInfoDicW.setValue("line_detail", forKey: "action")
            lineInfoDicW.setValue(houseLon, forKey: "houseLon")
            lineInfoDicW.setValue(houseLat, forKey: "houseLat")
            
            //线路详情页请求参数,返
            lineInfoDicF.setValue("line_detail", forKey: "action")
            lineInfoDicF.setValue(houseLon, forKey: "houseLon")
            lineInfoDicF.setValue(houseLat, forKey: "houseLat")
        }
    }
    
    //单程推荐线路加载
    func recomDataLoad(){
        //
        //recommadLineParas
        lineSearchResultModel.recommadLineDataLoad(Constants.noauthApiURL, para: recommadLineDic) { (lineNameArray, gradeArray, stationNameArray, priceArray, resultListCount,issueIdArray,classesIdArray,lineIdArray,responseData) in
            if(self.startIndexRec==0){
                self.recommandLineResultView.lineNameArray.removeAllObjects()
                self.recommandLineResultView.gradeArray.removeAllObjects()
                self.recommandLineResultView.stationNameArray.removeAllObjects()
                self.recommandLineResultView.priceArray.removeAllObjects()
                self.recommandLineResultView.isRecruitAr.removeAllObjects()
                self.recommandLineResultView.seatNumAr.removeAllObjects()
                self.recommandLineResultView.lineData.removeAllObjects()
                self.issueIdArrayRecom.removeAllObjects()
                self.classesIdArrayRecom.removeAllObjects()
                self.lineIdArrayRecom.removeAllObjects()
            }
            self.recommandLineResultView.singleTrip=self.rang
            self.recommandLineResultView.delegate=self
            
            self.issueIdArrayRecom.addObjectsFromArray(issueIdArray as [AnyObject])
            self.classesIdArrayRecom.addObjectsFromArray(classesIdArray as [AnyObject])
            self.lineIdArrayRecom.addObjectsFromArray(lineIdArray as [AnyObject])
            self.recommandLineResultView.lineNameArray.addObjectsFromArray(lineNameArray as [AnyObject])
            self.recommandLineResultView.gradeArray.addObjectsFromArray(gradeArray as [AnyObject])
            self.recommandLineResultView.stationNameArray.addObjectsFromArray(stationNameArray as [AnyObject])
            self.recommandLineResultView.priceArray.addObjectsFromArray(priceArray as [AnyObject])
            self.recommandLineResultView.num=self.recommandLineResultView.lineNameArray.count
            self.recommandLineResultView.lineSearchResultTableView.reloadData()
            
            let isSolicitArray=NSMutableArray()
            let seatNumArray=NSMutableArray()
            isSolicitArray.removeAllObjects()
            seatNumArray.removeAllObjects()
            if(responseData.objectForKey("success") as! Bool){
                if(responseData.objectForKey("result")?.count != nil)&&(responseData.objectForKey("result")?.objectForKey("success") as! Bool){
                    
                    let result=responseData.objectForKey("result")?.objectForKey("result")?.objectForKey("lineList") as! NSArray
                    for i in 0..<result.count{
                        let isSolicit = result[i].objectForKey("isSolicit")!
                        let seatNum=result[i].objectForKey("seatNum")!
                        isSolicitArray.addObject(isSolicit)
                        seatNumArray.addObject(seatNum)
                    }
                    
                }
            }
            let newIsSolicitArray=NSMutableArray.init(array: isSolicitArray)
            let newSeatNumArray=NSMutableArray.init(array: seatNumArray)
            weak var weakSelf=self
            weakSelf!.recommandLineResultView.isRecruitAr.addObjectsFromArray(newIsSolicitArray as [AnyObject])
            weakSelf!.recommandLineResultView.seatNumAr.addObjectsFromArray(newSeatNumArray as [AnyObject])
            
            if let result1=responseData.objectForKey("result"){
                if let result2=result1.objectForKey("result"){
                    if let lineList=result2.objectForKey("lineList"){
                        if lineList.count>0{
                            weakSelf?.recommandLineResultView.lineData.addObjectsFromArray(lineList as! [AnyObject])
                        }
                    }
                }
            }
        }
    }
    
    
    
    //单程学校线路加载
    func schoolDataLoad(){
        //
        //schoolLineParas
        lineSearchResultSchoolModel.schoolLineDataLoad(Constants.noauthApiURL, para: schoolLineDic) { (lineNameArray, gradeArray, stationNameArray, priceArray, resultListCount,issueIdArray,classesIdArray,lineIdArray,responseData) in
            if(self.startIndexScho==0){
                self.schoolLineResultView.lineNameArray.removeAllObjects()
                self.schoolLineResultView.gradeArray.removeAllObjects()
                self.schoolLineResultView.stationNameArray.removeAllObjects()
                self.schoolLineResultView.priceArray.removeAllObjects()
                self.schoolLineResultView.isRecruitAr.removeAllObjects()
                self.schoolLineResultView.seatNumAr.removeAllObjects()
                self.schoolLineResultView.lineData.removeAllObjects()
                self.issueIdArraySchool.removeAllObjects()
                self.classesIdArraySchool.removeAllObjects()
                self.lineIdArraySchool.removeAllObjects()
            }
            self.schoolLineResultView.singleTrip=self.rang
            self.schoolLineResultView.delegate=self
            
            self.issueIdArraySchool.addObjectsFromArray(issueIdArray as [AnyObject])
            self.classesIdArraySchool.addObjectsFromArray(classesIdArray as [AnyObject])
            self.lineIdArraySchool.addObjectsFromArray(lineIdArray as [AnyObject])
            self.schoolLineResultView.lineNameArray.addObjectsFromArray(lineNameArray as [AnyObject])
            self.schoolLineResultView.gradeArray.addObjectsFromArray(gradeArray as [AnyObject])
            self.schoolLineResultView.stationNameArray.addObjectsFromArray(stationNameArray as [AnyObject])
            self.schoolLineResultView.priceArray.addObjectsFromArray(priceArray as [AnyObject])
            self.schoolLineResultView.num=self.schoolLineResultView.lineNameArray.count
            self.schoolLineResultView.lineSearchResultTableView.reloadData()
            
            let isSolicitArray=NSMutableArray()
            let seatNumArray=NSMutableArray()
            isSolicitArray.removeAllObjects()
            seatNumArray.removeAllObjects()
            if(responseData.objectForKey("success") as! Bool){
                if(responseData.objectForKey("result")?.count != nil)&&(responseData.objectForKey("result")?.objectForKey("success") as! Bool){
                    
                    let result=responseData.objectForKey("result")?.objectForKey("result")?.objectForKey("lineList") as! NSArray
                    for i in 0..<result.count{
                        let isSolicit = result[i].objectForKey("isSolicit")!
                        let seatNum=result[i].objectForKey("seatNum")!
                        isSolicitArray.addObject(isSolicit)
                        seatNumArray.addObject(seatNum)
                    }
                    
                }
            }
            let newIsSolicitArray=NSMutableArray.init(array: isSolicitArray)
            let newSeatNumArray=NSMutableArray.init(array: seatNumArray)
            weak var weakSelf=self
            weakSelf!.schoolLineResultView.isRecruitAr.addObjectsFromArray(newIsSolicitArray as [AnyObject])
            weakSelf!.schoolLineResultView.seatNumAr.addObjectsFromArray(newSeatNumArray as [AnyObject])
            
            if let result1=responseData.objectForKey("result"){
                if let result2=result1.objectForKey("result"){
                    if let lineList=result2.objectForKey("lineList"){
                        if lineList.count>0{
                            weakSelf?.schoolLineResultView.lineData.addObjectsFromArray(lineList as! [AnyObject])
                        }
                    }
                }
            }
            
        }
    }
    
    //双程推荐线路加载
    func recomDataLoad2(){
        //
        //recommadLineParas
        lineSearchResultModel.recommandLineDataLoad2(Constants.noauthApiURL, para: recommadLineDic, closure: { (lineNameArray, lineNameArrayBack, gradeArray, stationNameArray, priceArray, priceArrayBack, resultListCount, issueIdArray, classesIdArray, lineIdArray, issueIdArrayBack, classesIdArrayBack, lineIdArrayBack,responseData) in
            if(self.startIndexRec==0){
                self.recommandLineResultView.lineNameArray.removeAllObjects()
                self.recommandLineResultView.gradeArray.removeAllObjects()
                self.recommandLineResultView.stationNameArray.removeAllObjects()
                self.recommandLineResultView.priceArray.removeAllObjects()
                
                self.recommandLineResultView.lineNameArrayBack.removeAllObjects()
                self.recommandLineResultView.priceArrayBack.removeAllObjects()
                self.recommandLineResultView.isRecruitAr.removeAllObjects()
                self.recommandLineResultView.seatNumAr.removeAllObjects()
            }
            self.recommandLineResultView.singleTrip=self.rang
            self.recommandLineResultView.delegate=self
            
            self.issueIdArrayRecom.addObjectsFromArray(issueIdArray as [AnyObject])
            self.classesIdArrayRecom.addObjectsFromArray(classesIdArray as [AnyObject])
            self.lineIdArrayRecom.addObjectsFromArray(lineIdArray as [AnyObject])
            self.issueIdArrayRecomBack.addObjectsFromArray(issueIdArrayBack as [AnyObject])
            self.classesIdArrayRecomBack.addObjectsFromArray(classesIdArrayBack as [AnyObject])
            self.lineIdArrayRecomBack.addObjectsFromArray(lineIdArrayBack as [AnyObject])
            self.recommandLineResultView.lineNameArray.addObjectsFromArray(lineNameArray as [AnyObject])
            self.recommandLineResultView.gradeArray.addObjectsFromArray(gradeArray as [AnyObject])
            self.recommandLineResultView.stationNameArray.addObjectsFromArray(stationNameArray as [AnyObject])
            self.recommandLineResultView.priceArray.addObjectsFromArray(priceArray as [AnyObject])
            self.recommandLineResultView.lineNameArrayBack.addObjectsFromArray(lineNameArrayBack as [AnyObject])
            self.recommandLineResultView.priceArrayBack.addObjectsFromArray(priceArrayBack as [AnyObject])
            self.recommandLineResultView.num=self.recommandLineResultView.lineNameArray.count
            self.recommandLineResultView.lineSearchResultTableView.reloadData()

            let isSolicitArray=NSMutableArray()
            let seatNumArray=NSMutableArray()
            isSolicitArray.removeAllObjects()
            seatNumArray.removeAllObjects()
            if(responseData.objectForKey("success") as! Bool){
                if(responseData.objectForKey("result")?.count > 0)&&(responseData.objectForKey("result")?.objectForKey("success") as! Bool){
                    if(responseData.objectForKey("result")?.objectForKey("result")?.objectForKey("lineList")?.count>0){
                        let result=responseData.objectForKey("result")?.objectForKey("result")?.objectForKey("lineList") as! NSArray
                        //                        print(result)
                        for i in 0..<result.count{
                            let isSolicit = result[i].objectForKey("w")!.objectForKey("isSolicit")!
                            let seatNum=result[i].objectForKey("w")!.objectForKey("seatNum")!
                            isSolicitArray.addObject(isSolicit)
                            seatNumArray.addObject(seatNum)
                        }
                    }
                    
                    
                }
            }
            let newIsSolicitArray=NSMutableArray.init(array: isSolicitArray)
            let newSeatNumArray=NSMutableArray.init(array: seatNumArray)
            weak var weakSelf=self
            weakSelf!.recommandLineResultView.isRecruitAr.addObjectsFromArray(newIsSolicitArray as [AnyObject])
            weakSelf!.recommandLineResultView.seatNumAr.addObjectsFromArray(newSeatNumArray as [AnyObject])
        })
    }
    
    //双程学校线路加载
    func schoolDataLoad2(){
        //
        //schoolLineParas
        lineSearchResultSchoolModel.schoolLineDataLoad2(Constants.noauthApiURL, para: schoolLineDic, closure: { (lineNameArray, lineNameArrayBack, gradeArray, stationNameArray, priceArray, priceArrayBack, resultListCount, issueIdArray, classesIdArray, lineIdArray, issueIdArrayBack, classesIdArrayBack, lineIdArrayBack,responseData) in
            if(self.startIndexScho==0){
                self.schoolLineResultView.lineNameArray.removeAllObjects()
                self.schoolLineResultView.gradeArray.removeAllObjects()
                self.schoolLineResultView.stationNameArray.removeAllObjects()
                self.schoolLineResultView.priceArray.removeAllObjects()
                
                self.schoolLineResultView.lineNameArrayBack.removeAllObjects()
                self.schoolLineResultView.priceArrayBack.removeAllObjects()
                self.schoolLineResultView.isRecruitAr.removeAllObjects()
                self.schoolLineResultView.seatNumAr.removeAllObjects()
            }
            self.schoolLineResultView.singleTrip=self.rang
            self.schoolLineResultView.delegate=self
            
            self.issueIdArraySchool.addObjectsFromArray(issueIdArray as [AnyObject])
            self.classesIdArraySchool.addObjectsFromArray(classesIdArray as [AnyObject])
            self.lineIdArraySchool.addObjectsFromArray(lineIdArray as [AnyObject])
            self.issueIdArraySchoolBack.addObjectsFromArray(issueIdArrayBack as [AnyObject])
            self.classesIdArraySchoolBack.addObjectsFromArray(classesIdArrayBack as [AnyObject])
            self.lineIdArraySchoolBack.addObjectsFromArray(lineIdArrayBack as [AnyObject])
            self.schoolLineResultView.lineNameArray.addObjectsFromArray(lineNameArray as [AnyObject])
            self.schoolLineResultView.gradeArray.addObjectsFromArray(gradeArray as [AnyObject])
            self.schoolLineResultView.stationNameArray.addObjectsFromArray(stationNameArray as [AnyObject])
            self.schoolLineResultView.priceArray.addObjectsFromArray(priceArray as [AnyObject])
            self.schoolLineResultView.lineNameArrayBack.addObjectsFromArray(lineNameArrayBack as [AnyObject])
            self.schoolLineResultView.priceArrayBack.addObjectsFromArray(priceArrayBack as [AnyObject])
            self.schoolLineResultView.num=self.schoolLineResultView.lineNameArray.count
            self.schoolLineResultView.lineSearchResultTableView.reloadData()
            
            let isSolicitArray=NSMutableArray()
            let seatNumArray=NSMutableArray()
            isSolicitArray.removeAllObjects()
            seatNumArray.removeAllObjects()
            if(responseData.objectForKey("success") as! Bool){
                if(responseData.objectForKey("result")?.count != nil)&&(responseData.objectForKey("result")?.objectForKey("success") as! Bool){
                    
                    let result=responseData.objectForKey("result")?.objectForKey("result")?.objectForKey("lineList") as! NSArray
                    //                        print(result)
                    for i in 0..<result.count{
                        let isSolicit = result[i].objectForKey("w")!.objectForKey("isSolicit")!
                        let seatNum=result[i].objectForKey("w")!.objectForKey("seatNum")!
                        isSolicitArray.addObject(isSolicit)
                        seatNumArray.addObject(seatNum)
                    }
                    
                }
            }
            let newIsSolicitArray=NSMutableArray.init(array: isSolicitArray)
            let newSeatNumArray=NSMutableArray.init(array: seatNumArray)
            weak var weakSelf=self
            weakSelf!.schoolLineResultView.isRecruitAr.addObjectsFromArray(newIsSolicitArray as [AnyObject])
            weakSelf!.schoolLineResultView.seatNumAr.addObjectsFromArray(newSeatNumArray as [AnyObject])
        })
    }
    
    func goLineInfoCtl(row: Int,lineType:Int,singleLineType:Int) {
        //        print("用户登录状态：",CPUserModel.getLoginState())
        if !CPUserModel.getLoginState() {
            let alertView=UIAlertView(title: "提示", message: "请先登录", delegate: self, cancelButtonTitle: "确定")
            alertView.tag=1
            alertView.show()
        }
        else{
            
            //获取点击的行数
            self.selectedRowRecom=recommandLineResultView.selectedRow
            self.selectedRowSchool=schoolLineResultView.selectedRow
            let vc=CPLineInfoController()
            
            //判断是单程还是双程
            if rang==1{                 //rang＝1是单程
                if(lineType==1){        //判断是推荐线路还是学校线路,1是推荐线路
                    issueId=issueIdArrayRecom[selectedRowRecom]
                    classesId=classesIdArrayRecom[selectedRowRecom] as! String
                    lineId=lineIdArrayRecom[selectedRowRecom] as! Int
                    self.lineInfoDicW.setValue(issueId, forKey: "issueId")
                    self.lineInfoDicW.setValue(classesId, forKey: "classesId")
                    self.lineInfoDicW.setValue(lineId, forKey: "lineId")
                    self.lineInfoDicW.setValue(self.recommandLineResultView.isRecruit, forKey: "isSolicit")
                    
                    vc.lineInfoDicW=self.lineInfoDicW
                    //            print(vc.lineInfoDicW)
                    
                    //线路详情页所需的订单参数,往
                    vc.lineIdW=self.lineId
                    vc.classIdW=self.classesId
                    vc.issueId=self.issueId
                    vc.singleLineType=singleLineType
                }
                else if(lineType==2){
                    issueId=issueIdArraySchool[selectedRowSchool]
                    classesId=classesIdArraySchool[selectedRowSchool] as! String
                    lineId=lineIdArraySchool[selectedRowSchool] as! Int
                    self.lineInfoDicW.setValue(issueId, forKey: "issueId")
                    self.lineInfoDicW.setValue(classesId, forKey: "classesId")
                    self.lineInfoDicW.setValue(lineId, forKey: "lineId")
                    self.lineInfoDicW.setValue(self.schoolLineResultView.isRecruit, forKey: "isSolicit")
                    vc.lineInfoDicW=self.lineInfoDicW                    
                    //线路详情页所需的订单参数,往
                    vc.lineIdW=self.lineId
                    vc.classIdW=self.classesId
                    vc.issueId=self.issueId
                    vc.singleLineType=singleLineType
                }
            }else{
                if(lineType==1){
                    issueId=issueIdArrayRecom[selectedRowRecom] 
                    classesId=classesIdArrayRecom[selectedRowRecom]
                    lineId=lineIdArrayRecom[selectedRowRecom] as! Int
                    self.lineInfoDicW.setValue(issueId, forKey: "issueId")
                    self.lineInfoDicW.setValue(classesId, forKey: "classesId")
                    self.lineInfoDicW.setValue(lineId, forKey: "lineId")
                    self.lineInfoDicW.setValue(self.recommandLineResultView.isRecruit, forKey: "isSolicit")
                    vc.lineInfoDicW=self.lineInfoDicW
                    
                    //线路详情页所需的订单参数,往
                    vc.lineIdW=self.lineId
                    vc.classIdW=self.classesId
                    vc.issueId=self.issueId
                    
                    issueIdBack=issueIdArrayRecomBack[selectedRowRecom]
                    classesIdBack=classesIdArrayRecomBack[selectedRowRecom]
                    lineIdBack=lineIdArrayRecomBack[selectedRowRecom] as! Int
                    self.lineInfoDicF.setValue(issueIdBack, forKey: "issueId")
                    self.lineInfoDicF.setValue(classesIdBack, forKey: "classesId")
                    self.lineInfoDicF.setValue(lineIdBack, forKey: "lineId")
                    self.lineInfoDicF.setValue(self.recommandLineResultView.isRecruit, forKey: "isSolicit")
                    vc.lineInfoDicF=self.lineInfoDicF
                    
                    //线路详情页所需的订单参数,返
                    vc.lineIdF=self.lineIdBack
                    vc.classIdF=self.classesIdBack
                }else if(lineType==2){
                    issueId=issueIdArraySchool[selectedRowSchool] 
                    classesId=classesIdArraySchool[selectedRowSchool] 
                    lineId=lineIdArraySchool[selectedRowSchool] as! Int
                    self.lineInfoDicW.setValue(issueId, forKey: "issueId")
                    self.lineInfoDicW.setValue(classesId, forKey: "classesId")
                    self.lineInfoDicW.setValue(lineId, forKey: "lineId")
                    self.lineInfoDicW.setValue(self.schoolLineResultView.isRecruit, forKey: "isSolicit")
                    vc.lineInfoDicW=self.lineInfoDicW
                    
                    //线路详情页所需的订单参数,往
                    vc.lineIdW=self.lineId
                    vc.classIdW=self.classesId
                    vc.issueId=self.issueId
                    
                    issueIdBack=issueIdArraySchoolBack[selectedRowSchool] 
                    classesIdBack=classesIdArraySchoolBack[selectedRowSchool]
                    lineIdBack=lineIdArraySchoolBack[selectedRowSchool] as! Int
                    self.lineInfoDicF.setValue(issueIdBack, forKey: "issueId")
                    self.lineInfoDicF.setValue(classesIdBack, forKey: "classesId")
                    self.lineInfoDicF.setValue(lineIdBack, forKey: "lineId")
                    self.lineInfoDicF.setValue(self.schoolLineResultView.isRecruit, forKey: "isSolicit")
                    vc.lineInfoDicF=self.lineInfoDicF
                    
                    //线路详情页所需的订单参数,返
                    vc.lineIdF=self.lineIdBack
                    vc.classIdF=self.classesIdBack
                }
            }
            vc.rang=self.rang!       //单程还是往返
            vc.orgOrderId=orgOrderId
            self.hidesBottomBarWhenPushed=true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func goCustomLine(){
        let vc=CPCustomLineController()
        self.hidesBottomBarWhenPushed=true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(alertView.tag==1){
            let vc=CPLoginViewController()
            self.hidesBottomBarWhenPushed=true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        if self.recommandLineResultView.lineSearchResultTableView.indexPathForSelectedRow != nil {
            self.recommandLineResultView.lineSearchResultTableView.deselectRowAtIndexPath(self.recommandLineResultView.lineSearchResultTableView.indexPathForSelectedRow!, animated: true)
        }
        else if self.schoolLineResultView.lineSearchResultTableView.indexPathForSelectedRow != nil {
            self.schoolLineResultView.lineSearchResultTableView.deselectRowAtIndexPath(self.schoolLineResultView.lineSearchResultTableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
