//
//  CPLineInfoView.swift
//  i84cpn
//
//  Created by 周杰 on 16/5/17.
//  Copyright © 2016年 5i84. All rights reserved.
//  线路详情

import UIKit

protocol goCtlDelegate:NSObjectProtocol {
    func goNextCtl(tag:Int)
    func goLineDetailMap()
}

class CPLineInfoView: UIView,ZHDropDownMenuDelegate,UIAlertViewDelegate {
    var scrollView=UIScrollView()
    var contentView=UIView()
    
    var lineView=UIView()           //线路View
    var orderView=UIView()          //预定View
    var comfirmView=UIView()        //确认View
    var lineBackView=UIView()       //返程线路View
    var submit=UIButton()           //购票按钮
    
    //-----------lineView UI---------
    var lineNameLb=UILabel()        //线路名称
    var priceLb=UILabel()           //线路价格
    var priceUnitLb=UILabel()       //价格单位
    var gradeKey=UIView()
    var gradeLb=UILabel()           //推荐年级
    var stationLb=UILabel()         //途经站点
    var stationValue=UILabel()      //站点名称
    var lineDetailMap=UILabel()     //查看详细路线图
    var busDateKit=UITextField()        //日期控件
    var startStationLb=UILabel()    //上车站点
    var startTimeLb=UILabel()       //上车时间
    var startStationDropMenu = ZHDropDownMenu()        //站点下拉框
    var timeImgView=UIImageView()                   //时间图片
    var timeValue=UILabel()                         //时间显示
    var orderTermValue=UILabel()                    //期次内容
    var addPassgerAddress=UIButton()

    
    //--------------lineBackView UI-----------
    var lineBackNameKey=UILabel()
    var priceBackValue=UILabel()
    var priceUnitBackKey=UILabel()
    var gradeBackKey=UIView()
    var gradeBackValue=UILabel()
    var stationBackKey=UILabel()
    var stationBackValue=UILabel()
    var lineDetailMapBack=UILabel()
    var startStationBackKey=UILabel()
    var startStationBackDropMenu = ZHDropDownMenu()
    var startTimeKey=UILabel()
    var timeBackImgView=UIImageView()
    var timeBackValue=UILabel()
    var wLabel=UILabel()
    var fLabel=UILabel()
    var connectAddress=UILabel()

    
    var passenger=UILabel()
    var psgView=UIView()
    var busDate=UILabel()
    var addPassgerBtn=UIButton()    //乘客添加按钮
    var agreementCbx=UIButton()     //合同勾选框
    var billCbx=UIButton()          //发票勾选框
    
    var moveWayKey=UILabel()        //开行方式key
    var moveWayValue=UILabel()      //开行方式value

    var dateView = UIView()
    
    var orderTerm=UILabel()
    
    var dropRowW:Int!
    var dropRowF:Int!
    
    var startDate:AnyObject!
    var isNeedContract:Int!
    
    var startStation:String!
    var endStation:String!
    
    var addressDropMenu=ZHDropDownMenu()

    var stationListAr=NSArray()
    var stationListArBack=NSArray()
    
    var psgIdsSelectedAr=NSMutableArray()
    
    var psgButtonArray=NSMutableArray() as! [UIButton]
    
    var dropRowAddress:Int!
    
    var psgAddressAr=NSArray()
    
    var canDrawRect = false
    
    var psgIdsArray=NSMutableArray()        //乘客列表
    var psgIdsDic=NSMutableDictionary()     //乘客id
    var psgResultList=NSArray()             //从接口获取到的乘客列表
    var singleLineType:Int!
    
    //招募中线路详情
    private var recruitView=UIView()
    private var recruitLineName=UILabel()
    private var recruitLb=UILabel()
    private var expectLb=UILabel()
    private var joinBtn=UIButton()    //参加按钮
    var isShowRecruit:Bool=false
    
    //满座线路详情
    private var addNameBtn=UIButton()    //报名按钮
    private var orderTermKeyFull=UILabel()
    var orderTermValueFull=UILabel()
    private var openWayKey=UILabel()
    var openWayValue=UILabel()
    var isShowFullSeat:Bool=false
    
    //改签线路详情
    private var payView=UIView()
    var isShowChangeOrder:Bool=false
    var changeOrderView=UIView()
    private var changeBtn=UIButton()    //改签按钮
    var changeOrderInfoView=UIView()    //改签提示视图
    private var changeInfoLb=UILabel()
    private var psgNameValue=UILabel()
    private var orgLineKey=UILabel()
    private var orgLineValue=UILabel()
    private var newLineKey=UILabel()
    private var newLineValue=UILabel()
    private var customDividingLine=UIView()
    private var customDividingLine2=UIView()
    private var addOrReduceMoneyKey=UILabel()
    private var addOrReduceMoneyValue=UILabel()
    private var onlyChangeOnceLb=UILabel()
    private var payWayLb=UILabel()
    var cj:String!
    private var aliPayBtn=UIButton()
    private var weChatBtn=UIButton()
    var comfirmBtn=UIButton()   //确认改签
    private var cancelBtn=UIButton()    //取消改签
    var getOnStationW:Int!
    var getOffStationW:Int!
    
    @IBOutlet weak var calendarView: NWCalendarView!
    weak var delegate:goCtlDelegate?
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        if canDrawRect == false{
            return
        }
        canDrawRect = false
        isNeedContract=0
        
        //-------------------------scrollView------------------------
        self.addSubview(scrollView)
        scrollView.backgroundColor=COLOR_BACKGROUND_GRAY
        scrollView.bounces=false
        scrollView.snp_makeConstraints { make in
            make.edges.equalTo(self).offset(UIEdgeInsetsZero)
        }
        
