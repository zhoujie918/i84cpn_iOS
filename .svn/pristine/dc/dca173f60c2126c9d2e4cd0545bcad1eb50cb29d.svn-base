//
//  CPFAQsDetailViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/19.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPFAQsDetailViewController: CMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "常见问题"
        
        loadViewContent()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(FAQsDetailView)
        
        FAQsDetailView.frame = view.frame
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        FAQsDetailView.imageView.image = nil
        self.view = nil
        super.viewDidDisappear(animated)
    }
    
    func loadViewContent() {
        switch index {
        case 0:
            let path = NSBundle.mainBundle().pathForResource("dlzh", ofType: "png")
            let image = UIImage(contentsOfFile: path!)
            FAQsDetailView.imageView.image = image
        case 1:
            let path = NSBundle.mainBundle().pathForResource("ydxl", ofType: "png")
            let image = UIImage(contentsOfFile: path!)
            FAQsDetailView.imageView.image = image
        case 2:
            let path = NSBundle.mainBundle().pathForResource("xlzj", ofType: "png")
            let image = UIImage(contentsOfFile: path!)
            FAQsDetailView.imageView.image = image
        case 3:
            let path = NSBundle.mainBundle().pathForResource("sxctx", ofType: "png")
            let image = UIImage(contentsOfFile: path!)
            FAQsDetailView.imageView.image = image
        default:
            break
        }
    }

    var index = 0
    private let FAQsDetailView = CPFAQsDetailView()
}
