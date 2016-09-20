//
//  CPLifeTableViewCell.swift
//  i84cpn
//
//  Created by 杰伦 on 16/5/6.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit


class CPLifeTableViewCell: UITableViewCell {
    
    var cellImageView=UIImageView()     //cell图片
    var cellTitle=UILabel()         //cell标题
    var cellDescription=UILabel()   //cell描述

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.addSubview(cellImageView)
        cellImageView.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self).offset(15)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        self.addSubview(cellTitle)
        cellTitle.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(30)
            make.left.equalTo(self).offset(90)
            make.width.equalTo(self.frame.size.width)
            make.height.equalTo(20)
            
        }
        cellTitle.font=UIFont.systemFontOfSize(HEIGHT_DYNAMIC(14))
        
        
        self.addSubview(cellDescription)
        cellDescription.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(50)
            make.left.equalTo(self).offset(90)
            make.width.equalTo(self.frame.width)
            make.height.equalTo(20)
        }
        cellDescription.font=UIFont.systemFontOfSize(HEIGHT_DYNAMIC(12))
        cellDescription.textColor=UIColor.lightGrayColor()
    }
    
    func dataLoad(image:String,title:String,description:String){
        self.cellImageView.image=UIImage(named: image)
        self.cellTitle.text=title
        self.cellDescription.text=description
    }

}
