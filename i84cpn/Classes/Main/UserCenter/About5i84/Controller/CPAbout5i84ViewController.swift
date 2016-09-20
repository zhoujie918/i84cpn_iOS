//
//  CPAbout5i84ViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/19.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPAbout5i84ViewController: CMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "关于我们"
        view.addSubview(about5i84View)
        about5i84View.frame = view.frame
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private let about5i84View = CPAbout5i84View()
}
