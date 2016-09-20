//
//  CPMoeBusController.swift
//  i84cpn
//
//  Created by 爱巴士-余夏伟 on 16/6/13.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPMoeBusController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "萌巴士"
        view.backgroundColor = Constants.paleBGColor
        automaticallyAdjustsScrollViewInsets = false
        
        //创建顶部tabView
        var style = SegmentStyle()
        style.showLine = true
        style.gradualChangeTitleColor = true
        style.titleMargin = 25
        style.selectedTitleColor = Constants.mainColor
        style.scrollLineColor = Constants.mainColor
        
        
        //请求数据(季)
        let hud = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
        weak var weakSelf = self
        CPMoeBusModel.getComicListData({ (success) in
            hud.hide(true)
            var childs = [UIViewController]()
            for i in 0..<(success?.list?.count)!{
                let vc = CPMoeBusContentController()
                if i == 0{
                    vc.isFirstPage = true
                }
                vc.cciId = (success?.list![i].cciId)!
                childs.append(vc)
            }
            //创建contentView
            let scroll = ScrollPageView(frame: CGRect(x: 0, y: 64, width: weakSelf!.view.bounds.size.width, height: weakSelf!.view.bounds.size.height - 64), segmentStyle: style, titles: success!.nameList, childVcs: childs, parentViewController: weakSelf!)
            weakSelf!.view.addSubview(scroll)
            
            }) { (fail) in
                hud.hide(true)
                let alert = UIAlertView.init(title: "提示", message: fail, delegate: nil, cancelButtonTitle: "确定")
                alert.show()
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