        //-------------------------contentView，边界值在底部------------------------
        scrollView.addSubview(contentView)
        contentView.backgroundColor=COLOR_BACKGROUND_GRAY
        //－－－－－－－－－－－－－－－lineView线路视图－－－－－－－－－－－－－－－－－
        contentView.addSubview(lineView)
        lineView.layer.borderWidth=1
        lineView.layer.borderColor=COLOR_SEGMENTATION.CGColor
        lineView.backgroundColor=UIColor.whiteColor()
        lineView.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(HEIGHT_DYNAMIC(15))
            make.left.equalTo(contentView).offset(0)
            make.right.equalTo(contentView).offset(0)
//            make.height.equalTo((220))
        }
        //"往"字
        lineView.addSubview(wLabel)
        wLabel.text="[往] "
        wLabel.textColor=COLOR_TEXT_ORANGE
        wLabel.font=UIFont.systemFontOfSize(15)
        wLabel.snp_makeConstraints { (make) in
            make.top.equalTo(lineView).offset(HEIGHT_DYNAMIC(20))
            make.left.equalTo(lineView).offset(WIDTH_DYNAMIC(15))
        }
        //线路名称
        lineView.addSubview(lineNameLb)
        lineNameLb.font=UIFont.systemFontOfSize(15)
        lineNameLb.snp_makeConstraints { (make) in
            make.top.equalTo(lineView).offset(HEIGHT_DYNAMIC(20))
            make.left.equalTo(wLabel.snp_right).offset(0)
            make.width.lessThanOrEqualTo(self.bounds.size.width/3*2)
        }
        //价格单位
        lineView.addSubview(priceUnitLb)
        priceUnitLb.text="元/趟"
        priceUnitLb.font=UIFont.systemFontOfSize(12)
        priceUnitLb.snp_makeConstraints { (make) in
            make.top.equalTo(lineView).offset(HEIGHT_DYNAMIC(25))
            make.right.equalTo(lineView).offset(WIDTH_DYNAMIC(-15))
        }
        
        //价格
        lineView.addSubview(priceLb)
        priceLb.font=UIFont.systemFontOfSize((24))
        priceLb.textColor=COLOR_TEXT_YELLOW
        priceLb.snp_makeConstraints { (make) in
            make.right.equalTo(priceUnitLb.snp_left)
            make.bottom.equalTo(priceUnitLb.snp_bottom).offset(5)
        }
        //推荐年级
        lineView.addSubview(gradeLb)
        gradeLb.backgroundColor=COLOR_BACKGROUND_GRAY
        gradeLb.numberOfLines=0
        gradeLb.font=UIFont.systemFontOfSize(12)
        gradeLb.textAlignment=NSTextAlignment.Center
        gradeLb.textColor=UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)
        gradeLb.snp_makeConstraints { (make) in
            make.top.equalTo(lineNameLb.snp_bottom).offset(HEIGHT_DYNAMIC(15))
            make.left.equalTo(lineView).offset(WIDTH_DYNAMIC(15))
            make.right.equalTo(lineView).offset(WIDTH_DYNAMIC(-15))
        }
        //推荐年级背景视图
        lineView.addSubview(gradeKey)
        gradeKey.backgroundColor=COLOR_BACKGROUND_GRAY
        gradeKey.layer.borderWidth=1
        gradeKey.layer.borderColor=COLOR_SEGMENTATION.CGColor
        gradeKey.snp_makeConstraints { (make) in
            make.top.equalTo(gradeLb.snp_top).offset(-5)
            make.bottom.equalTo(gradeLb.snp_bottom).offset(5)
            make.left.equalTo(gradeLb.snp_left).offset(-5)
            make.right.equalTo(gradeLb.snp_right).offset(5)
        }
        lineView.insertSubview(gradeLb, aboveSubview: gradeKey)
        //途经站点
        lineView.addSubview(stationLb)
        stationLb.text="途经站点"
        stationLb.font=UIFont.systemFontOfSize(13)
        stationLb.snp_makeConstraints { (make) in
            make.top.equalTo(gradeLb.snp_bottom).offset(HEIGHT_DYNAMIC(20))
            make.left.equalTo(lineView).offset(WIDTH_DYNAMIC(15))
            make.width.equalTo(55)
        }
        //站点值
        lineView.addSubview(stationValue)
        stationValue.font=UIFont.systemFontOfSize(13)
        stationValue.textColor=COLOR_TEXT
        stationValue.numberOfLines=0
        stationValue.snp_makeConstraints { (make) in
            make.top.equalTo(stationLb.snp_top).offset(0)
            make.left.equalTo(stationLb.snp_right).offset(WIDTH_DYNAMIC(15))
            make.right.equalTo(lineView).offset(WIDTH_DYNAMIC(-15))
        }
        //查看详细线路图
        lineView.addSubview(lineDetailMap)
        lineDetailMap.font=UIFont.systemFontOfSize(13)
        lineDetailMap.text="查看详细线路图"
        let attrs=[NSUnderlineColorAttributeName:COLOR_TEXT_ORANGE,NSUnderlineStyleAttributeName:1,NSForegroundColorAttributeName:COLOR_TEXT_ORANGE]
        let underLineStr=NSMutableAttributedString(string: lineDetailMap.text!, attributes: attrs)
        lineDetailMap.attributedText=underLineStr
        lineDetailMap.snp_makeConstraints { (make) in
            make.top.equalTo(stationValue.snp_bottom).offset(HEIGHT_DYNAMIC(5))
            make.left.equalTo(stationLb.snp_right).offset(WIDTH_DYNAMIC(15))
        }
        lineDetailMap.userInteractionEnabled=true
        let lineDetailMapGest=UITapGestureRecognizer(target: self, action: #selector(CPLineInfoView.lbClick))
        lineDetailMap.addGestureRecognizer(lineDetailMapGest)

        //上车站点
        lineView.addSubview(startStationLb)
        startStationLb.font=UIFont.systemFontOfSize(13)
        startStationLb.text="上车站点"
        startStationLb.snp_makeConstraints { (make) in
            make.top.equalTo(lineDetailMap.snp_bottom).offset(HEIGHT_DYNAMIC(21))
            make.left.equalTo(lineView).offset(WIDTH_DYNAMIC(15))
        }
        //站点下拉框
        contentView.addSubview(startStationDropMenu)
        startStationDropMenu.dropMenuTag=11
        startStationDropMenu.delegate=self
        startStationDropMenu.buttonImage=UIImage(named: "icon_down")
        startStationDropMenu.editable=false
        startStationDropMenu.font=UIFont.systemFontOfSize(12)
        startStationDropMenu.textColor=COLOR_TEXT
        startStationDropMenu.layer.borderColor=COLOR_SEGMENTATION.CGColor
        startStationDropMenu.layer.borderWidth=1
        startStationDropMenu.snp_makeConstraints { (make) in
            make.top.equalTo(lineDetailMap.snp_bottom).offset(HEIGHT_DYNAMIC(15))
            make.left.equalTo(startStationLb.snp_right).offset(WIDTH_DYNAMIC(15))
            make.width.equalTo(WIDTH_DYNAMIC(280))
            make.height.equalTo(30)
        }
        
        //上车时间
        lineView.addSubview(startTimeLb)
        startTimeLb.text="上车时间"
        startTimeLb.font=UIFont.systemFontOfSize(13)
        startTimeLb.snp_makeConstraints { (make) in
            make.top.equalTo(startStationLb.snp_bottom).offset(HEIGHT_DYNAMIC(25))
            make.left.equalTo(lineView).offset(WIDTH_DYNAMIC(15))
        }
        //timeImgView
        lineView.addSubview(timeImgView)
        timeImgView.image=UIImage(named: "icon_time")
        timeImgView.snp_makeConstraints { (make) in
            make.top.equalTo(startStationLb.snp_bottom).offset(HEIGHT_DYNAMIC(25))
            make.left.equalTo(startTimeLb.snp_right).offset(WIDTH_DYNAMIC(15))
        }
        //timeValue
        lineView.addSubview(timeValue)
        timeValue.font=UIFont.systemFontOfSize(13)
        timeValue.textColor=COLOR_TEXT
        timeValue.snp_makeConstraints { (make) in
            make.top.equalTo(startStationLb.snp_bottom).offset(HEIGHT_DYNAMIC(25))
            make.left.equalTo(timeImgView.snp_right).offset(WIDTH_DYNAMIC(15))
        }
        
        lineView.snp_updateConstraints { (make) in
            make.bottom.equalTo(timeImgView.snp_bottom).offset(5)
        }
        if (singleLineType != nil)&&(singleLineType==1){
            startStationLb.text="下车站点"
            startTimeLb.text="发车时间"
        }
        
        //--------------------lineBackView-----------------
        contentView.addSubview(lineBackView)
        lineBackView.backgroundColor=UIColor.whiteColor()
        lineBackView.layer.borderWidth=1
        lineBackView.layer.borderColor=COLOR_SEGMENTATION.CGColor
        lineBackView.snp_makeConstraints { (make) in
            make.top.equalTo(lineView.snp_bottom).offset(HEIGHT_DYNAMIC(15))
            make.left.equalTo(contentView).offset(0)
            make.right.equalTo(contentView).offset(0)
//            make.height.equalTo(300)
        }
        //返字
        lineBackView.addSubview(fLabel)
        fLabel.text="[返] "
        fLabel.font=UIFont.systemFontOfSize(15)
        fLabel.textColor=COLOR_TEXT_ORANGE
        fLabel.snp_makeConstraints { (make) in
            make.top.equalTo(lineBackView).offset(HEIGHT_DYNAMIC(20))
            make.left.equalTo(lineBackView).offset(WIDTH_DYNAMIC(15))
        }
        
        //返程线路名称
        lineBackView.addSubview(lineBackNameKey)
        lineBackNameKey.font=UIFont.systemFontOfSize(15)
        lineBackNameKey.snp_makeConstraints { (make) in
            make.top.equalTo(lineBackView).offset(HEIGHT_DYNAMIC(20))
            make.left.equalTo(fLabel.snp_right).offset(0)
            make.width.lessThanOrEqualTo(self.bounds.size.width/3*2)
        }
        
        //返程价格单位
        lineBackView.addSubview(priceUnitBackKey)
        priceUnitBackKey.text="元/趟"
        priceUnitBackKey.font=UIFont.systemFontOfSize(12)
        priceUnitBackKey.snp_makeConstraints { (make) in
            make.top.equalTo(lineBackView).offset(HEIGHT_DYNAMIC(25))
            make.right.equalTo(lineBackView).offset(WIDTH_DYNAMIC(-15))
        }
        
        //返程价格
        lineBackView.addSubview(priceBackValue)
        priceBackValue.font=UIFont.systemFontOfSize((24))
//        priceBackValue.text="8"
        priceBackValue.textColor=COLOR_TEXT_YELLOW
        priceBackValue.snp_makeConstraints { (make) in
            //            make.top.equalTo(lineView).offset(HEIGHT_DYNAMIC(15))
            make.right.equalTo(priceUnitBackKey.snp_left)
            make.bottom.equalTo(priceUnitBackKey.snp_bottom).offset(5)
        }

        //返程推荐年级
        lineBackView.addSubview(gradeBackValue)
        gradeBackValue.backgroundColor=COLOR_BACKGROUND_GRAY
        gradeBackValue.numberOfLines=0
        gradeBackValue.font=UIFont.systemFontOfSize(12)
        gradeBackValue.textAlignment=NSTextAlignment.Center
        gradeBackValue.textColor=UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)
        gradeBackValue.snp_makeConstraints { (make) in
            make.top.equalTo(lineBackNameKey.snp_bottom).offset(HEIGHT_DYNAMIC(15))
            make.left.equalTo(lineBackView).offset(WIDTH_DYNAMIC(15))
            make.right.equalTo(lineBackView).offset(WIDTH_DYNAMIC(-15))
//            make.leftMargin.equalTo(5)
        }
        //返程推荐年级背景视图
        lineBackView.addSubview(gradeBackKey)
        gradeBackKey.backgroundColor=COLOR_BACKGROUND_GRAY
        gradeBackKey.bringSubviewToFront(gradeBackValue)
        gradeBackKey.layer.borderWidth=1
        gradeBackKey.layer.borderColor=COLOR_SEGMENTATION.CGColor
        gradeBackKey.snp_makeConstraints { (make) in
            make.top.equalTo(gradeBackValue.snp_top).offset(-5)
            make.bottom.equalTo(gradeBackValue.snp_bottom).offset(5)
            make.left.equalTo(gradeBackValue.snp_left).offset(-5)
            make.right.equalTo(gradeBackValue.snp_right).offset(5)
        }
        lineBackView.insertSubview(gradeBackValue, aboveSubview: gradeBackKey)
        
        //返程途经站点
        lineBackView.addSubview(stationBackKey)
        stationBackKey.text="途经站点"
        stationBackKey.font=UIFont.systemFontOfSize(13)
        stationBackKey.snp_makeConstraints { (make) in
            make.top.equalTo(gradeBackValue.snp_bottom).offset(HEIGHT_DYNAMIC(20))
            make.left.equalTo(lineBackView).offset(WIDTH_DYNAMIC(15))
            make.width.equalTo(55)
        }
        
        //返程站点值
        lineBackView.addSubview(stationBackValue)
