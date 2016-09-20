//
//  CPWelComePageView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/7.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPWelComePageView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(scrollView)
//        self.insertSubview(pageControlView, atIndex: 9999)
        scrollView.addSubview(imageOne)
        scrollView.addSubview(imageTwo)
        scrollView.addSubview(imageThree)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func layoutSubviews() {
        
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(superview!).inset(UIEdgeInsetsMake(0, 0, 0, 0))
//            make.left.bottom.right.top.equalTo(0)
        }
        imageOne.frame = self.bounds
        imageTwo.frame = self.frame
        imageThree.frame = self.frame
        imageTwo.frame.origin.x = self.frame.width
        imageThree.frame.origin.x = self.frame.width * 2
        
        scrollView.contentSize = CGSizeMake(self.frame.width * 3, scrollView.frame.height)
    }

    
    let scrollView: UIScrollView = {
        let view: UIScrollView = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.scrollEnabled = true
        view.pagingEnabled = true
        return view
    } ()
    
    
//    var pageControlView: TAPageControl = {
//        let view: TAPageControl = TAPageControl(frame: CGRectMake(0, Constants.screenHeight - 100, Constants.screenWidth, 40))
//        view.spacingBetweenDots = 30
//        view.dotImage = UIImage(named: "wcp_unsel")
//        view.currentDotImage = UIImage(named: "wcp_sel")
//        view.numberOfPages = 3
//        return view
//    } ()
    
    let imageOne: UIImageView = {
        let imageView: UIImageView = UIImageView()
        let path = NSBundle.mainBundle().pathForResource("wcp_01", ofType: "png")
        let image: UIImage = UIImage(contentsOfFile: path!)!
        imageView.image = image
        return imageView
    } ()
    
    let imageTwo: UIImageView = {
        let imageView: UIImageView = UIImageView()
        let path = NSBundle.mainBundle().pathForResource("wcp_02", ofType: "png")
        let image: UIImage = UIImage(contentsOfFile: path!)!
        imageView.image = image
        return imageView
    } ()
    
    let imageThree: UIImageView = {
        let imageView: UIImageView = UIImageView()
        let path = NSBundle.mainBundle().pathForResource("wcp_03", ofType: "png")
        let image: UIImage = UIImage(contentsOfFile: path!)!
        imageView.image = image
        return imageView
    } ()
}
