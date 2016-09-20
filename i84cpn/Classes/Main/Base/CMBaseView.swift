//
//  CMBaseView.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/7/5.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CMBaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Constants.dPrint("view deinit -- \(self)")
    }

}