//        stationBackValue.text="紫阳中学、正大广场、状元净、汽车北站、南公园、连江、西湖公园、深林公园、白马河、三坊七巷"
        stationBackValue.font=UIFont.systemFontOfSize(13)
        stationBackValue.textColor=COLOR_TEXT
        stationBackValue.numberOfLines=0
        stationBackValue.snp_makeConstraints { (make) in
            make.top.equalTo(stationBackKey.snp_top).offset(0)
            make.left.equalTo(stationBackKey.snp_right).offset(WIDTH_DYNAMIC(15))
            make.right.equalTo(lineBackView).offset(WIDTH_DYNAMIC(-15))
        }
        
        //返程查看详细线路图
        lineBackView.addSubview(lineDetailMapBack)
        lineDetailMapBack.font=UIFont.systemFontOfSize(13)
        lineDetailMapBack.text="查看详细线路图"
        lineDetailMapBack.attributedText=underLineStr
        lineDetailMapBack.snp_makeConstraints { (make) in
            make.top.equalTo(stationBackValue.snp_bottom).offset(HEIGHT_DYNAMIC(5))
            make.left.equalTo(stationBackKey.snp_right).offset(WIDTH_DYNAMIC(16))
        }
        lineDetailMapBack.userInteractionEnabled=true
        let lineDetailMapGest2=UITapGestureRecognizer(target: self, action: #selector(CPLineInfoView.lbClick))
        lineDetailMapBack.addGestureRecognizer(lineDetailMapGest2)

        //返程上车站点
        lineBackView.addSubview(startStationBackKey)
        startStationBackKey.font=UIFont.systemFontOfSize(13)
        startStationBackKey.text="下车站点"
        startStationBackKey.snp_makeConstraints { (make) in
            make.top.equalTo(lineDetailMapBack.snp_bottom).offset(HEIGHT_DYNAMIC(21))
            make.left.equalTo(lineBackView).offset(WIDTH_DYNAMIC(15))
        }
        
        //返程站点下拉框
        contentView.addSubview(startStationBackDropMenu)
        startStationBackDropMenu.dropMenuTag=12
        startStationBackDropMenu.delegate=self
        startStationBackDropMenu.buttonImage=UIImage(named: "icon_down")
        startStationBackDropMenu.editable=false
        startStationBackDropMenu.font=UIFont.systemFontOfSize(12)
        startStationBackDropMenu.textColor=COLOR_TEXT
        startStationBackDropMenu.layer.borderColor=COLOR_SEGMENTATION.CGColor
        startStationBackDropMenu.layer.borderWidth=1
        startStationBackDropMenu.snp_makeConstraints { (make) in
            make.top.equalTo(lineDetailMapBack.snp_bottom).offset(HEIGHT_DYNAMIC(15))
            make.left.equalTo(stationBackKey.snp_right).offset(WIDTH_DYNAMIC(15))
            make.width.equalTo(WIDTH_DYNAMIC(280))
            make.height.equalTo(30)
        }
        
        //返程上车时间
        lineBackView.addSubview(startTimeKey)
        startTimeKey.text="发车时间"
        startTimeKey.font=UIFont.systemFontOfSize(13)
        startTimeKey.snp_makeConstraints { (make) in
            make.top.equalTo(startStationBackKey.snp_bottom).offset(HEIGHT_DYNAMIC(25))
            make.left.equalTo(lineBackView).offset(WIDTH_DYNAMIC(15))
        }
        //返程timeBackImgView
        lineBackView.addSubview(timeBackImgView)
        timeBackImgView.image=UIImage(named: "icon_time")
        timeBackImgView.snp_makeConstraints { (make) in
            make.top.equalTo(startStationBackKey.snp_bottom).offset(HEIGHT_DYNAMIC(25))
            make.left.equalTo(startTimeKey.snp_right).offset(WIDTH_DYNAMIC(15))
        }
        //返程timeBackValue
        lineBackView.addSubview(timeBackValue)
        timeBackValue.font=UIFont.systemFontOfSize(13)
        timeBackValue.textColor=COLOR_TEXT
        timeBackValue.snp_makeConstraints { (make) in
            make.top.equalTo(startStationBackKey.snp_bottom).offset(HEIGHT_DYNAMIC(25))
            make.left.equalTo(timeBackImgView.snp_right).offset(WIDTH_DYNAMIC(15))
        }
        
        
        lineBackView.snp_updateConstraints { (make) in
            make.bottom.equalTo(timeBackImgView.snp_bottom).offset(5)
//            make.bottom.equalTo(lineView.snp_bottom).offset(HEIGHT_DYNAMIC(0))
        }
        
        //－－－－－－－－－－－－－－－－orderView预订视图－－－－－－－－－－－－－
        contentView.addSubview(orderView)
        orderView.backgroundColor=UIColor.whiteColor()
        orderView.layer.borderWidth=1
        orderView.layer.borderColor=COLOR_SEGMENTATION.CGColor
        orderView.snp_makeConstraints { (make) in
            make.top.equalTo(lineBackView.snp_bottom).offset(HEIGHT_DYNAMIC(15))
            make.left.equalTo(contentView).offset(0)
            make.right.equalTo(contentView).offset(0)
        }
        //预定期次
        orderView.addSubview(orderTerm)
        orderTerm.font=UIFont.systemFontOfSize(13)
        orderTerm.text="预订期次"
        orderTerm.snp_makeConstraints { (make) in
            make.top.equalTo(orderView).offset(HEIGHT_DYNAMIC(20))
            make.left.equalTo(orderView).offset(WIDTH_DYNAMIC(20))
        }
        //期次内容
        orderView.addSubview(orderTermValue)
        orderTermValue.textColor=COLOR_TEXT
//        orderTermValue.text="2015-2016学年第一学期"
        orderTermValue.font=UIFont.systemFontOfSize(13)
        orderTermValue.snp_makeConstraints { (make) in
            make.top.equalTo(orderTerm.snp_top)
            make.left.equalTo(orderTerm.snp_right).offset(WIDTH_DYNAMIC(15))
        }
        
        //开行方式key
        orderView.addSubview(moveWayKey)
        moveWayKey.text="开行方式"
        moveWayKey.font=UIFont.systemFontOfSize(13)
        moveWayKey.snp_makeConstraints { (make) in
            make.top.equalTo(orderTerm.snp_bottom).offset(HEIGHT_DYNAMIC(15))
            make.left.equalTo(orderView).offset(WIDTH_DYNAMIC(20))
        }
        
        //开行方式value
        orderView.addSubview(moveWayValue)
        moveWayValue.textColor=COLOR_TEXT
        moveWayValue.font=UIFont.systemFontOfSize(13)
        moveWayValue.snp_makeConstraints { (make) in
            make.top.equalTo(orderTerm.snp_bottom).offset(HEIGHT_DYNAMIC(15))
            make.left.equalTo(moveWayKey.snp_right).offset(15)
        }
        
        //乘车日期
        orderView.addSubview(busDate)
        busDate.text="乘车日期"
        busDate.font=UIFont.systemFontOfSize(13)
        busDate.snp_makeConstraints { (make) in
            make.top.equalTo(moveWayKey.snp_bottom).offset(HEIGHT_DYNAMIC(20))
            make.left.equalTo(orderView).offset(WIDTH_DYNAMIC(20))
        }
        //日期控件
        busDateKit.userInteractionEnabled=true
        busDateKit.layer.borderColor=COLOR_SEGMENTATION.CGColor
        busDateKit.layer.borderWidth=1
        busDateKit.layer.cornerRadius=2.5
        busDateKit.font=UIFont.systemFontOfSize(13)
        busDateKit.leftView=UIView(frame: CGRectMake(0,0,13,10))
        busDateKit.leftViewMode=UITextFieldViewMode.Always
        busDateKit.textColor=COLOR_TEXT
        orderView.addSubview(busDateKit)
        busDateKit.snp_makeConstraints { (make) in
            make.top.equalTo(moveWayKey.snp_bottom).offset(HEIGHT_DYNAMIC(15))
            make.left.equalTo(busDate.snp_right).offset(WIDTH_DYNAMIC(10))
            make.width.equalTo(WIDTH_DYNAMIC(280))
            make.height.equalTo(30)
        }
        let busDateGest=UITapGestureRecognizer()
        busDateGest.addTarget(self, action: #selector(CPLineInfoView.dateChoose))
        busDateGest.numberOfTapsRequired=1
        busDateKit.addGestureRecognizer(busDateGest)
        //添加乘客
        orderView.addSubview(passenger)
        passenger.text="添加乘客"
        passenger.font=UIFont.systemFontOfSize(13)
        passenger.snp_makeConstraints { (make) in
            make.top.equalTo(busDate.snp_bottom).offset(HEIGHT_DYNAMIC(28))
            make.left.equalTo(orderView).offset(WIDTH_DYNAMIC(20))
        }
        //乘客视图
        orderView.addSubview(psgView)
        psgView.snp_makeConstraints { (make) in
            make.top.equalTo(busDate.snp_bottom).offset(HEIGHT_DYNAMIC(25))
            make.left.equalTo(passenger.snp_right).offset(WIDTH_DYNAMIC(10))
//            make.right.equalTo(orderView).offset(-10)
        }

        //－－－－－－－－－－－－orderView底部－－－－－－－－－－－－－
        orderView.snp_updateConstraints { (make) in
//            make.bottom.equalTo(addPassgerBtn.snp_bottom).offset(10)
            make.bottom.equalTo(psgView.snp_bottom).offset(10)
        }
        
        //－－－－－－－－－－－－－－－－－comfirmView确认视图－－－－－－－－－－－－
        contentView.addSubview(comfirmView)
        comfirmView.layer.borderWidth=1
        comfirmView.layer.borderColor=COLOR_SEGMENTATION.CGColor
        comfirmView.backgroundColor=UIColor.whiteColor()
        comfirmView.snp_makeConstraints { (make) in
            make.top.equalTo(orderView.snp_bottom).offset(HEIGHT_DYNAMIC(15))
            make.left.equalTo(contentView).offset(0)
            make.right.equalTo(contentView).offset(0)
//            make.height.equalTo((130))
        }
        //通讯地址
        comfirmView.addSubview(connectAddress)
        connectAddress.text="通讯地址"
        connectAddress.font=UIFont.systemFontOfSize(13)
        connectAddress.snp_makeConstraints { (make) in
            make.top.equalTo(comfirmView).offset(HEIGHT_DYNAMIC(25))
            make.left.equalTo(comfirmView).offset(WIDTH_DYNAMIC(20))
        }

        //新增地址按钮
        comfirmView.addSubview(addPassgerAddress)
        addPassgerAddress.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        addPassgerAddress.setTitle("新增", forState: UIControlState.Normal)
        addPassgerAddress.titleLabel!.font=UIFont.systemFontOfSize(13)
        addPassgerAddress.layer.borderColor=COLOR_SEGMENTATION.CGColor
        addPassgerAddress.layer.borderWidth=1
        addPassgerAddress.layer.cornerRadius=2.5
        addPassgerAddress.tag=10
        addPassgerAddress.addTarget(self, action: #selector(CPLineInfoView.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        addPassgerAddress.snp_makeConstraints { (make) in
            make.top.equalTo(comfirmView).offset(HEIGHT_DYNAMIC(20))
            make.width.equalTo(WIDTH_DYNAMIC(40))
            make.right.equalTo(comfirmView).offset(WIDTH_DYNAMIC(-10))
            make.height.equalTo(30)
        }
        
        //确认乘车合同勾选框
        comfirmView.addSubview(agreementCbx)
        agreementCbx.selected=true
        agreementCbx.setImage(UIImage(named: "icon_m_sel"), forState: UIControlState.Selected)
        agreementCbx.setImage(UIImage(named: "icon_m_unsel"), forState: UIControlState.Normal)
        agreementCbx.addTarget(self, action: #selector(CPLineInfoView.agreementCbxClick), forControlEvents: UIControlEvents.TouchUpInside)
        agreementCbx.snp_makeConstraints { (make) in
            make.top.equalTo(addPassgerAddress.snp_bottom).offset(HEIGHT_DYNAMIC(15))
            make.left.equalTo(connectAddress.snp_right).offset(WIDTH_DYNAMIC(10))
        }
        //确认乘车合同勾选框文本
        let agreementLb=UILabel()
        comfirmView.addSubview(agreementLb)
        agreementLb.textColor=COLOR_TEXT
        agreementLb.text="我已确认"
        agreementLb.font=UIFont.systemFontOfSize(12)
        agreementLb.snp_makeConstraints { (make) in
            make.top.equalTo(addPassgerAddress.snp_bottom).offset(HEIGHT_DYNAMIC(18))
            make.left.equalTo(agreementCbx.snp_right).offset(WIDTH_DYNAMIC(5))
        }
        //乘车合同
        let agreement=UILabel()
        agreement.text="乘车合同"
        agreement.font=UIFont.systemFontOfSize(12)
        let agreementStr=NSMutableAttributedString(string: agreement.text!, attributes: attrs)
        agreement.attributedText=agreementStr
        comfirmView.addSubview(agreement)
        agreement.snp_makeConstraints { (make) in
            make.top.equalTo(addPassgerAddress.snp_bottom).offset(HEIGHT_DYNAMIC(18))
            make.left.equalTo(agreementLb.snp_right)
        }
        //并遵守
        let agreementLb2=UILabel()
        agreementLb2.textColor=COLOR_TEXT
        agreementLb2.text=",并遵守"
        agreementLb2.font=UIFont.systemFontOfSize(12)
        comfirmView.addSubview(agreementLb2)
        agreementLb2.snp_makeConstraints { (make) in
            make.top.equalTo(addPassgerAddress.snp_bottom).offset(HEIGHT_DYNAMIC(18))
            make.left.equalTo(agreement.snp_right)
        }
        //乘车规范
        let standard=UILabel()
        standard.text="乘车规范"
        standard.textColor=COLOR_TEXT
        standard.font=UIFont.systemFontOfSize(12)
        let standardStr=NSMutableAttributedString(string: standard.text!, attributes: attrs)
        standard.attributedText=standardStr
        comfirmView.addSubview(standard)
        standard.snp_makeConstraints { (make) in
            make.top.equalTo(addPassgerAddress.snp_bottom).offset(HEIGHT_DYNAMIC(18))
            make.left.equalTo(agreementLb2.snp_right)
        }
        
        //发票勾选框
        comfirmView.addSubview(billCbx)
        billCbx.selected=false
        billCbx.setImage(UIImage(named: "icon_m_sel"), forState: UIControlState.Selected)
        billCbx.setImage(UIImage(named: "icon_m_unsel"), forState: UIControlState.Normal)
        billCbx.addTarget(self, action: #selector(self.billCbxClick), forControlEvents: UIControlEvents.TouchUpInside)
        billCbx.snp_makeConstraints { (make) in
            make.top.equalTo(agreementCbx.snp_bottom).offset(HEIGHT_DYNAMIC(15))
            make.left.equalTo(connectAddress.snp_right).offset(WIDTH_DYNAMIC(10))
        }
        //发票文本
        let billLb=UILabel()
        comfirmView.addSubview(billLb)
        billLb.text="我要发票及纸质合同"
        billLb.font=UIFont.systemFontOfSize(12)
        billLb.textColor=COLOR_TEXT
        billLb.snp_makeConstraints { (make) in
            make.top.equalTo(agreementCbx.snp_bottom).offset(HEIGHT_DYNAMIC(18))
            make.left.equalTo(billCbx.snp_right).offset(WIDTH_DYNAMIC(5))
        }
        comfirmView.snp_updateConstraints { (make) in
            make.bottom.equalTo(billLb.snp_bottom).offset(20)
        }
        //-----------------------购票按钮----------------------
        contentView.addSubview(submit)
        submit.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: UIControlState.Normal)
        submit.tag=3
        submit.setTitle("购      票", forState: UIControlState.Normal)
        submit.tintColor=UIColor.whiteColor()
        submit.titleLabel?.font=UIFont.systemFontOfSize(15)
        submit.layer.cornerRadius=WIDTH_DYNAMIC(15)
        submit.addTarget(self, action: #selector(CPLineInfoView.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        submit.snp_makeConstraints { (make) in
            make.top.equalTo(comfirmView.snp_bottom).offset(HEIGHT_DYNAMIC(15))
            make.left.equalTo(contentView).offset(WIDTH_DYNAMIC(40))
            make.right.equalTo(contentView).offset(WIDTH_DYNAMIC(-40))
            make.height.equalTo(35)
        }
        
        //乘客地址下拉框
        addressDropMenu.dropMenuTag=13
        addressDropMenu.placeholder="我们将为您配送乘车卡等相关资料"
        addressDropMenu.delegate=self
        addressDropMenu.buttonImage=UIImage(named: "icon_down")
        addressDropMenu.editable=false
        addressDropMenu.font=UIFont.systemFontOfSize(12)
        addressDropMenu.textColor=COLOR_TEXT
        addressDropMenu.layer.borderColor=COLOR_SEGMENTATION.CGColor
        addressDropMenu.layer.borderWidth=1
        scrollView.insertSubview(addressDropMenu, belowSubview: calendarView)
        addressDropMenu.snp_makeConstraints { (make) in
            make.top.equalTo(comfirmView).offset(HEIGHT_DYNAMIC(20))
            make.left.equalTo(connectAddress.snp_right).offset(WIDTH_DYNAMIC(10))
            make.width.equalTo(WIDTH_DYNAMIC(230))
            make.height.equalTo(30)
        }

        //----------------------contentView边界--------------------
        contentView.snp_updateConstraints { (make) in
            make.edges.equalTo(scrollView).offset(UIEdgeInsetsZero)
            make.width.equalTo(self.bounds.size.width)
            make.bottom.equalTo(submit.snp_bottom).offset(HEIGHT_DYNAMIC(10))
        }

        //---------------------日期视图---------------------------
        contentView.addSubview(dateView)
        dateView.hidden=true
        dateView.backgroundColor=UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 0.5)
        dateView.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView).offset(UIEdgeInsetsZero)
        }

        //----------------calendarView--start---------------
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CPLineInfoView.getNewDate(_:)), name: "date", object: nil)
        scrollView.addSubview(calendarView)
        calendarView.hidden=true
        calendarView.frame.size=CGSizeMake(300, 300)
        calendarView.layer.borderWidth = 1
        calendarView.layer.borderColor = UIColor.lightGrayColor().CGColor
        calendarView.backgroundColor = UIColor.whiteColor()

        //---------------------calendarView--end-------------------
