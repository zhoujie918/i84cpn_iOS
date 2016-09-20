//
//  CPLineResultTableViewBackCell.swift
//  i84cpn
//
//  Created by 周杰 on 16/5/27.
//  Copyright © 2016年 5i84. All rights reserved.
//  线路搜索结果cell

import UIKit

class CPLineResultTableViewBackCell: UITableViewCell {
    var lineName=UILabel()          //线路名称
    var grade=UILabel()             //推荐年级
    var stationName=UILabel()       //途径站点
    var price=UILabel()             //价格
    var priceUnit=UILabel()         //价格单位
    var cellGest=UITapGestureRecognizer()
    
    var lineW=UILabel()
    var lineF=UILabel()
    var lineNameBack=UILabel()
//    var priceBack=UILabel()
//    var priceBackUnit=UILabel()
    
    var recruitLb=UILabel()         //招募中标签
    var fullSeatLb=UILabel()          //满座标签
    
    var isRecruit:String!           //是否是招募中状态，1招募中
    var seatNum:AnyObject!             //座位数，数字为0时显示满座状态
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //        self.backgroundColor=UIColor.whiteColor()
        //lineName线路名称
        //        cellGest.numberOfTapsRequired=1
        //        self.addGestureRecognizer(cellGest)
        
        self.contentView.addSubview(lineW)
        lineW.text="[往] "
        lineW.textColor=COLOR_TEXT_ORANGE
        lineW.font=UIFont.systemFontOfSize(14)
        lineW.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(HEIGHT_DYNAMIC(10))
            make.left.equalTo(self).offset(WIDTH_DYNAMIC(20))
        }
        
        self.contentView.addSubview(lineF)
        lineF.text="[返] "
        lineF.textColor=COLOR_TEXT_ORANGE
        lineF.font=UIFont.systemFontOfSize(14)
        lineF.snp_makeConstraints { (make) in
            make.top.equalTo(lineW.snp_bottom).offset(HEIGHT_DYNAMIC(5))
            make.left.equalTo(lineW.snp_left).offset(0)
        }
        
        
        //线路名称，往
        self.contentView.addSubview(lineName)
        lineName.numberOfLines=1
        lineName.font=UIFont.systemFontOfSize(14)
        lineName.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(HEIGHT_DYNAMIC(10))
            make.left.equalTo(lineW.snp_right).offset(WIDTH_DYNAMIC(5))
            make.width.lessThanOrEqualTo(self.bounds.width/3*2-20)
            //            make.width.equalTo(self.bounds.width/2)
            //            make.height.equalTo(HEIGHT_DYNAMIC(15))
        }
        //线路名称，返
        self.contentView.addSubview(lineNameBack)
        lineNameBack.numberOfLines=1
        lineNameBack.font=UIFont.systemFontOfSize(14)
        lineNameBack.snp_makeConstraints { (make) in
            make.top.equalTo(lineName.snp_bottom).offset(HEIGHT_DYNAMIC(5))
            make.left.equalTo(lineF.snp_right).offset(WIDTH_DYNAMIC(5))
            make.width.lessThanOrEqualTo(self.bounds.width/3*2-20)
            //            make.width.equalTo(self.bounds.width/2)
            //            make.height.equalTo(HEIGHT_DYNAMIC(15))
        }
        
        //grade推荐年级
        self.contentView.addSubview(grade)
        grade.numberOfLines=1
        grade.lineBreakMode=NSLineBreakMode.ByTruncatingTail
        grade.font=UIFont.systemFontOfSize(12)
        grade.textColor=COLOR_TEXT
        grade.snp_makeConstraints { (make) in
            make.top.equalTo(self.lineF.snp_bottom).offset(HEIGHT_DYNAMIC(5))
            make.left.equalTo(self).offset(WIDTH_DYNAMIC(20))
            make.width.lessThanOrEqualTo(self.bounds.width/3*2-20)
            //            make.width.equalTo(WIDTH_DYNAMIC(80))
            //            make.height.equalTo(HEIGHT_DYNAMIC(15))
        }
        
        //price价格
        self.contentView.addSubview(price)
        price.font=UIFont.boldSystemFontOfSize(HEIGHT_DYNAMIC(20))
        price.textColor=UIColor(red: 249/255, green: 202/255, blue: 48/255, alpha: 1)
        
        price.snp_makeConstraints { (make) in
            make.bottom.equalTo(self).offset(HEIGHT_DYNAMIC(-30))
            make.right.equalTo(self).offset(WIDTH_DYNAMIC(-50))
        }
