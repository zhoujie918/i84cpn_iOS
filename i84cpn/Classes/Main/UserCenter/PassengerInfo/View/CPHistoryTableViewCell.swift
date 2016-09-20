//
//  CPHistoryTableViewCell.swift
//  i84cpn
//
//  Created by Benjamin on 16/5/27.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit
extension String {
    func rangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
        let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
        if let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) {
            return from ..< to
        }
        return nil
    }
}

extension String {
    func NSRangeFromRange(range : Range<String.Index>) -> NSRange {
        let utf16view = self.utf16
        let from = String.UTF16View.Index(range.startIndex, within: utf16view)
        let to = String.UTF16View.Index(range.endIndex, within: utf16view)
        return NSMakeRange(utf16view.startIndex.distanceTo(from), from.distanceTo(to))
    }
}
class CPHistoryTableViewCell: UITableViewCell {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(dateLabel)
//        self.addSubview(phoneNumLabel)
//        self.addSubview(nameLabel)
        self.addSubview(detailLabel)
        self.addSubview(stateLabel)
    }
    
    
    func dealMessage(phoneNum: String, name: String, detail: String) -> NSMutableAttributedString {
        let range1 = detail.NSRangeFromRange(detail.rangeOfString(phoneNum)!)
        let range2 = detail.NSRangeFromRange(detail.rangeOfString(name)!)
        let text = NSMutableAttributedString(string: detail)
        
        text.addAttributes([NSForegroundColorAttributeName: Constants.paleWordColor], range: NSMakeRange(0, text.length))
        text.addAttributes([NSForegroundColorAttributeName: Constants.blackWordColor], range: range1)
        text.addAttributes([NSForegroundColorAttributeName: Constants.blackWordColor], range: range2)
        return text
    }
    
    func setCell(date: String, phoneNum: String, name:  String, detail: String, state: Int) {
        dateLabel.text = date
        
        detailLabel.attributedText = dealMessage(phoneNum, name: name, detail: detail)
        switch state {
        case 1:
            stateLabel.text = "等待对方回复"
            stateLabel.textColor = Constants.yellowWordColor
        case 2:
            stateLabel.text = "已被拒绝"
            stateLabel.textColor = Constants.redWordColor
        case 3:
            stateLabel.text = "已同意"
            stateLabel.textColor = Constants.greenWordColor
        default:
            break
        }
    }
    
    override func layoutSubviews() {
        
        dateLabel.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(20)
        }
        
//        phoneNumLabel.snp_makeConstraints { (make) in
//            make.left.equalTo(dateLabel)
//            make.top.equalTo(dateLabel.snp_bottom).offset(8)
//        }
//        
//        nameLabel.snp_makeConstraints { (make) in
//            make.left.equalTo(dateLabel)
//            make.top.equalTo(phoneNumLabel.snp_bottom).offset(8)
//        }
        
        detailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp_bottom)
            make.width.equalTo(160)
        }
        
        stateLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-20)
        }
    }
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        return view
    } ()
    
//    let phoneNumLabel: UILabel = {
//        let view = UILabel()
//        view.font = Constants.smallFont
//        return view
//    } ()
//    
//    let nameLabel: UILabel = {
//        let view = UILabel()
//        view.font = Constants.smallFont
//        view.textColor = Constants.paleWordColor
//        return view
//    } ()
    
    let detailLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.font = Constants.smallFont
        view.textColor = Constants.paleWordColor
        return view
    } ()
    
    let stateLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.smallFont
        return view
    } ()
}
