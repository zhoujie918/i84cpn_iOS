//
//  CPLineResultTableViewCell.swift
//  i84cpn
//
//  Created by 周杰 on 16/5/15.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPLineResultTableViewCell: UITableViewCell {
    
    var lineName=UILabel()          //线路名称
    var grade=UILabel()             //推荐年级
    var stationName=UILabel()       //途径站点
    var price=UILabel()             //价格
    var priceUnit=UILabel()         //价格单位
    var cellGest=UITapGestureRecognizer()
    
    var lineW=UILabel()
    var lineF=UILabel()
    var lineNameBack=UILabel()
    var priceBack=UILabel()
    
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
        
        self.contentView.addSubview(lineName)
        lineName.numberOfLines=1
        lineName.font=UIFont.systemFontOfSize(14)
        lineName.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(HEIGHT_DYNAMIC(20))
            make.left.equalTo(self).offset(WIDTH_DYNAMIC(20))
            make.width.lessThanOrEqualTo(self.bounds.width/3*2-20)
        }
        
        //grade推荐年级
        self.contentView.addSubview(grade)
        grade.numberOfLines=2
        grade.font=UIFont.systemFontOfSize(12)
        grade.textColor=COLOR_TEXT
        grade.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(HEIGHT_DYNAMIC(40))
            make.left.equalTo(self).offset(WIDTH_DYNAMIC(20))
            make.width.lessThanOrEqualTo(self.bounds.width/3*2-20)
        }

        //priceValue
        self.contentView.addSubview(price)
        price.font=UIFont.boldSystemFontOfSize(HEIGHT_DYNAMIC(20))
        price.textColor=UIColor(red: 249/255, green: 202/255, blue: 48/255, alpha: 1)
        
        price.snp_makeConstraints { (make) in
            make.bottom.equalTo(self).offset(HEIGHT_DYNAMIC(-30))
            make.right.equalTo(self).offset(WIDTH_DYNAMIC(-50))
        }
        
        //priceUnit
        self.contentView.addSubview(priceUnit)
        priceUnit.text="元/趟"
        priceUnit.font=UIFont.systemFontOfSize(HEIGHT_DYNAMIC(14))
        priceUnit.snp_makeConstraints { (make) in
            make.bottom.equalTo(price.snp_bottom).offset(HEIGHT_DYNAMIC(-3))
            make.right.equalTo(self).offset(WIDTH_DYNAMIC(-15))
        }
        
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
//            make.bottom.equalTo(self).offset(HEIGHT_DYNAMIC(-30))
            make.right.equalTo(self).offset(WIDTH_DYNAMIC(-15))
            make.size.equalTo(CGSizeMake(100, 30))
        }
        if(isRecruit != nil){
            if(isRecruit != String(0)){
                price.hidden=true
                priceUnit.hidden=true
                recruitLb.hidden=false
                fullSeatLb.hidden=true
            }else if (String(seatNum as AnyObject)<=String(0)){
                price.hidden=true
                priceUnit.hidden=true
                recruitLb.hidden=true
                fullSeatLb.hidden=false
            }else{
                price.hidden=false
                priceUnit.hidden=false
                recruitLb.hidden=true
                fullSeatLb.hidden=true
            }
        }
        
    }
    
    func lineResultDataLoad(lineName:String,grade:String,stationName:String,price:String){
        let newGrade=getGradeString(grade)
        
        let grade="推荐"+newGrade+"乘坐"
//        let grade="推荐"+grade+"乘坐"

        let stationName=stationName
        
        let gradeLength=grade.characters.count
        let stationNameLength=stationName.characters.count
        
        let gradeStr=NSMutableAttributedString(string: grade+stationName)
        
        gradeStr.addAttributes([NSForegroundColorAttributeName : COLOR_TEXT], range: NSMakeRange(0, gradeLength))
        gradeStr.addAttributes([NSForegroundColorAttributeName:COLOR_TEXT_ORANGE,NSFontAttributeName:UIFont.boldSystemFontOfSize(12)], range: NSMakeRange(gradeLength, stationNameLength))
        
        self.grade.attributedText=gradeStr        
        self.lineName.text=lineName
        self.price.text=price
        
    }
    
    

}
