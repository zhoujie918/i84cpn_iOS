//
//  CPPaidDetailView.swift
//  i84cpn
//  已付款详情
//  Created by Benjamin on 16/5/28.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPPaidDetailView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(scrollView)
        scrollView.addSubview(tipLabel1)
        scrollView.addSubview(containView)
        scrollView.addSubview(selectSeatButton)
        scrollView.addSubview(repayCardButton)
        scrollView.addSubview(endorseButton)
        scrollView.addSubview(unsubscribeButton)
        
        containView.addSubview(routeLabel)
        containView.addSubview(line)
        containView.addSubview(tipLabel2)
        containView.addSubview(stateTitleLabel)
        containView.addSubview(stateLabel)
        containView.addSubview(issueTitleLabel)
        containView.addSubview(issueLabel)
        containView.addSubview(gradeTitleLabel)
        containView.addSubview(gradeLabel)
        containView.addSubview(rideDateTitleLabel)
        containView.addSubview(rideDateLabel)
        containView.addSubview(riderTitleLabel)
        containView.addSubview(riderLabel)
        containView.addSubview(line2)
        containView.addSubview(amountTitleLabel)
        containView.addSubview(amountLabel)
        containView.addSubview(amountUnitLabel)
        containView.addSubview(tipLabel3)
        containView.addSubview(seatNoTitleLabel)
        containView.addSubview(seatNoLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 事件响应
    func reloadData(data: NSDictionary) {
        let issueName = data.objectForKey("issueName") as! String
        let amount = data.objectForKey("amount") as! String
        //        let isOrderGroup = data.objectForKey("isOrderGroup") as! Int
        //        let orderNo = data.objectForKey("orderNo") as! String
        let tc = data.objectForKey("tc") as! Int
        let dj = data.objectForKey("dj") as! String
        let startDate = data.objectForKey("startDate") as! String
        let seatNo = data.objectForKey("seatNo") as! String
//        let address = data.objectForKey("address") as! String
        let grade = data.objectForKey("grade") as! String
        
//        let openWay = data.objectForKey("openWay") as! String
        let lineList = data.objectForKey("lineList") as! NSArray
        //        let lineType = lineList[0].objectForKey("lineType") as! String
//        let station = lineList[0].objectForKey("station")  as! String
//        let stationTime = lineList[0].objectForKey("stationTime") as! String
        let lineName = lineList[0].objectForKey("lineName") as! String
        let antipateMileage = lineList[0].objectForKey("antipateMileage") as! String
        let antipateTime = lineList[0].objectForKey("antipateTime") as! Float
        
        let stationList = lineList[0].objectForKey("stationList") as! NSArray
        let psgList = data.objectForKey("psgList") as! NSArray
        
        var i = 0
        var nameList:String = ""
        while i < psgList.count {
            if i == psgList.count - 1 {
                nameList = nameList + (psgList[i].objectForKey("psg_name") as! String)
            } else {
                nameList = nameList + (psgList[i].objectForKey("psg_name") as! String) + "、"
            }
            i += 1
        }
        var stationListName = ""
        i = 0
        while i < stationList.count {
            if i == 0 {
                stationListName =  stationList[i].objectForKey("stationName")as! String
            } else {
                stationListName = stationListName + "、" +  (stationList[i].objectForKey("stationName")as! String)
            }
            i += 1
        }
        let openWay = data.objectForKey("openWay") as! String
        if openWay == "0" {
            gradeLabel.text = "仅工作日"
        } else {
            gradeLabel.text = "自定义"
        }
        let categoryName = data.objectForKey("categoryName") as! String
//        let index = stationListName.startIndex.advancedBy(0)
//        let index3 = stationListName.startIndex.advancedBy(23)
//        let range = Range<String.Index>(index ..< index3)
//        stationListName = stationListName.substringWithRange(range)
//        stationListName = stationListName + "..."
        let canSeat = data.objectForKey("selSeat") as! Int
   
        if seatNo == "" && canSeat == 0 {
            selectSeatButton.hidden = false
        } else {
            selectSeatButton.hidden = true
        }
        if data.objectForKey("gq") as! Int == 0 {
            endorseButton.hidden = true
        }
//        if data.objectForKey("bk") as! Int == 0 {
            repayCardButton.hidden = true
//        }

        seatNoLabel.text = seatNo
        stateLabel.text = stationListName
        riderLabel.text = nameList
//        rideAddressLabel.text = station
        routeLabel.text = lineName
//        rideTimeLabel.text = stationTime
        issueLabel.text = issueName
        amountLabel.text = amount
        tipLabel3.text = "（不含节假日，" + dj + "元/人/趟，共" + String(tc) + "趟）"
//        addressLabel.text = address
        rideDateLabel.text = startDate
        tipLabel2.text = "推荐" + getGradeString(grade) + "乘坐，" + categoryName + "\n全程" + antipateMileage + "公里 预计" + String(antipateTime) + "分钟"
//        layoutSubviews()
        updateLayout()
    }
    
    // 转换年级数据
    func getGradeString(str: String) -> String {
        var grade:String = ""
        var sign = true
        
        for c in str.characters {
            sign = true
            switch c {
            case "1" :
                grade = grade + "一年级"
            case "2" :
                grade = grade + "二年级"
            case "3" :
                grade = grade + "三年级"
            case "4" :
                grade = grade + "四年级"
            case "5" :
                grade = grade + "五年级"
            case "6" :
                grade = grade + "六年级"
            case "7" :
                grade = grade + "初一"
            case "8" :
                grade = grade + "初二"
            case "9" :
                grade = grade + "初三"
            case "a" :
                grade = grade + "高一"
            case "b" :
                grade = grade + "高二"
            case "c" :
                grade = grade + "高三"
            default:
                sign = false
                break
            }
            
            if sign {
                grade = grade + "、"
            }
        }
        let index2 = grade.endIndex.advancedBy(-1)
        grade=grade.substringToIndex(index2)
        
        return grade
    }

    func updateLayout() {
        selectSeatButton.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(containView.snp_bottom).offset(15)
            make.height.equalTo(30)
        }
        repayCardButton.snp_makeConstraints { (make) in
            make.left.equalTo(selectSeatButton)
            if selectSeatButton.hidden == true {
                make.top.equalTo(containView.snp_bottom).offset(15)
            } else {
                make.top.equalTo(selectSeatButton.snp_bottom).offset(15)
            }
            make.width.equalTo(selectSeatButton)
            make.height.equalTo(selectSeatButton)
        }
        
        endorseButton.snp_makeConstraints { (make) in
            make.left.equalTo(selectSeatButton)
            if repayCardButton.hidden == true {
                if selectSeatButton.hidden == true {
                    make.top.equalTo(containView.snp_bottom).offset(15)
                } else {
                    make.top.equalTo(selectSeatButton.snp_bottom).offset(15)
                }
            } else {
                make.top.equalTo(repayCardButton.snp_bottom).offset(15)
            }
            make.width.equalTo(selectSeatButton)
            make.height.equalTo(selectSeatButton)
        }
        
        unsubscribeButton.snp_makeConstraints { (make) in
            make.left.equalTo(selectSeatButton)
            if endorseButton.hidden == true {
                if repayCardButton.hidden == true {
                    if selectSeatButton.hidden == true {
                        make.top.equalTo(containView.snp_bottom).offset(15)
                    } else {
                        make.top.equalTo(selectSeatButton.snp_bottom).offset(15)
                    }
                } else {
                    make.top.equalTo(repayCardButton.snp_bottom).offset(15)
                }
            } else {
                make.top.equalTo(endorseButton.snp_bottom).offset(15)
            }
            make.width.equalTo(selectSeatButton)
            make.height.equalTo(selectSeatButton)
        }

    }
    
    
    // MARK:-- 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = self.frame
        scrollView.snp_makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        tipLabel1.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(10)
        }
        
        containView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(self)
            make.top.equalTo(tipLabel1.snp_bottom).offset(10)
            make.bottom.equalTo(seatNoLabel.snp_bottom).offset(10)
        }
        
        routeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.top.equalTo(containView).offset(10)
        }
        
        line.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.right.equalTo(rightOffset)
            make.top.equalTo(routeLabel.snp_bottom).offset(10)
            make.height.equalTo(1)
        }
        
        tipLabel2.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(line.snp_bottom).offset(10)
        }
        
        stateTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.top.equalTo(tipLabel2.snp_bottom).offset(8)
            make.width.equalTo(65)
        }
        
        stateLabel.snp_makeConstraints { (make) in
            make.left.equalTo(stateTitleLabel.snp_right).offset(2)
            make.top.equalTo(stateTitleLabel)
            make.right.equalTo(rightOffset)
        }
        
        issueTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.top.equalTo(stateLabel.snp_bottom).offset(8)
            make.width.equalTo(stateTitleLabel)
        }
        
        issueLabel.snp_makeConstraints { (make) in
            make.left.equalTo(issueTitleLabel.snp_right).offset(2)
            make.top.equalTo(issueTitleLabel)
            make.right.equalTo(self).offset(rightOffset)
        }
        
        gradeTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.top.equalTo(issueTitleLabel.snp_bottom).offset(8)
            make.width.equalTo(issueTitleLabel)
        }
        
        gradeLabel.snp_makeConstraints { (make) in
            make.top.equalTo(gradeTitleLabel)
            make.left.equalTo(gradeTitleLabel.snp_right).offset(2)
            make.right.equalTo(self).offset(rightOffset)
        }
        
        rideDateTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.top.equalTo(gradeLabel.snp_bottom).offset(8)
            make.width.equalTo(issueTitleLabel)
        }
        
        rideDateLabel.snp_makeConstraints { (make) in
            make.top.equalTo(rideDateTitleLabel)
            make.left.equalTo(rideDateTitleLabel.snp_right).offset(2)
            make.right.equalTo(self).offset(rightOffset)
        }
        
        riderTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.top.equalTo(rideDateLabel.snp_bottom).offset(8)
            make.width.equalTo(stateTitleLabel)
        }
        
        riderLabel.snp_makeConstraints { (make) in
            make.top.equalTo(riderTitleLabel)
            make.left.equalTo(riderTitleLabel.snp_right).offset(2)
            make.right.equalTo(self).offset(rightOffset)
        }
        
        line2.snp_makeConstraints { (make) in
            make.left.right.equalTo(line)
            make.height.equalTo(line)
            make.top.equalTo(riderLabel.snp_bottom).offset(10)
        }
        
        amountTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(routeLabel)
            make.top.equalTo(line2.snp_bottom).offset(10)
            make.width.equalTo(stateTitleLabel)
        }
        
        amountLabel.snp_makeConstraints { (make) in
            make.left.equalTo(amountTitleLabel.snp_right)
            make.bottom.equalTo(amountTitleLabel)
        }
        
        amountUnitLabel.snp_makeConstraints { (make) in
            make.left.equalTo(amountLabel.snp_right).offset(2)
            make.bottom.equalTo(amountTitleLabel)
        }
        
        tipLabel3.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(amountLabel.snp_bottom)
        }
        
        seatNoTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.top.equalTo(tipLabel3.snp_bottom).offset(10)
            make.width.equalTo(stateTitleLabel)
        }
        
        seatNoLabel.snp_makeConstraints { (make) in
            make.left.equalTo(seatNoTitleLabel.snp_right).offset(2)
            make.bottom.equalTo(seatNoTitleLabel)
        }
        