//        //priceBack
//        self.contentView.addSubview(priceBack)
//        priceBack.font=UIFont.boldSystemFontOfSize(14)
//        priceBack.textColor=UIColor(red: 249/255, green: 202/255, blue: 48/255, alpha: 1)
//        
//        priceBack.snp_makeConstraints { (make) in
//            make.top.equalTo(price.snp_bottom).offset(HEIGHT_DYNAMIC(10))
//            make.right.equalTo(WIDTH_DYNAMIC(-50))
//            //            make.width.equalTo(WIDTH_DYNAMIC(20))
//            //            make.height.equalTo(HEIGHT_DYNAMIC(25))
//        }
        
        //priceUnit
        self.contentView.addSubview(priceUnit)
        priceUnit.text="元/趟"
        priceUnit.font=UIFont.systemFontOfSize(HEIGHT_DYNAMIC(14))
        priceUnit.snp_makeConstraints { (make) in
            make.bottom.equalTo(price.snp_bottom).offset(HEIGHT_DYNAMIC(-3))
            make.right.equalTo(self).offset(WIDTH_DYNAMIC(-15))
        }
//        //priceBackUnit
//        self.contentView.addSubview(priceBackUnit)
//        priceBackUnit.text="元/趟"
//        priceBackUnit.font=UIFont.systemFontOfSize(HEIGHT_DYNAMIC(14))
//        priceBackUnit.snp_makeConstraints { (make) in
//            make.top.equalTo(priceUnit.snp_bottom).offset(HEIGHT_DYNAMIC(10))
//            make.right.equalTo(WIDTH_DYNAMIC(-15))
//            //            make.width.equalTo(WIDTH_DYNAMIC(40))
//            //            make.height.equalTo(HEIGHT_DYNAMIC(25))
//        }
        
        //招募中标签
        self.contentView.addSubview(recruitLb)
        recruitLb.text="招募中"
        recruitLb.textColor=UIColor(red: 131/255, green: 201/255, blue: 87/255, alpha: 1)
        recruitLb.layer.borderColor=UIColor(red: 131/255, green: 201/255, blue: 87/255, alpha: 1).CGColor
        recruitLb.layer.borderWidth=1.5
        recruitLb.font=UIFont.systemFontOfSize(13)
        recruitLb.textAlignment=NSTextAlignment.Center
        recruitLb.hidden=true
        recruitLb.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(WIDTH_DYNAMIC(-15))
            make.size.equalTo(CGSizeMake(60, 30))
        }
        
        //满座标签
        self.contentView.addSubview(fullSeatLb)
        fullSeatLb.text="满座，我要报名"
        fullSeatLb.textColor=UIColor(red: 111/255, green: 192/255, blue: 226/255, alpha: 1)
        fullSeatLb.layer.borderColor=UIColor(red: 111/255, green: 192/255, blue: 226/255, alpha: 1).CGColor
        fullSeatLb.layer.borderWidth=1.5
        fullSeatLb.font=UIFont.systemFontOfSize(13)
        fullSeatLb.textAlignment=NSTextAlignment.Center
        fullSeatLb.hidden=true
        fullSeatLb.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(WIDTH_DYNAMIC(-15))
            make.size.equalTo(CGSizeMake(100, 30))
        }
        
        if(isRecruit != nil){
            if(isRecruit==String(1)){
                price.hidden=true
                priceUnit.hidden=true
//                priceBack.hidden=true
//                priceBackUnit.hidden=true
                recruitLb.hidden=false
                fullSeatLb.hidden=true
            }else if (String(seatNum as AnyObject)<=String(0)){
                price.hidden=true
                priceUnit.hidden=true
//                priceBack.hidden=true
//                priceBackUnit.hidden=true
                recruitLb.hidden=true
                fullSeatLb.hidden=false
            }else{
                price.hidden=false
                priceUnit.hidden=false
//                priceBack.hidden=false
//                priceBackUnit.hidden=false
                recruitLb.hidden=true
                fullSeatLb.hidden=true
            }
        }
        
    }
    
    func lineResultDataLoad2(lineName:String,lineNameBack:String,grade:String,stationName:String,price:String,priceBack:String){
        let newGrade=getGradeString(grade)
        
        let grade="推荐"+newGrade+"乘坐"
//        let stationName=" [途经:"+stationName+"]"
//        let grade="推荐"+getGradeString(grade)+"乘坐"
        let stationName=stationName
        
        let gradeLength=grade.characters.count
        let stationNameLength=stationName.characters.count
        
        let gradeStr=NSMutableAttributedString(string: grade+stationName)
        
        gradeStr.addAttributes([NSForegroundColorAttributeName : COLOR_TEXT], range: NSMakeRange(0, gradeLength))
        gradeStr.addAttributes([NSForegroundColorAttributeName:COLOR_TEXT_ORANGE,NSFontAttributeName:UIFont.boldSystemFontOfSize(12)], range: NSMakeRange(gradeLength, stationNameLength))
        
        self.grade.attributedText=gradeStr
        self.lineName.text=lineName
        self.price.text=price
        
        self.lineNameBack.text=lineNameBack
//        self.priceBack.text=priceBack
        
        
    }
    
    //站点转换
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
        if grade.characters.count>0{
            let index2 = grade.endIndex.advancedBy(-1)
            grade=grade.substringToIndex(index2)
        }
        
        return grade
    }
    
    
}
