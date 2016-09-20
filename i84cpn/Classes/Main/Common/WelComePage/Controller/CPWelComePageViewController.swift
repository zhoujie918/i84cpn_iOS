//
//  CPWelComePageViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/7.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPWelComePageViewController: UIViewController, UIScrollViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(welcomePageView)
        view.backgroundColor = Constants.whiteBGColor
        welcomePageView.scrollView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        welcomePageView.frame = view.frame
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        welcomePageView.imageOne.image = nil
        welcomePageView.imageTwo.image = nil
        welcomePageView.imageThree.image = nil
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: --代理方法
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        welcomePageView.pageControlView.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        
        let num:CGFloat = CGFloat(Constants.welcomePageNumber) - 1
        if scrollView.contentOffset.x > Constants.screenWidth * num + 50 {
            let userLoginVC = CPTabBarController.shareInstance
            self.navigationController?.pushViewController(userLoginVC, animated: true)
        }
    }
    
    
    let welcomePageView: CPWelComePageView = CPWelComePageView()
}