//        selectSeatButton.snp_makeConstraints { (make) in
//            make.left.equalTo(10)
//            make.right.equalTo(self).offset(-10)
//            make.top.equalTo(containView.snp_bottom).offset(15)
//            make.height.equalTo(30)
//        }
//        
//        repayCardButton.snp_makeConstraints { (make) in
//            make.left.equalTo(selectSeatButton)
//            make.top.equalTo(selectSeatButton.snp_bottom).offset(15)
//            make.width.equalTo(selectSeatButton)
//            make.height.equalTo(selectSeatButton)
//        }
//        
//        endorseButton.snp_makeConstraints { (make) in
//            make.left.equalTo(selectSeatButton)
//            make.top.equalTo(repayCardButton.snp_bottom).offset(15)
//            make.width.equalTo(selectSeatButton)
//            make.height.equalTo(selectSeatButton)
//        }
//        
//        unsubscribeButton.snp_makeConstraints { (make) in
//            make.left.equalTo(selectSeatButton)
//            make.top.equalTo(endorseButton.snp_bottom).offset(15)
//            make.width.equalTo(selectSeatButton)
//            make.height.equalTo(selectSeatButton)
//        }
        
//        scrollView.contentSize = CGSizeMake(Constants.screenWidth, unsubscribeButton.frame.origin.y + unsubscribeButton.frame.height + 100)
    }
    
    // MARK:-- 属性
    
    private let rightOffset = -10
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = Constants.paleBGColor
        return view
    } ()
    
    private let tipLabel1: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.numberOfLines = 0
        view.text = "您的订单如下："
        view.textColor = Constants.paleWordColor
        return view
    } ()
    
    private let containView = Constants.containView()
    let routeLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.mediumFont
        view.text = " "
        return view
    } ()
    
    private let line = Constants.splitLine()
    let tipLabel2: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = Constants.superSmallFont
        view.textColor = Constants.paleWordColor
        view.text = " "
        return view
    } ()
    private let stateTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.text = "途径站点："
        return view
    } ()
    let stateLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        view.text = " "
        return view
    } ()
    
    private let issueTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.text = "预订期次："
        return view
    } ()
    
    let issueLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        view.text = " "
        return view
    } ()
    
    private let gradeTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textAlignment = NSTextAlignment.Right
        view.text = "开行方式："
        return view
    } ()
    
    let gradeLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        view.text = " "
        return view
    } ()
    
    private let rideDateTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.text = "乘车日期："
        return view
    } ()
    
    let rideDateLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        view.text = " "
        return view
    } ()
    
    private let riderTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textAlignment = NSTextAlignment.Right
        view.text = "乘客："
        return view
    } ()
    
    let riderLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        view.text = " "
        return view
    } ()
    
    private let line2 = Constants.splitLine()
    
    private let amountTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textAlignment = NSTextAlignment.Right
        view.text = "总计："
        return view
    } ()
    
    let amountLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.yellowWordColor
        view.text = " "
        return view
    } ()
    
    private let amountUnitLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.text = "元"
        return view
    } ()
    
    private let tipLabel3: UILabel = {
        let view = UILabel()
        view.font = Constants.superSmallFont
        view.textColor = Constants.paleWordColor
        view.textAlignment = NSTextAlignment.Center
        view.text = " "
        return view
    } ()
    
    private let seatNoTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textAlignment = NSTextAlignment.Right
        view.text = "座位号："
        return view
    } ()
    
    let seatNoLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        view.text = " "
        return view
    } ()
    
