//
//  CPSuggestionsCollectionViewCell.swift
//  i84cpn
//  意见反馈列表中的照片栏collectionviewcell
//  Created by BenjaminRichard on 16/6/8.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPSuggestionsCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        let press = UITapGestureRecognizer(target: self, action: #selector(handlerTap))
        press.numberOfTapsRequired = 1
        self.addGestureRecognizer(press)
        
        
        let press1 = UITapGestureRecognizer(target: self, action: #selector(removeImageView))
        press1.numberOfTapsRequired = 1
        viewImageView.addGestureRecognizer(press1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handlerTap(pressGesture: UIGestureRecognizer) {
        viewImageView.image = self.imageView.image
        self.window?.addSubview(viewImageView)
    }
    
    func removeImageView() {
        viewImageView.removeFromSuperview()
    }
    
    override func layoutSubviews() {
        imageView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    func loadImageWithName(imgName: String) {
        imageView.sd_setImageWithURL(Constants.getSDWebImageURLWithImageName(imgName))
        imageName = imgName
    }
    
    var imageName: String?
    let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 5
        return view
    } ()
    
    private let viewImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = Constants.blackBGColor
        view.frame = CGRectMake(0, 0, Constants.screenWidth, Constants.screenHeight)
        view.contentMode = UIViewContentMode.ScaleAspectFit
        view.userInteractionEnabled = true
        return view
    } ()
}
