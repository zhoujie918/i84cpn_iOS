//
//  CPBabiIntroduceViewController.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/5/11.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPBabiIntroduceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(babiIntroduceView)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        babiIntroduceView.frame = view.frame
    }
    
    let babiIntroduceView: CPBabiIntroduceView = CPBabiIntroduceView()
}
