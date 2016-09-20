//
//  CPUnPaidOneLineDetailView.swift
//  i84cpn
//  未付款单程详情
//  Created by BenjaminRichard on 16/5/26.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit
protocol UnPaidOneLineDetailViewDelegate {
    func lookDetail1()
}
class CPUnPaidOneLineDetailView: UIView {
    var delegate: UnPaidOneLineDetailViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(scrollView)
        scrollView.addSubview(tipLabel1)
        scrollView.addSubview(containView)
        scrollView.addSubview(tipLabel4)
        scrollView.addSubview(tipLabel5)
        scrollView.addSubview(aliPayButton)
        scrollView.addSubview(weixinPayButton)
        scrollView.addSubview(unionPayButton)
        scrollView.addSubview(payButton)
        
        containView.addSubview(routeLabel)
        containView.addSubview(tipLabel2)
        containView.addSubview(stateTitleLabel)
        containView.addSubview(stateButton)
        containView.addSubview(line1)
        containView.addSubview(issueTitleLabel)
        containView.addSubview(issueLabel)
        containView.addSubview(rideDateTitleLabel)
        containView.addSubview(rideDateLabel)
        containView.addSubview(riderTitleLabel)
        containView.addSubview(riderLabel)
        containView.addSubview(rideAddressTitleLabel)
        containView.addSubview(rideAddressLabel)
        containView.addSubview(rideTimeTitleLabel)
        containView.addSubview(rideTimeLabel)
        containView.addSubview(line2)
        containView.addSubview(addressTitleLabel)
        containView.addSubview(addressLabel)
        containView.addSubview(amountTitle1Label)
        containView.addSubview(amountTitle2Label)
        containView.addSubview(amountLabel)
        containView.addSubview(amountUnitLabel)
        containView.addSubview(tipLabel3)
        
        aliPayButton.addSubview(aliPayLabel)
        aliPayButton.addSubview(aliPayImageView)
        weixinPayButton.addSubview(weixinPayLabel)
        weixinPayButton.addSubview(weixinPayImageView)
        unionPayButton.addSubview(unionPayLabel)
        unionPayButton.addSubview(unionPayImageView)
        
