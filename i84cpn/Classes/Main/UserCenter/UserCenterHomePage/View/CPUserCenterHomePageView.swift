//
//  CPUserCenterHomePageView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/9.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPUserCenterHomePageView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        headContainView.addSubview(headViewBGButton)
        headContainView.addSubview(headView)
        headContainView.addSubview(userNameLabel)
        headContainView.addSubview(cerView)
        headContainView.addSubview(personInfomationButton)
        tableView.tableHeaderView = headContainView
        
        tableView.tableFooterView = footerContainView
        footerContainView.addSubview(quitButton)
        
        self.addSubview(tableView)
        self.backgroundColor = Constants.whiteBGColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        if CPUserModel.imageName != nil {

            headView.sd_setImageWithURL(Constants.getSDWebImageURLWithImageName(CPUserModel.imageName!), placeholderImage: UIImage(named: "img_default"))
        } else {
            headView.image = UIImage(named: "img_default")
        }
        
        if CPUserModel.petName != nil {
            userNameLabel.text = CPUserModel.petName
        } else {
            userNameLabel.text = "给自己起一个响亮的名号吧！"
        }
        
        if CPUserModel.idNo != nil {
            cerView.image = UIImage(named: "img_adopt")
        } else {
            cerView.image = UIImage(named: "img_not")
        }
        
        if CPUserModel.getLoginState() {
            quitButton.hidden = false
        } else {
            quitButton.hidden = true
        }
//        tableView.reloadData()
    }


    override func layoutSubviews() {
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        headContainView.frame = CGRectMake(0, 0, Constants.screenWidth, 110)

        headViewBGButton.snp_makeConstraints { (make) in
            make.left.right.equalTo(headContainView)
            make.top.equalTo(headContainView.snp_top)
            make.bottom.equalTo(headView.snp_bottom).offset(15)
        }
        
        headView.snp_makeConstraints { (make) in
            make.left.equalTo(headViewBGButton.snp_left).offset(15)
            make.top.equalTo(headViewBGButton.snp_top).offset(15)
            make.width.height.equalTo(80)
        }
        
        userNameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(headView.snp_right).offset(20)
            make.top.equalTo(headViewBGButton.snp_top).offset(45)
        }
        
        cerView.snp_makeConstraints { (make) in
            make.left.equalTo(userNameLabel)
            make.top.equalTo(userNameLabel.snp_bottom).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(70)
        }
        
        personInfomationButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(headViewBGButton)
            make.right.equalTo(0)
            make.width.height.equalTo(30)
        }
        
        footerContainView.frame = CGRectMake(0, 605, Constants.screenWidth, 100)
//        footerContainView.snp_makeConstraints { (make) in
//            make.top.equalTo(tableView.snp_bottom).offset(20)
//            make.left.equalTo(0)
//            make.right.equalTo(self)
//            make.height.equalTo(100)
//        }
        quitButton.snp_makeConstraints { (make) in
            make.left.equalTo(footerContainView).offset(30)
            make.top.equalTo(footerContainView).offset(30)
            make.bottom.equalTo(footerContainView).offset(-30)
            make.width.equalTo(Constants.screenWidth - 60)
        }
        tableView.tableHeaderView = headContainView
    }
    
    // 头部
    let headContainView: UIView = UIView()
    
    let headViewBGButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "img_bg"), forState: .Normal)
        return view
    } ()
    
    let headView:UIImageView = {
        let view: UIImageView = UIImageView(image: UIImage(named: "img_default"))
        view.layer.cornerRadius = 80 * 0.5;
        view.layer.masksToBounds = true;
        return view
    } ()
    
    let userNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "给自己起一个响亮的名号吧！"
        label.font = Constants.smallFont
        label.textColor = Constants.paleWordColor
        return label
    } ()
    
    let cerView: UIImageView = {
        let view: UIImageView = UIImageView(image: UIImage(named: "img_not"))
        return view
    } ()
    
    let personInfomationButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setImage(UIImage(named: "icon_in01"), forState: .Normal)
        btn.setImage(UIImage(named: "icon_in02"), forState: .Highlighted)
        return btn
    } ()
    
    // 表
    let tableView: UITableView = {
        let view: UITableView = UITableView(frame: CGRectMake(0, 0, 0, 0), style: .Grouped)
        view.contentInset = UIEdgeInsetsMake(0, 0, 200, 0)
        view.backgroundColor = Constants.paleBGColor
        view.separatorStyle = UITableViewCellSeparatorStyle.None
        view.rowHeight = 44
        view.showsVerticalScrollIndicator = false
        
        return view
    } ()

    // 尾部
    let footerContainView: UIView = {
        let view: UIView = UIView()
        return view
    } ()
    
    let quitButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setTitle("退出登录", forState: .Normal)
        btn.tintColor = Constants.whiteWordColor
        btn.layer.cornerRadius = 16
        btn.hidden = true
        btn.setBackgroundImage(UIImage(named: "btn_login_nor"), forState: .Normal)
        return btn
    } ()
}