//        changeOrderInfoView.addSubview(payView)
        showRecruit(isShowRecruit)   //招募中线路详情
//        showFullSeat()  //满座线路详情
        showChangeOrder(isShowChangeOrder) //改签线路详情
    }

    
    //招募中线路详情
    func showRecruit(isRecruit:Bool){
        if isRecruit==true {
            //recruitView
            contentView.addSubview(recruitView)
            recruitView.backgroundColor=UIColor.whiteColor()
            recruitView.layer.borderWidth=1
            recruitView.layer.borderColor=COLOR_SEGMENTATION.CGColor
            recruitView.snp_makeConstraints { (make) in
                make.top.equalTo(contentView).offset(HEIGHT_DYNAMIC(15))
                make.left.equalTo(contentView).offset(0)
                make.right.equalTo(contentView).offset(0)
            }
            //recruitLineName
            recruitView.addSubview(recruitLineName)
            recruitLineName.font=UIFont.systemFontOfSize(15)
            recruitLineName.numberOfLines=0
            recruitLineName.snp_remakeConstraints { (make) in
                make.top.equalTo(recruitView).offset(HEIGHT_DYNAMIC(20))
                make.left.equalTo(recruitView).offset(WIDTH_DYNAMIC(15))
                make.width.lessThanOrEqualTo(self.bounds.size.width/3*2)
            }
            //recruitLb
            recruitView.addSubview(recruitLb)
            recruitLb.layer.borderWidth=1
            recruitLb.layer.borderColor=UIColor(red: 131/255, green: 201/255, blue: 87/255, alpha: 1).CGColor
            recruitLb.text="招募中"
            recruitLb.textColor=UIColor(red: 131/255, green: 201/255, blue: 87/255, alpha: 1)
            recruitLb.layer.borderWidth=1.5
            recruitLb.font=UIFont.systemFontOfSize(13)
            recruitLb.textAlignment=NSTextAlignment.Center
            recruitLb.snp_makeConstraints { (make) in
                make.centerY.equalTo(recruitView)
                make.right.equalTo(recruitView).offset(WIDTH_DYNAMIC(-15))
                make.size.equalTo(CGSizeMake(60, 30))
            }
            
            //expectLb
            recruitView.addSubview(expectLb)
            expectLb.font=UIFont.systemFontOfSize(13)
            expectLb.textColor=COLOR_TEXT
            expectLb.numberOfLines=0
            expectLb.snp_makeConstraints { (make) in
                make.top.equalTo(recruitLineName.snp_bottom).offset(HEIGHT_DYNAMIC(5))
                make.left.equalTo(recruitView).offset(WIDTH_DYNAMIC(15))
                make.width.lessThanOrEqualTo(self.bounds.size.width/3*2)
            }            
            recruitView.snp_updateConstraints { (make) in
                make.bottom.equalTo(expectLb.snp_bottom).offset(HEIGHT_DYNAMIC(20))
            }
            
            //参加按钮
            contentView.addSubview(joinBtn)
            joinBtn.tag=1
            joinBtn.layer.cornerRadius=HEIGHT_DYNAMIC(15)
            joinBtn.titleLabel?.font=UIFont.systemFontOfSize(15)
            joinBtn.setTitle("我 要 参 加", forState: UIControlState.Normal)
            joinBtn.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: UIControlState.Normal)
            joinBtn.tintColor=UIColor.whiteColor()
            joinBtn.addTarget(self, action: #selector(CPLineInfoView.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            joinBtn.snp_makeConstraints { (make) in
                make.top.equalTo(recruitView.snp_bottom).offset(HEIGHT_DYNAMIC(20))
                make.left.equalTo(contentView).offset(WIDTH_DYNAMIC(40))
                make.right.equalTo(contentView).offset(WIDTH_DYNAMIC(-40))
                make.height.equalTo(35)
            }
            comfirmView.hidden=true
            orderView.hidden=true
            submit.hidden=true
            addressDropMenu.hidden=true
            lineView.hidden=true
            lineBackView.hidden=true
            startStationDropMenu.hidden=true
            startStationBackDropMenu.hidden=true
            addNameBtn.hidden=true
            changeBtn.hidden=true
            contentView.snp_remakeConstraints(closure: { (make) in
                make.top.equalTo(scrollView).offset(0)
                make.left.equalTo(scrollView).offset(0)
                make.width.equalTo(self.bounds.size.width)
                make.bottom.equalTo(joinBtn.snp_bottom).offset(HEIGHT_DYNAMIC(20))
            })
        }
        else{
            joinBtn.hidden=true
        }
    }
    
    //满座线路详情
    func showFullSeat(){
            //报名按钮
            contentView.addSubview(addNameBtn)
            addNameBtn.tag=2
            addNameBtn.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: UIControlState.Normal)
            addNameBtn.layer.cornerRadius=HEIGHT_DYNAMIC(15)
            addNameBtn.titleLabel?.font=UIFont.systemFontOfSize(15)
            addNameBtn.setTitle("我 要 报 名", forState: UIControlState.Normal)
            addNameBtn.tintColor=UIColor.whiteColor()
            addNameBtn.addTarget(self, action: #selector(CPLineInfoView.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            addNameBtn.snp_makeConstraints { (make) in
                make.top.equalTo(lineView.snp_bottom).offset(HEIGHT_DYNAMIC(20))
                make.left.equalTo(contentView).offset(WIDTH_DYNAMIC(40))
                make.right.equalTo(contentView).offset(WIDTH_DYNAMIC(-40))
                make.height.equalTo(35)
            }
            
            lineView.addSubview(orderTermKeyFull)
            lineView.addSubview(orderTermValueFull)
            lineView.addSubview(openWayKey)
            lineView.addSubview(openWayValue)
            
            //预订期次
            orderTermKeyFull.font=UIFont.systemFontOfSize(13)
            orderTermKeyFull.text="预订期次"
            orderTermKeyFull.snp_makeConstraints { (make) in
                make.top.equalTo(lineDetailMap.snp_bottom).offset(HEIGHT_DYNAMIC(10))
                make.left.equalTo(lineView).offset(WIDTH_DYNAMIC(15))
            }
            //期次内容
            orderTermValueFull.textColor=COLOR_TEXT
            orderTermValueFull.font=UIFont.systemFontOfSize(13)
            orderTermValueFull.snp_makeConstraints { (make) in
                make.top.equalTo(lineDetailMap.snp_bottom).offset(HEIGHT_DYNAMIC(10))
                make.left.equalTo(orderTermKeyFull.snp_right).offset(WIDTH_DYNAMIC(10))
            }
            
            //开行方式key
            openWayKey.text="开行方式"
            openWayKey.font=UIFont.systemFontOfSize(13)
            openWayKey.snp_makeConstraints { (make) in
                make.top.equalTo(orderTermKeyFull.snp_bottom).offset(HEIGHT_DYNAMIC(15))
                make.left.equalTo(lineView).offset(WIDTH_DYNAMIC(15))
            }
            
            //开行方式value
            openWayValue.textColor=COLOR_TEXT
            openWayValue.font=UIFont.systemFontOfSize(13)
            openWayValue.snp_makeConstraints { (make) in
                make.top.equalTo(orderTermKeyFull.snp_bottom).offset(HEIGHT_DYNAMIC(15))
                make.left.equalTo(openWayKey.snp_right).offset(10)
            }
            comfirmView.hidden=true
            submit.hidden=true
            addressDropMenu.hidden=true
            lineBackView.hidden=true
            startStationDropMenu.hidden=true
            startStationBackDropMenu.hidden=true
            recruitView.hidden=true
            joinBtn.hidden=true
            psgView.hidden=true
            calendarView.hidden=true
            addPassgerBtn.hidden=true
            startStationLb.hidden=true
            startTimeLb.hidden=true
            timeValue.hidden=true
            timeImgView.hidden=true
            dateView.hidden=true
            busDate.hidden=true
            busDateKit.hidden=true
            passenger.hidden=true
            orderView.hidden=true
            changeBtn.hidden=true
            scrollView.scrollEnabled=false
            wLabel.removeFromSuperview()
            lineNameLb.snp_remakeConstraints { (make) in
                make.top.equalTo(lineView).offset(HEIGHT_DYNAMIC(20))
                make.left.equalTo(lineView).offset(WIDTH_DYNAMIC(15))
                make.width.lessThanOrEqualTo(self.bounds.size.width/3*2)
        }
    }
    
    //改签线路详情
    func showChangeOrder(isChangeOrder:Bool){
        if isChangeOrder==true {
            orderView.addSubview(psgNameValue)
            psgNameValue.font=UIFont.systemFontOfSize(14)
            psgNameValue.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(passenger.snp_top).offset(0)
                make.left.equalTo(passenger.snp_right).offset(WIDTH_DYNAMIC(15))
            })
            //改签按钮
            contentView.addSubview(changeBtn)
            changeBtn.tag=4
            changeBtn.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: UIControlState.Normal)
            changeBtn.layer.cornerRadius=HEIGHT_DYNAMIC(15)
            changeBtn.titleLabel?.font=UIFont.systemFontOfSize(15)
            changeBtn.setTitle("改    签", forState: UIControlState.Normal)
            changeBtn.tintColor=UIColor.whiteColor()
            changeBtn.addTarget(self, action: #selector(CPLineInfoView.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            changeBtn.snp_makeConstraints { (make) in
                make.top.equalTo(orderView.snp_bottom).offset(HEIGHT_DYNAMIC(20))
                make.left.equalTo(contentView).offset(WIDTH_DYNAMIC(40))
                make.right.equalTo(contentView).offset(WIDTH_DYNAMIC(-40))
                make.height.equalTo(35)
            }
            contentView.snp_remakeConstraints(closure: { (make) in
                make.edges.equalTo(scrollView).offset(UIEdgeInsetsZero)
                make.width.equalTo(self.bounds.size.width)
                make.bottom.equalTo(changeBtn.snp_bottom).offset(HEIGHT_DYNAMIC(20))
            })
            
            comfirmView.hidden=true
            submit.hidden=true
            joinBtn.hidden=true
            addNameBtn.hidden=true
            addressDropMenu.hidden=true
            lineBackView.hidden=true
            recruitView.hidden=true
            startStationBackDropMenu.hidden=true
            addPassgerBtn.hidden=true
            passenger.text="乘       客"
            wLabel.removeFromSuperview()
            lineNameLb.snp_updateConstraints(closure: { (make) in
                make.left.equalTo(lineView).offset(WIDTH_DYNAMIC(15))
            })
            psgView.snp_remakeConstraints(closure: { (make) in
                make.height.equalTo(0)
            })
            orderView.snp_remakeConstraints { (make) in
                make.top.equalTo(lineView.snp_bottom).offset(HEIGHT_DYNAMIC(15))
                make.left.equalTo(contentView).offset(0)
                make.right.equalTo(contentView).offset(0)
                make.bottom.equalTo(passenger.snp_bottom).offset(HEIGHT_DYNAMIC(20))
            }
            //--------------------改签提示信息-------------------
            contentView.addSubview(changeOrderView)
            changeOrderView.backgroundColor=UIColor.grayColor()
            changeOrderView.alpha=0.8
            changeOrderView.hidden=true
            changeOrderView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(self).offset(UIEdgeInsetsZero)
            })
            
            contentView.addSubview(changeOrderInfoView)
            changeOrderInfoView.hidden=true
            changeOrderInfoView.backgroundColor=UIColor.whiteColor()
            changeOrderInfoView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(contentView).offset(HEIGHT_DYNAMIC(50))
                make.left.equalTo(contentView).offset(WIDTH_DYNAMIC(40))
                make.right.equalTo(contentView).offset(WIDTH_DYNAMIC(-40))
            })
            
            changeOrderInfoView.addSubview(changeInfoLb)
            changeInfoLb.text="您的改签信息如下："
            changeInfoLb.font=UIFont.systemFontOfSize(15)
            changeInfoLb.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(changeOrderInfoView).offset(HEIGHT_DYNAMIC(10))
                make.left.equalTo(changeOrderInfoView).offset(WIDTH_DYNAMIC(10))
            })
            
            changeOrderInfoView.addSubview(orgLineKey)
            orgLineKey.font=UIFont.systemFontOfSize(14)
            orgLineKey.text="原线路："
            orgLineKey.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(changeInfoLb.snp_bottom).offset(HEIGHT_DYNAMIC(10))
                make.left.equalTo(changeOrderInfoView).offset(WIDTH_DYNAMIC(10))
            })
            
            changeOrderInfoView.addSubview(orgLineValue)
            orgLineValue.font=UIFont.systemFontOfSize(14)
            orgLineValue.numberOfLines=0
            orgLineValue.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(changeInfoLb.snp_bottom).offset(HEIGHT_DYNAMIC(10))
                make.left.equalTo(orgLineKey.snp_right).offset(WIDTH_DYNAMIC(10))
            })
            
            changeOrderInfoView.addSubview(newLineKey)
            newLineKey.font=UIFont.systemFontOfSize(14)
            newLineKey.text="改签线路："
            newLineKey.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(orgLineKey.snp_bottom).offset(HEIGHT_DYNAMIC(10))
                make.left.equalTo(changeOrderInfoView).offset(WIDTH_DYNAMIC(10))
            })
            
            changeOrderInfoView.addSubview(newLineValue)
            newLineValue.font=UIFont.systemFontOfSize(14)
            newLineValue.numberOfLines=0
            newLineValue.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(orgLineKey.snp_bottom).offset(HEIGHT_DYNAMIC(10))
                make.left.equalTo(newLineKey.snp_right).offset(WIDTH_DYNAMIC(10))
            })
            changeOrderInfoView.addSubview(addOrReduceMoneyKey)
            addOrReduceMoneyKey.font=UIFont.systemFontOfSize(14)
            addOrReduceMoneyKey.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(newLineKey.snp_bottom).offset(HEIGHT_DYNAMIC(10))
                make.left.equalTo(changeOrderInfoView).offset(WIDTH_DYNAMIC(10))
            })
            
            changeOrderInfoView.addSubview(addOrReduceMoneyValue)
            addOrReduceMoneyValue.font=UIFont.systemFontOfSize(14)
            addOrReduceMoneyValue.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(newLineKey.snp_bottom).offset(HEIGHT_DYNAMIC(10))
                make.left.equalTo(addOrReduceMoneyKey.snp_right).offset(WIDTH_DYNAMIC(10))
            })
            changeOrderInfoView.addSubview(customDividingLine)
            customDividingLine.backgroundColor=UIColor.grayColor()
            customDividingLine.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(addOrReduceMoneyKey.snp_bottom).offset(HEIGHT_DYNAMIC(10))
                make.left.right.equalTo(changeOrderInfoView).offset(0)
                make.height.equalTo(1)
            })
            //只能改签一次
            changeOrderInfoView.addSubview(onlyChangeOnceLb)
            onlyChangeOnceLb.text="每条线路仅限改签一次"
            onlyChangeOnceLb.textColor=UIColor.redColor()
            onlyChangeOnceLb.font=UIFont.systemFontOfSize(13)
            onlyChangeOnceLb.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(customDividingLine.snp_bottom).offset(HEIGHT_DYNAMIC(10))
                make.left.equalTo(changeOrderInfoView).offset(WIDTH_DYNAMIC(10))
                make.right.equalTo(changeOrderInfoView).offset(WIDTH_DYNAMIC(-10))
            })
            //分割线
            changeOrderInfoView.addSubview(customDividingLine2)
            customDividingLine2.backgroundColor=UIColor.grayColor()
            customDividingLine2.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(onlyChangeOnceLb.snp_bottom).offset(HEIGHT_DYNAMIC(10))
                make.left.right.equalTo(changeOrderInfoView).offset(0)
                make.height.equalTo(1)
            })
            
            
