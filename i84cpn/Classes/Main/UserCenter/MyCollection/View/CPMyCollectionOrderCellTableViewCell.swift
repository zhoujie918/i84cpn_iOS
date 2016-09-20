//
//  CPMyCollectionOrderCellTableViewCell.swift
//  i84cpn
//
//  Created by BenjaminRichard on 16/6/14.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit
protocol MyCollectionOrderCellDelegate {
    func collection(index: Int)
    func cancelCollection(index: Int)
}

class CPMyCollectionOrderCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        routeLabel.font = Constants.mediumFont
        routeLabel.numberOfLines = 0
        detailLabel.font = Constants.smallFont
        detailLabel.textColor = Constants.paleWordColor
        detailLabel.numberOfLines = 0
        cancelButton.setTitleColor(Constants.yellowWordColor, forState: .Normal)
        cancelButton.layer.borderColor = Constants.yellowWordColor.CGColor
        cancelButton.layer.borderWidth = 1
//        collectionButton.hidden = true
//        answerLabel.textColor = Constants.paleWordColor
//        answerLabel.font = Constants.smallFont
//        answerLabel.numberOfLines = 0
        sepline.backgroundColor = Constants.paleBGColor
//        collectionButton.addTarget(self, action: #selector(collectionAction), forControlEvents: .TouchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelAction), forControlEvents: .TouchUpInside)
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 设置取消按钮标题
    func setCancelButtonTitle(title: String) {
        cancelButton.setTitle(title, forState: .Normal)
    }
    
    // 召集伙伴
    func collectionAction(button: UIButton) {
        if collectionDelegate != nil {
            collectionDelegate?.collection(index)
        }
    }
    
    // 取消定制，退出征集
    func cancelAction(button: UIButton) {
        if collectionDelegate != nil {
            collectionDelegate?.cancelCollection(index)
        }
    }
    
    var collectionDelegate: MyCollectionOrderCellDelegate?
    var index = 0 
    @IBOutlet weak var routeLabel: UILabel!
//    @IBOutlet weak var collectionButton: UIButton!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
//    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var sepline: UIView!
}