        aliPayButton.addTarget(self, action: #selector(selectedPayType), forControlEvents: .TouchUpInside)
        weixinPayButton.addTarget(self, action: #selector(selectedPayType), forControlEvents: .TouchUpInside)
        unionPayButton.addTarget(self, action: #selector(selectedPayType), forControlEvents: .TouchUpInside)
        
        
        let press = UITapGestureRecognizer(target: self, action: #selector(lookDetail))
        press.numberOfTapsRequired = 1
        stateButton.addGestureRecognizer(press)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 手势响应
    func lookDetail() {
        if delegate != nil {
            delegate!.lookDetail1()
        }
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

        
//        let seatNo = data.objectForKey("seatNo") as! String
        let address = data.objectForKey("address") as! String
        let grade = data.objectForKey("grade") as! String
        
        
        let lineList = data.objectForKey("lineList") as! NSArray
        let lineType = lineList[0].objectForKey("lineType") as! String
        let station = lineList[0].objectForKey("station")  as! String
        let stationTime = lineList[0].objectForKey("stationTime") as! String
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
        
        if lineType == "0" {  // 早
            rideAddressTitleLabel.text = "上车地点："
            rideTimeTitleLabel.text = "上车时间："
        } else {
            rideTimeTitleLabel.text = "发车时间："
            rideAddressTitleLabel.text = "下车地点："
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
        
//        if stationListName.characters.count > 23 {
//            let index = stationListName.startIndex.advancedBy(0)
//            let index3 = stationListName.startIndex.advancedBy(23)
//            let range = Range<String.Index>(index ..< index3)
//            stationListName = stationListName.substringWithRange(range)
//            stationListName = stationListName + "..."
//        }
        
        let text1: NSMutableAttributedString = NSMutableAttributedString(string: stationListName, attributes: [NSForegroundColorAttributeName: Constants.blackWordColor])
        let text2: NSMutableAttributedString = NSMutableAttributedString(string: "查看线路图", attributes: [NSForegroundColorAttributeName: Constants.redWordColor])
        text1.appendAttributedString(text2)
        
//        stateButton.setAttributedTitle(text1, forState: .Normal)
        stateButton.attributedText = text1
        riderLabel.text = nameList
        rideAddressLabel.text = station
        routeLabel.text = lineName
        rideTimeLabel.text = stationTime
        issueLabel.text = issueName
        amountLabel.text = amount
        tipLabel3.text = "（不含节假日，" + dj + "元/人/趟，共" + String(tc) + "趟）"
        addressLabel.text = address
        rideDateLabel.text = startDate
        tipLabel2.text = "推荐" + getGradeString(grade) + "乘坐，全程" + antipateMileage + "公里 预计" + String(antipateTime) + "分钟"
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

    
    func selectedPayType(button: UIButton) {
//        if button.tag != selectedId {
//            switch selectedId {
//            case 0:
//                aliPayImageView.image = UIImage(named: "icon_unsel")
//            case 1:
//                weixinPayImageView.image = UIImage(named: "icon_unsel")
//            case 2:
//                unionPayImageView.image = UIImage(named: "icon_unsel")
//            default:
//                break
//            }
//            
//            selectedId = button.tag
//            switch selectedId {
//            case 0:
//                aliPayImageView.image = UIImage(named: "icon_sel")
//            case 1:
//                weixinPayImageView.image = UIImage(named: "icon_sel")
//            case 2:
//                unionPayImageView.image = UIImage(named: "icon_sel")
//            default:
//                break
//            }
//        }
        let alertView = UIAlertView(title: "提示", message: "目前暂只支持支付宝支付", delegate: self, cancelButtonTitle: "确定")
        alertView.show()
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        tipLabel1.snp_makeConstraints { (make) in
            make.top.equalTo(scrollView).offset(16)
            make.left.equalTo(scrollView).offset(10)
        }
        
        containView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(self)
            make.top.equalTo(tipLabel1.snp_bottom).offset(10)
            make.bottom.equalTo(tipLabel3.snp_bottom).offset(10)
        }
        
        routeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.top.equalTo(containView).offset(10)
        }

        
        
        tipLabel2.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.top.equalTo(routeLabel.snp_bottom).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        stateTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.top.equalTo(tipLabel2.snp_bottom).offset(8)
            make.width.equalTo(65)
        }
        
        stateButton.snp_makeConstraints { (make) in
            make.left.equalTo(stateTitleLabel.snp_right).offset(2)
            make.top.equalTo(tipLabel2.snp_bottom).offset(8)
            make.right.equalTo(self).offset(rightOffset)
        }
       
        line1.snp_makeConstraints { (make) in
            make.left.equalTo(routeLabel)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(1)
            make.top.equalTo(stateButton.snp_bottom).offset(8)
        }
        
        issueTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.top.equalTo(line1.snp_bottom).offset(8)
            make.width.equalTo(stateTitleLabel)
        }
        
        issueLabel.snp_makeConstraints { (make) in
            make.left.equalTo(issueTitleLabel.snp_right).offset(2)
            make.top.equalTo(issueTitleLabel)
            make.right.equalTo(self).offset(rightOffset)
        }
        
        rideDateTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.top.equalTo(issueTitleLabel.snp_bottom).offset(8)
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
        
        rideAddressTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.top.equalTo(riderLabel.snp_bottom).offset(8)
            make.width.equalTo(stateTitleLabel)
        }
        
        rideAddressLabel.snp_makeConstraints { (make) in
            make.top.equalTo(rideAddressTitleLabel)
            make.left.equalTo(rideAddressTitleLabel.snp_right).offset(2)
            make.right.equalTo(self).offset(rightOffset)
        }
        
        rideTimeTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel1)
            make.top.equalTo(rideAddressLabel.snp_bottom).offset(8)
            make.width.equalTo(stateTitleLabel)
        }
        
        rideTimeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(rideTimeTitleLabel.snp_right).offset(2)
            make.top.equalTo(rideTimeTitleLabel)
            make.right.equalTo(self).offset(rightOffset)
        }
        
        line2.snp_makeConstraints { (make) in
            make.left.right.equalTo(line1)
            make.height.equalTo(line1)
            make.top.equalTo(rideTimeTitleLabel.snp_bottom).offset(10)
        }
        
        addressTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(routeLabel)
            make.top.equalTo(line2.snp_bottom).offset(10)
            make.width.equalTo(stateTitleLabel)
        }
        
        addressLabel.snp_makeConstraints { (make) in
            make.left.equalTo(addressTitleLabel.snp_right)
            make.top.equalTo(addressTitleLabel)
            make.right.equalTo(self).offset(rightOffset)
        }
        
        amountTitle1Label.snp_makeConstraints { (make) in
            make.left.equalTo(routeLabel)
            make.top.equalTo(addressLabel.snp_bottom).offset(10)
            make.width.equalTo(stateTitleLabel)
        }
        
        amountTitle2Label.snp_makeConstraints { (make) in
            make.left.equalTo(amountTitle1Label.snp_right)
            make.top.equalTo(amountTitle1Label)
        }
        
        amountLabel.snp_makeConstraints { (make) in
            make.left.equalTo(amountTitle2Label.snp_right)
            make.top.equalTo(amountTitle1Label)
        }
        
        amountUnitLabel.snp_makeConstraints { (make) in
            make.left.equalTo(amountLabel.snp_right)
            make.top.equalTo(amountTitle1Label)
        }

        
        tipLabel3.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(amountLabel.snp_bottom)
        }
        
        tipLabel4.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(containView.snp_bottom).offset(10)
        }
        
        tipLabel5.snp_makeConstraints { (make) in
            make.left.equalTo(routeLabel)
            make.top.equalTo(tipLabel4.snp_bottom).offset(8)
        }
        
        aliPayButton.snp_makeConstraints { (make) in
            make.left.equalTo(routeLabel)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(tipLabel5.snp_bottom).offset(8)
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
        
        payButton.snp_makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(self).offset(-30)
            make.top.equalTo(unionPayButton.snp_bottom).offset(30)
        }
        
//        scrollView.contentSize = CGSizeMake(Constants.screenWidth, payButton.frame.origin.y + payButton.frame.height + 100)
    }
    
    
    // MARK:-- 属性
    private var selectedId = 0
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
        view.text = "福州南站－》时代中学"
        return view
    } ()
    
    let tipLabel2: UILabel = {
        let view = UILabel()
        view.font = Constants.superSmallFont
        view.numberOfLines = 0
        view.textColor = Constants.paleWordColor
        view.text = "推荐初一／初二年级乘坐，全程22公里，预计45分钟"
        return view
    } ()
    private let stateTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.text = "途径站点："
        return view
    } ()
    
    let stateButton: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = Constants.smallFont
        view.userInteractionEnabled = true
//        let text1: NSMutableAttributedString = NSMutableAttributedString(string: "福州市晋安区闽古屋、福州市鼓楼区五一广场、福州...", attributes: [NSForegroundColorAttributeName: Constants.paleWordColor])
//        let text2: NSMutableAttributedString = NSMutableAttributedString(string: "查看详细线路图", attributes: [NSForegroundColorAttributeName: Constants.redWordColor])
//        text1.appendAttributedString(text2)
//        
//        view.setAttributedTitle(text1, forState: .Normal)
        return view
    } ()
    

    private let line1 = Constants.splitLine()
    
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
        view.text = "2015-2016学年第一学期"
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
        view.text = "2015年9月1日"
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
        view.text = "张三"
        return view
    } ()
    
    private let rideAddressTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textAlignment = NSTextAlignment.Right
        view.text = "上车地点："
        return view
    } ()
    
    let rideAddressLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        view.text = "闽侯县乾隆成（公交车站）"
        return view
    } ()
    
    private let rideTimeTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textAlignment = NSTextAlignment.Right
        view.text = "上车时间："
        return view
    } ()
    
    let rideTimeLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        view.text = "17.27"
        return view
    } ()
    private let line2 = Constants.splitLine()
    
    private let addressTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textAlignment = NSTextAlignment.Right
        view.text = "通讯地址："
        return view
    } ()
    
    let addressLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        view.text = "福州市福马路45号富裕世家"
        return view
    } ()
    
    private let amountTitle1Label: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textAlignment = NSTextAlignment.Right
        view.text = "总计："
        return view
    } ()
    
    private let amountTitle2Label: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.text = " "
        return view
    } ()

    let amountLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.mediumFont
        view.textColor = Constants.yellowWordColor
        view.text = "720"
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
        view.text = "(不含节假日，8元/人／趟，共90趟"
        return view
    } ()
    
    private let tipLabel4: UILabel = {
        let view = UILabel()
        view.font = Constants.superSmallFont
        view.textColor = Constants.redWordColor
        view.textAlignment = NSTextAlignment.Center
        view.text = "请在1小时内完成支付，超时订单将自动关闭"
        return view
    } ()
    private let tipLabel5: UILabel = {
        let view = UILabel()
        view.font = Constants.superSmallFont
        view.textColor = Constants.paleWordColor
        view.text = "付款方式"
        return view
    } ()

    
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


}