//            payView.addSubview(payWayLb)
//            payView.addSubview(aliPayButton)
//            payView.addSubview(weixinPayButton)
//            payView.addSubview(unionPayButton)
//            payView.addSubview(payButton)
//            payView.addSubview(aliPayLabel)
//            payView.addSubview(aliPayImageView)
//            payView.addSubview(weixinPayLabel)
//            payView.addSubview(weixinPayImageView)
//            payView.addSubview(unionPayLabel)
//            payView.addSubview(unionPayImageView)
            
            changeOrderInfoView.addSubview(payWayLb)
            changeOrderInfoView.addSubview(aliPayButton)
            changeOrderInfoView.addSubview(weixinPayButton)
            changeOrderInfoView.addSubview(unionPayButton)
            changeOrderInfoView.addSubview(payButton)
            changeOrderInfoView.addSubview(aliPayLabel)
            changeOrderInfoView.addSubview(aliPayImageView)
            changeOrderInfoView.addSubview(weixinPayLabel)
            changeOrderInfoView.addSubview(weixinPayImageView)
            changeOrderInfoView.addSubview(unionPayLabel)
            changeOrderInfoView.addSubview(unionPayImageView)
            
            
            
            changeOrderInfoView.addSubview(comfirmBtn)
            comfirmBtn.setTitle("确定改签", forState: UIControlState.Normal)
            comfirmBtn.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: UIControlState.Normal)
            comfirmBtn.tag=5
            comfirmBtn.layer.cornerRadius=HEIGHT_DYNAMIC(15)
            comfirmBtn.titleLabel?.font=UIFont.systemFontOfSize(15)
            comfirmBtn.tintColor=UIColor.whiteColor()
            comfirmBtn.addTarget(self, action: #selector(CPLineInfoView.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            comfirmBtn.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(customDividingLine2.snp_bottom).offset(HEIGHT_DYNAMIC(10))
                make.left.equalTo(changeOrderInfoView).offset(WIDTH_DYNAMIC(40))
                make.right.equalTo(changeOrderInfoView).offset(WIDTH_DYNAMIC(-40))
                make.height.equalTo(30)
            })
            
            changeOrderInfoView.addSubview(cancelBtn)
            cancelBtn.setTitle("取消改签", forState: UIControlState.Normal)
            cancelBtn.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: UIControlState.Normal)
            cancelBtn.tag=6
            cancelBtn.layer.cornerRadius=HEIGHT_DYNAMIC(15)
            cancelBtn.titleLabel?.font=UIFont.systemFontOfSize(15)
            cancelBtn.tintColor=UIColor.whiteColor()
            cancelBtn.addTarget(self, action: #selector(CPLineInfoView.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            cancelBtn.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(comfirmBtn.snp_bottom).offset(HEIGHT_DYNAMIC(20))
                make.left.equalTo(changeOrderInfoView).offset(WIDTH_DYNAMIC(40))
                make.right.equalTo(changeOrderInfoView).offset(WIDTH_DYNAMIC(-40))
                make.height.equalTo(30)
            })
            changeOrderInfoView.snp_updateConstraints(closure: { (make) in
                make.bottom.equalTo(cancelBtn.snp_bottom).offset(HEIGHT_DYNAMIC(15))
            })
            
            
        }
        else{
            
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        payView.snp_makeConstraints { (make) in
//            make.top.equalTo(customDividingLine2.snp_bottom).offset(HEIGHT_DYNAMIC(0))
//            make.left.equalTo(changeOrderInfoView).offset(WIDTH_DYNAMIC(0))
//            make.bottom.equalTo(unionPayButton.snp_bottom).offset(0)
//        }
//        
//    }
    
    //添加乘客
    func addPsg(){
        psgIdsArray.removeAllObjects()
        for i in 0..<psgIdsSelectedAr.count{
            psgIdsDic.removeAllObjects()
            let psgBool=psgIdsSelectedAr[i] as! Int
            if(psgBool==1){
                psgIdsDic.setValue(resultList[i].objectForKey("psgId"), forKey: "psgId")
                psgIdsDic.setValue(0, forKey: "isRemadeCard")
                let dic = NSDictionary.init(dictionary: psgIdsDic)
                psgIdsArray.addObject(dic)
            }
            
        }
    }

    //招募中和普通线路数据
    var joinLineInfo:NSDictionary? {
        didSet{
            let count=joinLineInfo?.objectForKey("count")   //已有参与人数
//            let type=joinLineInfo?.objectForKey("type")     //固定值为2，表示定制线路
            if let info=joinLineInfo?.objectForKey("info") {
                if let departAddr=info.objectForKey("departAddr") as? String {  //出发地点
                
                let destAddr=info.objectForKey("destAddr") as? String  //到达地点
                let grade=info.objectForKey("grade") as? String        //推荐年级
                let departTime=info.objectForKey("departTime") as? String  //出发时间
                let isNeedBack=info.objectForKey("isNeedBack") as! Bool  //是否有往返，有＝true
                let expectTripText=(isNeedBack ? "往返程" : "单程")
                recruitLineName.text=departAddr+" - "+destAddr!
                expectLb.text="\(getGradeString(grade!))年级，家长期望\(departTime!)出发，在\(departAddr)上车，\(expectTripText)，已有\(count!)位家长参加"
                }
                else {
                    joinBtn.enabled=false
                    let alertView=UIAlertView(title: "提示", message: "数据异常，请联系开发人员", delegate: self, cancelButtonTitle: "确定")
                    alertView.show()
                }
            }
        }
    }
    
    //满座线路数据
    var lineInfoObj:NSDictionary? {
        didSet{
            let seatNum=lineInfoObj?.objectForKey("seatNum") as! Int
            if(seatNum<=0){
                showFullSeat()
            }
            
        }
    }
    //改签订单数据
    var orderViewData:NSDictionary? {
        didSet {
            psgNameValue.text=orderViewData?.objectForKey("psgList")![0]?.objectForKey("psg_name") as? String
        }
    }
    
    //乘车日期数据
    var newDateArray:NSArray?{
        didSet{
            calendarView.selectionRangeLength = 1
            calendarView.delegate = self
            calendarView.availableDates=(newDateArray as! [NSDate])
            calendarView.selectedDates=[newDateArray![0] as! NSDate]
//            calendarView.maxMonths = 8
            calendarView.createCalendar()
//            calendarView.scrollToDate(newDateArray!.firstObject as! NSDate, animated: true)
        }
    }

    
    //改签提示信息
    var changeOrderViewData:NSDictionary? {
        didSet{
            if changeOrderViewData?.count>0 {
                cj=changeOrderViewData?.objectForKey("cj") as! String
                orgLineValue.text=changeOrderViewData?.objectForKey("orgLineName") as? String
                newLineValue.text=changeOrderViewData?.objectForKey("lineName") as? String
                addOrReduceMoneyValue.text=cj
                
                if(cj>String(0)){
                    addOrReduceMoneyKey.text="退款金额："
                }
                else if(cj<String(0)){
                    payWayLb.font=UIFont.systemFontOfSize(18)
                    payWayLb.text="付款方式："
                    payWayLb.snp_makeConstraints(closure: { (make) in
                        make.top.equalTo(customDividingLine2.snp_bottom).offset(HEIGHT_DYNAMIC(10))
                        make.left.equalTo(changeOrderInfoView).offset(WIDTH_DYNAMIC(10))
                    })
                    addOrReduceMoneyKey.text="需补差价："
                    let cjAdd:String=(cj as NSString).substringFromIndex(1)
                    addOrReduceMoneyValue.text=cjAdd
                    aliPayButton.snp_makeConstraints { (make) in
                        make.top.equalTo(payWayLb.snp_bottom).offset(HEIGHT_DYNAMIC(5))
                        make.left.equalTo(changeOrderInfoView).offset(WIDTH_DYNAMIC(10))
                        make.right.equalTo(changeOrderInfoView).offset(-10)
                    }
                    
                    aliPayLabel.snp_makeConstraints { (make) in
                        make.left.equalTo(aliPayButton).offset(10)
                        make.centerY.equalTo(aliPayButton)
                    }
                    
                    aliPayImageView.snp_makeConstraints { (make) in
                        make.right.equalTo(aliPayButton).offset(-10)
                        make.centerY.equalTo(aliPayButton)
                    }
                    
                    weixinPayButton.snp_makeConstraints { (make) in
                        make.left.equalTo(aliPayButton)
                        make.width.equalTo(aliPayButton)
                        make.top.equalTo(aliPayButton.snp_bottom).offset(1)
                    }
                    
                    weixinPayLabel.snp_makeConstraints { (make) in
                        make.left.equalTo(weixinPayButton).offset(10)
                        make.centerY.equalTo(weixinPayButton)
                    }
                    
                    weixinPayImageView.snp_makeConstraints { (make) in
                        make.right.equalTo(weixinPayButton).offset(-10)
                        make.centerY.equalTo(weixinPayButton)
                    }
                    
                    unionPayButton.snp_makeConstraints { (make) in
                        make.left.equalTo(aliPayButton)
                        make.width.equalTo(aliPayButton)
                        make.top.equalTo(weixinPayButton.snp_bottom).offset(1)
                    }
                    
                    unionPayLabel.snp_makeConstraints { (make) in
                        make.left.equalTo(unionPayButton).offset(10)
                        make.centerY.equalTo(unionPayButton)
                    }
                    
                    unionPayImageView.snp_makeConstraints { (make) in
                        make.right.equalTo(unionPayButton).offset(-10)
                        make.centerY.equalTo(unionPayButton)
                    }
                    
                    comfirmBtn.snp_remakeConstraints(closure: { (make) in
                        make.top.equalTo(unionPayButton.snp_bottom).offset(HEIGHT_DYNAMIC(10))
                        make.left.equalTo(changeOrderInfoView).offset(WIDTH_DYNAMIC(40))
                        make.right.equalTo(changeOrderInfoView).offset(WIDTH_DYNAMIC(-40))
                        make.height.equalTo(30)
                    })
                    
                    
                    aliPayButton.addTarget(self, action: #selector(CPLineInfoView.selectedPayType(_:)), forControlEvents: .TouchUpInside)
                    weixinPayButton.addTarget(self, action: #selector(CPLineInfoView.selectedPayType(_:)), forControlEvents: .TouchUpInside)
                    unionPayButton.addTarget(self, action: #selector(CPLineInfoView.selectedPayType(_:)), forControlEvents: .TouchUpInside)
                }
                else{
                    addOrReduceMoneyKey.snp_remakeConstraints(closure: { (make) in
                        make.top.equalTo(newLineKey.snp_bottom).offset(0)
                        make.bottom.equalTo(newLineKey.snp_bottom).offset(0)
                    })
                    addOrReduceMoneyValue.snp_remakeConstraints(closure: { (make) in
                        make.top.equalTo(newLineKey.snp_bottom).offset(0)
                        make.bottom.equalTo(newLineKey.snp_bottom).offset(0)
                    })
                }
            }
            else{
                changeBtn.selected=false
            }
        }
    }
    
    
    let aliPayButton: UIButton = {
        let view = UIButton()
        view.tag = 0
        view.backgroundColor = Constants.whiteBGColor
        return view
    }()
    private let aliPayLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.mediumFont
        view.text = "支付宝付款"
        return view
    } ()
    private let aliPayImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_sel")
        return view
    } ()
    
    let weixinPayButton: UIButton = {
        let view = UIButton()
        view.tag = 1
        view.backgroundColor = Constants.whiteBGColor
        return view
    }()
    private let weixinPayLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.mediumFont
        view.text = "微信付款"
        return view
    } ()
    private let weixinPayImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_unsel")
        return view
    } ()
    
    let unionPayButton: UIButton = {
        let view = UIButton()
        view.tag = 2
        view.backgroundColor = Constants.whiteBGColor
        return view
    }()
    private let unionPayLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.mediumFont
        view.text = "银联付款"
        return view
    } ()
    private let unionPayImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_unsel")
        return view
    } ()
    
    let payButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setTitle("支  付", forState: .Normal)
        btn.tintColor = Constants.whiteWordColor
        btn.layer.cornerRadius = 16
        btn.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: .Normal)
        return btn
    } ()
    
    
    //addressDropMenu
    var psgAddressAr2:Int=1 {
        didSet{

            let addressAr=NSMutableArray()
            if(psgAddressAr.count>0){
                for i in 0..<psgAddressAr.count{
                    let address=psgAddressAr[i].objectForKey("address")!
                    addressAr.addObject(address)
                }
                dropRowAddress=0
                addressDropMenu.options=addressAr
                addressDropMenu.defaultValue=(addressAr[0] as! String)
            }


        }
        
    }
    
    //所有按钮的点击事件
    func btnClick(sender:UIButton){
        if(self.delegate != nil){
            self.delegate?.goNextCtl(sender.tag)
        }

    }
    
    //所有标签的点击事件
    func lbClick(){
        if(self.delegate != nil){
            self.delegate?.goLineDetailMap()
        }
    }

    //选择支付方式
    func selectedPayType(button: UIButton) {
        let alertView = UIAlertView(title: "提示", message: "目前暂只支持支付宝支付", delegate: self, cancelButtonTitle: "确定")
        alertView.show()
    }

    //日期选择框
    func dateChoose(){
        dateView.hidden=false
        calendarView.hidden=false
    }
    

    //合同单选框
    func agreementCbxClick(){
        agreementCbx.selected = !agreementCbx.selected
        if !agreementCbx.selected {
            submit.enabled=false
            submit.backgroundColor=UIColor.lightGrayColor()
        }else{
            submit.enabled=true
            submit.backgroundColor=COLOR_TEXT_YELLOW
        }
    }
    //发票
    func billCbxClick(){
        billCbx.selected = !billCbx.selected
        if billCbx.selected==true {
            isNeedContract=1
        }else{
            isNeedContract=0
        }
    }
    
    //通讯地址Id
    func getUasId()->Int{
        var uasId:Int!
        uasId = -1
        if dropRowAddress != nil {
            uasId=psgAddressAr[dropRowAddress].objectForKey("uasId") as! Int
        }
        return uasId

    }
    
    //选择完后回调
    func dropDownMenu(menu: ZHDropDownMenu!, didChoose index: Int, dropMenuTag:Int ) {
        if(dropMenuTag==11){
            dropRowW=index
            if isShowChangeOrder==true {
                timeValue.text=stationListAr[dropRowW].objectForKey("departTime") as? String
                getOnStationW=stationListAr[dropRowW].objectForKey("stationId") as! Int
                getOffStationW=stationListAr.lastObject!.objectForKey("stationId") as! Int
                
            }
            else{
                timeValue.text=stationListAr[dropRowW].objectForKey("departTime") as? String
            }
        }
        if(dropMenuTag==12){
            dropRowF=index
            timeBackValue.text=stationListArBack[dropRowF].objectForKey("departTime") as? String
        }
        if(dropMenuTag==13){
            dropRowAddress=index
        }
        
    }

    
    //编辑完成后回调
    func dropDownMenu(menu: ZHDropDownMenu!, didInput text: String!) {
        //        print("\(menu) input text \(text)")
    }
    
    func psgRefresh(){
        for i in 0..<psgButtonArray.count{
            psgButtonArray[i].removeFromSuperview()
        }
        
    }
    
    //乘客列表
    var resultList:NSArray! {
        didSet{
//            if(resultList.count != 0){
                let constantValue:Int=2
                let resultCount=resultList.count+1
                var num:Int!
                psgIdsSelectedAr.removeAllObjects()
                for _ in 0..<resultList.count{
                    psgIdsSelectedAr.addObject(0)
                }
                if(resultCount%constantValue==0){
                    num=Int(resultCount/constantValue)
                    
                }else{
                    num=Int(resultCount/constantValue)+1
                }
                psgButtonArray.removeAll()
                var k:Int!
                for i in 0..<num {
                    for j in 0..<constantValue{
                        k=i*constantValue+j
                        if(k>=resultCount){
//                            print("超出范围")
                            break
                        }
                        else{
                            if(k==resultCount-1){
                                //addPassgerBtn,添加乘客按钮
                                orderView.addSubview(addPassgerBtn)
                                addPassgerBtn.setImage(UIImage(named: "icon_add_passenger"), forState: UIControlState.Normal)
                                addPassgerBtn.setTitle("添加乘客", forState: UIControlState.Normal)
                                addPassgerBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                                addPassgerBtn.titleLabel!.font=UIFont.systemFontOfSize(13)
                                addPassgerBtn.snp_makeConstraints { (make) in
                                    make.top.equalTo(psgView).offset(i*30)
                                    make.left.equalTo(psgView).offset(j*108)
                                }
                                psgView.snp_updateConstraints(closure: { (make) in
                                    make.height.equalTo(30*(i+1))
                                })
                                psgButtonArray.append(addPassgerBtn)
                                break
                            }
                            //passgerCbx
                            let passgerCbx=UIButton()       //乘客多选框
                            orderView.addSubview(passgerCbx)
                            passgerCbx.selected=false
                            passgerCbx.tag=100+k
                            passgerCbx.setImage(UIImage(named: "icon_m_sel"), forState: UIControlState.Selected)
                            passgerCbx.setImage(UIImage(named: "icon_m_unsel"), forState: UIControlState.Normal)
                            passgerCbx.addTarget(self, action: #selector(CPLineInfoView.passgerCbxClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                            passgerCbx.userInteractionEnabled=true
                            passgerCbx.setTitle(((resultList[k].objectForKey("psgName")) as! String), forState: UIControlState.Normal)
                            passgerCbx.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, -5)
                            passgerCbx.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                            passgerCbx.titleLabel!.font=UIFont.systemFontOfSize(14)
                            if isShowChangeOrder==true {
                                passgerCbx.removeFromSuperview()
                            }
                            else {
                                passgerCbx.snp_makeConstraints(closure: { (make) in
                                    make.top.equalTo(psgView).offset(i*30)
                                    make.left.equalTo(psgView).offset(j*110)
                                })
                            }
                            
                            psgButtonArray.append(passgerCbx)
                        }
                    }
//                }
                
                
            }
            
 
        }

    }

    
    //乘客多选按钮
    func passgerCbxClick(sender:UIButton){
        sender.selected = !sender.selected
        psgIdsSelectedAr.replaceObjectAtIndex(sender.tag-100, withObject: sender.selected == true ? 1 : 0)
        
    }

}


extension CPLineInfoView: NWCalendarViewDelegate {
    func didChangeFromMonthToMonth(fromMonth: NSDateComponents, toMonth: NSDateComponents) {
//        let dateFormatter: NSDateFormatter = NSDateFormatter()
//        let months = dateFormatter.standaloneMonthSymbols
//        let fromMonthName = months[fromMonth.month-1] as String
//        let toMonthName = months[toMonth.month-1] as String
//        print("Change From '\(fromMonthName)' to '\(toMonthName)'")
    }
    
    func didSelectDate(fromDate: NSDateComponents, toDate: NSDateComponents) {
//        print("Selected date '\(fromDate.month)/\(fromDate.day)/\(fromDate.year)' to date '\(toDate.month)/\(toDate.day)/\(toDate.year)'")
        let dataFormatter=NSDateFormatter()
        dataFormatter.dateFormat="yyyy年MM月dd日"
        let lastDate=dataFormatter.stringFromDate(newDateArray!.lastObject as! NSDate)
        busDateKit.text="\(toDate.year)年\(toDate.month)月\(toDate.day)日 至 \(lastDate)"
        startDate="\(toDate.year)-\(toDate.month)-\(toDate.day)"
        dateView.hidden=true
        calendarView.hidden=true
    }

}