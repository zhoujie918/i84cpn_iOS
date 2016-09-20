//
//  CPTabBarController.swift
//  i84cpn
//
//  Created by 周杰 on 16/5/24.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

private let shareTabbar = CPTabBarController()

class CPTabBarController: UITabBarController {
    
    var homePageCrl=CPHomePageController()      //主页
    var lifeCircleCrl=CPLifeCirCleController()  //生活圈
    var mySet=CPUserCenterHomePageViewController()

    class var shareInstance: CPTabBarController {
        return shareTabbar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tabbar控制器添加三个子导航栏控制器
        self.addChildViewController(setChildVC(homePageCrl, title:"搜线路",image: "label_01_unsel", selectedImage: "label_01_sel"))
        
        self.addChildViewController(setChildVC(lifeCircleCrl, title:"生活圈",image: "label_02_unsel", selectedImage: "label_02_sel"))
        
        self.addChildViewController(setChildVC(mySet,title:"我的",image: "label_03_unsel", selectedImage: "label_03_sel"))
        self.tabBar.translucent=false
        self.selectedViewController = self.childViewControllers[0]
    }
    
    //创建tabbar子控制器的方法
    func setChildVC(childVC:UIViewController,title:String,image:String,selectedImage:String) -> UINavigationController {
        childVC.title=title
        childVC.tabBarItem.image=UIImage(named: image)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        childVC.tabBarItem.selectedImage=UIImage(named: selectedImage)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        //        childVC.tabBarItem.imageInsets=UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        childVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], forState: UIControlState.Selected)
        
        let nav=UINavigationController(rootViewController: childVC)
        return nav
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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

