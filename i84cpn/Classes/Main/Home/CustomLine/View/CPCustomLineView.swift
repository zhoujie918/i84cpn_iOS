//
//  CPCustomLineView.swift
//  i84cpn
//
//  Created by 周杰 on 16/5/26.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPCustomLineView: UIView,ZHDropDownMenuDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate {
    
    //MARK: - 控件
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = COLOR_BACKGROUND_GRAY
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.whiteColor()
        return contentView
    }()

    //学校菜单
    private lazy var schoolMenu: ZHDropDownMenu = {
        let schoolMenu = self.creatCommonMenu(31)
        return schoolMenu
    }()

    //年级菜单
    private lazy var gradeMenu: ZHDropDownMenu = {
        let gradeMenu = self.creatCommonMenu(2)
        return gradeMenu
    }()

    //出发地选择按钮
    private lazy var btnAddress: UIButton = {
        let btnAddress = UIButton()
        btnAddress.layer.borderWidth = 1
        btnAddress.layer.borderColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1).CGColor
        btnAddress.layer.cornerRadius = 3
        btnAddress.titleLabel!.font = UIFont.systemFontOfSize(13)
        btnAddress.setTitleColor(UIColor.grayColor(), forState: .Normal)
        btnAddress.addTarget(self, action: #selector(CPCustomLineView.btnAddressClick), forControlEvents: .TouchUpInside)
        return btnAddress
    }()

    //出发时间选择按钮
    private lazy var btnStarTime: UIButton = {
        let btnStarTime = UIButton()
        btnStarTime.layer.borderWidth = 1
        btnStarTime.layer.borderColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1).CGColor
        btnStarTime.layer.cornerRadius = 3
        btnStarTime.titleLabel!.font = UIFont.boldSystemFontOfSize(14)
        btnStarTime.setTitleColor(UIColor.grayColor(), forState: .Normal)
        btnStarTime.addTarget(self, action: #selector(CPCustomLineView.btnStartTimeClick), forControlEvents: .TouchUpInside)
        return btnStarTime
    }()
    
    //时间选择控件
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = UIColor.clearColor()   //Constants.blueColor
        datePicker.locale = NSLocale.init(localeIdentifier: "zh_CN")
        datePicker.datePickerMode = .Time
        datePicker.addTarget(self, action: #selector(CPCustomLineView.datePickerValueChanged(_:)), forControlEvents: .ValueChanged)
        return datePicker
    }()
    
    //毛玻璃背景
    private lazy var blurView : UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        blur.layer.cornerRadius = 8
        blur.layer.masksToBounds = true
        let transform = CGAffineTransformScale(blur.transform, 0.01, 0.01);
        blur.transform = transform
        blur.hidden = true
        return blur
    }()
    
    //附近站点菜单
    private lazy var nearStationMenu: ZHDropDownMenu = {
        let nearStationMenu = self.creatCommonMenu(3)
        return nearStationMenu
    }()
    
    //是否接受附近公交站点上车按钮
    private lazy var btnAcceptStation: UIButton = {
        let btnAcceptStation = UIButton()
        btnAcceptStation.setImage(UIImage(named: "icon_m_unsel"), forState: UIControlState.Normal)
        btnAcceptStation.setImage(UIImage(named: "icon_m_sel"), forState: UIControlState.Selected)
        btnAcceptStation.setTitle("可接受附近公交站点上车", forState: .Normal)
        btnAcceptStation.setTitleColor(Constants.titleWordColor, forState: UIControlState.Normal)
        btnAcceptStation.titleLabel!.font = UIFont.boldSystemFontOfSize(13)
        btnAcceptStation.addTarget(self, action: #selector(CPCustomLineView.btnAcceptStationClick(_:)), forControlEvents: .TouchUpInside)
        return btnAcceptStation
    }()
    
    //附近公交站点标签
    private lazy var lblNearStation: UILabel = {
        let lblNearStation = UILabel()
        lblNearStation.font = UIFont.systemFontOfSize(13)
        lblNearStation.text = "附近公交站点"
        lblNearStation.hidden = true
        return lblNearStation
    }()
    
    //公交车站菜单
    private lazy var stationMenu: ZHDropDownMenu = {
        let stationMenu = self.creatCommonMenu(3)
        stationMenu.hidden = true
        return stationMenu
    }()
    
    //是否需要返程按钮
    private lazy var btnNeedBack: UIButton = {
        let btnNeedBack = UIButton()
        btnNeedBack.setImage(UIImage(named: "icon_m_unsel"), forState: UIControlState.Normal)
        btnNeedBack.setImage(UIImage(named: "icon_m_sel"), forState: UIControlState.Selected)
        btnNeedBack.setTitle("我需要返程", forState: .Normal)
        btnNeedBack.setTitleColor(Constants.titleWordColor, forState: UIControlState.Normal)
        btnNeedBack.titleLabel!.font = UIFont.boldSystemFontOfSize(13)
        btnNeedBack.addTarget(self, action: #selector(CPCustomLineView.btnNeedBackClick(_:)), forControlEvents: .TouchUpInside)
        return btnNeedBack
    }()
    
    //提交按钮
    private lazy var btnSubmit: UIButton = {
        let btnSubmit = UIButton()
        btnSubmit.backgroundColor = Constants.mainColor
        btnSubmit.layer.cornerRadius = 10
        btnSubmit.setTitle("提  交", forState: .Normal)
        btnSubmit.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btnSubmit.addTarget(self, action: #selector(CPCustomLineView.btnSubmitClick), forControlEvents: .TouchUpInside)
        return btnSubmit
    }()
    

    //MARK: -
    //MARK:参数
    var selectedSchool : String?
    var selectedGrade : String?
    var departTime : String?    //期望出发时间    格式：09:00
    var isRecNstation : Int = 0     //是否可接受附近公交站点   否=0，是=1
    var selecteStation : Int = -1   //选择的公交站点index
    var isNeedBack : Int = 0    //是否需要返程    否=0，是=1
    
    //代码块
    var myClosure : sendClickClosure?
    
    
    //MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init")
        self.creatViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 创建视图
    func creatViews() {
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        //labels
        self.creatLabels()

        contentView.addSubview(schoolMenu)
        contentView.addSubview(gradeMenu)
        contentView.addSubview(btnAddress)
        contentView.addSubview(btnStarTime)
        contentView.addSubview(btnAcceptStation)
        contentView.addSubview(btnNeedBack)
        contentView.addSubview(lblNearStation)
        contentView.addSubview(stationMenu)
        scrollView.addSubview(btnSubmit)
        scrollView.addSubview(blurView)
        blurView.contentView.addSubview(datePicker)

        let tap = UITapGestureRecognizer(target: self, action: #selector(CPCustomLineView.hideDatePicker))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        
    }
    
    
    //创建四行标签
    func creatLabels() {
        let arrTitle = ["您的学校","所在年级","出发地","期望出发时间"]
        for i in 0..<arrTitle.count {
            let label = UILabel()
            contentView.addSubview(label)
            label.font = UIFont.systemFontOfSize(13)
            label.text = arrTitle[i]
            label.snp_makeConstraints { (make) in
                make.top.equalTo(contentView).offset(35*(i+1) + 15*i)
                make.right.equalTo(contentView.snp_left).offset(WIDTH_DYNAMIC(100))
            }
        }
    }
    
    
    //创建菜单通用方法
    func creatCommonMenu(tag:Int) -> ZHDropDownMenu {
        let menu = ZHDropDownMenu()
        menu.buttonImage = UIImage(named: "icon_down")
        menu.editable = false
        menu.delegate = self
        menu.dropMenuTag = tag
        menu.layer.borderWidth = 1
        menu.layer.borderColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1).CGColor
        menu.layer.cornerRadius = 3
        menu.font = UIFont.systemFontOfSize(13)
        menu.textColor = UIColor.grayColor()
        return menu
    }
    
    //响应链调整
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        var result = super.hitTest(point,withEvent:event)
        if blurView.hidden == true{
            let tempoint = stationMenu.optionsList.convertPoint(point, fromView: self)
            if CGRectContainsPoint(stationMenu.optionsList.bounds, tempoint) {
                result = stationMenu.optionsList
            }
        }
        return result;
    }
    
    
    //MARK: - 数据处理
    var schoolData : NSArray? {
        didSet {
            if schoolData != nil{
                let marr = NSMutableArray.init(array: schoolData!)
                schoolMenu.options = marr
                if schoolData?.count > 0 {
                    schoolMenu.defaultValue = marr[0] as? String
                    selectedSchool  = marr[0] as? String
                }
            }
        }
    }
    
    var gradeData : NSArray? {
        didSet {
            if gradeData != nil{
                let marr = NSMutableArray.init(array: gradeData!)
                gradeMenu.options = marr
                if gradeData?.count > 0 {
                    gradeMenu.defaultValue = marr[0] as? String
                    selectedGrade = marr[0] as? String
                }
            }
        }
    }
    
    var strAddress : String? {
        didSet {
            btnAddress.setTitle(strAddress, forState: .Normal)
        }
    }
    
    var stationData : NSArray? {
        didSet {
            if stationData != nil{
                let marr = NSMutableArray.init(array: stationData!)
                stationMenu.options = marr
                if stationData?.count > 0 {
                    stationMenu.defaultValue = marr[0] as? String
                    selecteStation = 0
                }else{
                    selecteStation = -1
                }
            }
        }
    }
    
    
    //MARK: - 按钮点击事件
    //出发点选择
    func btnAddressClick() {
        if (myClosure != nil){
            myClosure!(tag:1)
        }
    }
    
    //出发时间选择
    func btnStartTimeClick() {
        if blurView.hidden == true{
            blurView.hidden = false
            weak var weakSelf = self
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .CurveEaseInOut, animations: {
                let enlarge = CGAffineTransformConcat(weakSelf!.blurView.transform,  CGAffineTransformInvert(weakSelf!.blurView.transform))
                weakSelf!.blurView.transform = enlarge
                }, completion: nil)
        }
    }
    
    //隐藏时间控件
    func hideDatePicker() {
        weak var weakSelf = self
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .CurveEaseInOut, animations: {
            let transform = CGAffineTransformScale(weakSelf!.blurView.transform, 0.01, 0.01);
            weakSelf!.blurView.transform = transform
        }) { (finish) in
            weakSelf!.blurView.hidden = true
        }
    }
    
    //是否接受附近公交站点
    func btnAcceptStationClick(sender:UIButton) {
        sender.selected = !sender.selected
        weak var weakSelf = self
        if sender.selected == true{
            isRecNstation = 1
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .AllowUserInteraction, animations: {
                weakSelf!.contentView.snp_updateConstraints { (make) in
                    make.bottom.equalTo(weakSelf!.btnAcceptStation.snp_bottom).offset(110)
                }
                weakSelf?.layoutIfNeeded()
                weakSelf?.lblNearStation.hidden = false
                weakSelf?.stationMenu.hidden = false
            }) { (finish) in
            }
        }else{
            isRecNstation = 0
            self.stationMenu.hide()
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .CurveEaseInOut, animations: {
                weakSelf!.contentView.snp_updateConstraints { (make) in
                    make.bottom.equalTo(weakSelf!.btnAcceptStation.snp_bottom).offset(70)
                }
                weakSelf?.layoutIfNeeded()
                weakSelf?.lblNearStation.hidden = true
                weakSelf?.stationMenu.hidden = true
            }) { (finish) in
            }
        }

    }
    
    //是否需要返程
    func btnNeedBackClick(sender:UIButton) {
        sender.selected = !sender.selected
        if sender.selected == true{
            isNeedBack = 1
        }else{
            isNeedBack = 0
        }
    }
    
    //提交
    func btnSubmitClick() {
        if selectedSchool == nil{
            self.showAlert("请选择您的学校")
            return
        }
        if selectedGrade == nil{
            self.showAlert("请选择您所在的年级")
            return
        }
        if btnAddress.titleLabel?.text == nil{
            self.showAlert("请填写您的出发地")
            return
        }else{
            let strAddress = btnAddress.titleLabel?.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            if strAddress == ""{
                self.showAlert("请填写您的出发地")
                return
            }
        }
        if btnStarTime.titleLabel?.text == nil{
            self.showAlert("请填写您的出发时间")
            return
        }
        if isRecNstation == 1{
            if selecteStation == -1{
                self.showAlert("请选择一个附近的公交站点")
                return
            }
        }
        if (myClosure != nil){
            myClosure!(tag:2)
        }
    }
    
    func showAlert(message : String) {
        let alertV = UIAlertView.init(title: "提示", message: message, delegate: nil, cancelButtonTitle: "确定")
        alertV.show()
    }
    
    
    //MARK: - 代码块回调
    func initWithClosure(closure:sendClickClosure?){
        myClosure = closure
    }
    
    
    //MARK: 监听时间控件值变化
    func datePickerValueChanged(piker : UIDatePicker) {
        let format = NSDateFormatter()
        format.dateFormat = "HH:mm"
        let strTime = format.stringFromDate(datePicker.date)
        btnStarTime.setTitle(strTime, forState: .Normal)
        departTime = strTime
    }
    
    
    //MARK: UIGestureRecognizerDelegate
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if blurView.hidden == true{
            return false
        }else{
            return true
        }
    }
    
    
    //MARK: UITextField Delegate
    func textFieldDidBeginEditing(textField: UITextField) {
        self.hideDatePicker()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //MARK: 菜单选择回调
    func dropDownMenu(menu: ZHDropDownMenu!, didChoose index: Int, dropMenuTag: Int) {
        switch dropMenuTag {
        case 31:
            selectedSchool = menu.options[index] as? String
            break
        case 2:
            selectedGrade = menu.options[index] as? String
            break
        case 3:
            selecteStation = index
            break
            
        default:
            break
        }
    }

    func dropDownMenu(menu: ZHDropDownMenu!, didInput text: String!) {
        
    }
    
    
    //MARK: - 布局 (有BUG)
    override func layoutSubviews() {
        weak var weakSelf = self
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(weakSelf!)
        }
        contentView.snp_makeConstraints { (make) in
            make.top.equalTo(scrollView).offset(HEIGHT_DYNAMIC(20))
            make.left.right.equalTo(weakSelf!)
        }
        schoolMenu.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(27)
            make.left.equalTo(contentView).offset(WIDTH_DYNAMIC(115))
            make.right.equalTo(contentView).offset(-WIDTH_DYNAMIC(30))
            make.height.equalTo(32)
        }
        gradeMenu.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(77)
            make.left.right.equalTo(schoolMenu)
            make.height.equalTo(schoolMenu)
        }
        btnAddress.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(127)
            make.left.right.equalTo(schoolMenu)
            make.height.equalTo(schoolMenu)
        }
        btnStarTime.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(177)
            make.left.right.equalTo(schoolMenu)
            make.height.equalTo(schoolMenu)
        }
        blurView.snp_makeConstraints { (make) in
            make.center.equalTo(weakSelf!)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH - WIDTH_DYNAMIC(80), HEIGHT_DYNAMIC(200)))
        }
        datePicker.snp_makeConstraints { (make) in
            make.center.equalTo(weakSelf!)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH - WIDTH_DYNAMIC(80), HEIGHT_DYNAMIC(200)))
        }
        btnAcceptStation.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(235)
            make.left.equalTo(schoolMenu)
            make.height.equalTo(20)
        }
        lblNearStation.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(btnAcceptStation.snp_bottom).offset(25)
            make.right.equalTo(contentView.snp_left).offset(WIDTH_DYNAMIC(100))
        })
        stationMenu.snp_makeConstraints(closure: { (make) in
            make.centerY.equalTo(lblNearStation)
            make.left.right.equalTo(schoolMenu)
            make.height.equalTo(schoolMenu)
        })
        btnNeedBack.snp_makeConstraints { (make) in
            make.bottom.equalTo(contentView).offset(-25)
            make.left.equalTo(schoolMenu)
            make.height.equalTo(20)
        }
        contentView.snp_updateConstraints { (make) in
            make.bottom.equalTo(btnAcceptStation.snp_bottom).offset(70)
        }
        btnSubmit.snp_makeConstraints { (make) in
            make.top.equalTo(contentView.snp_bottom).offset(30)
            make.left.equalTo(weakSelf!).offset(WIDTH_DYNAMIC(35))
            make.right.equalTo(weakSelf!).offset(-WIDTH_DYNAMIC(35))
            make.height.equalTo(35)
        }
    }
    
}