//    let selectSeatButton: UIButton = {
//        let btn: UIButton = UIButton()
//        btn.setTitle("查看该线路最新消息", forState: .Normal)
//        btn.tintColor = Constants.whiteBGColor
//        btn.layer.cornerRadius = 16
//        btn.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: .Normal)
//        return btn
//    } ()
    let selectSeatButton: UIButton = {
        let view = UIButton()
        view.setTitle("选座", forState: .Normal)
        view.backgroundColor = Constants.whiteBGColor
        view.titleLabel?.font = Constants.smallFont
        view.setTitleColor(Constants.yellowWordColor, forState: .Normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = Constants.yellowWordColor.CGColor
        return view
    } ()
    
    let repayCardButton: UIButton = {
        let view = UIButton()
        view.setTitle("我要补卡", forState: .Normal)
        view.backgroundColor = Constants.whiteBGColor
        view.titleLabel?.font = Constants.smallFont
        view.setTitleColor(Constants.yellowWordColor, forState: .Normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = Constants.yellowWordColor.CGColor
        return view
    } ()
    
    let endorseButton: UIButton = {
        let view = UIButton()
        view.setTitle("改签", forState: .Normal)
        view.backgroundColor = Constants.whiteBGColor
        view.titleLabel?.font = Constants.smallFont
        view.setTitleColor(Constants.yellowWordColor, forState: .Normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = Constants.yellowWordColor.CGColor
        return view
    } ()
    
    let unsubscribeButton: UIButton = {
        let view = UIButton()
        view.setTitle("退订", forState: .Normal)
        view.backgroundColor = Constants.whiteBGColor
        view.titleLabel?.font = Constants.smallFont
        view.setTitleColor(Constants.yellowWordColor, forState: .Normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = Constants.yellowWordColor.CGColor
        return view
    } ()
}
