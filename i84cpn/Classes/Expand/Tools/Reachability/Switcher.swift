//
//  Switcher.swift
//  Bus
//
//  Created by 周杰 on 16/4/27.
//  Copyright © 2016年 周杰. All rights reserved.
//

import UIKit

class Switcher: UIView {
    
    private var BackGroundView=UIView()
    private var OnButton=UIButton()
    private var OffButton=UIButton()
    private var ButtonWindow=UIView()
    
    private var OnLabel=UILabel()
    private var OffLabel=UILabel()
//    private var CenterCircleLabel=UILabel()
    private var isOff:Bool! = false
    var switcherTag:Int=0       //1是目的地，0是出发地
    var canDrawRect = false
    
//    private var StartAddressColor=UIColor(red: 229/255, green: 174/255, blue: 41/255, alpha: 1)
    private var StartAddressColor=UIColor(red: 250/255, green: 200/255, blue: 50/255, alpha: 1)
    private var EndAddressColor=UIColor(red: 110/255, green: 192/255, blue: 225/255, alpha: 1)
    
    override func drawRect(rect: CGRect) {
        //防止页面重绘
        if canDrawRect == false{
            return
        }
        canDrawRect = false
        self.layer.borderWidth=1
        self.layer.cornerRadius=self.frame.height/2
        self.layer.borderColor=UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1).CGColor
        BackGroundView = UIView()
        BackGroundView.frame = self.bounds
//        BackGroundView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        BackGroundView.backgroundColor=StartAddressColor
        BackGroundView.layer.cornerRadius = self.frame.height/2
        self.addSubview(BackGroundView)
        
        // Setup the Sliding Window
        
        ButtonWindow = UIView()
        ButtonWindow.frame = CGRectMake(0.0, 0.0, self.bounds.size.width / 2+20, self.bounds.size.height)
        ButtonWindow.backgroundColor=UIColor(red: 238/255, green: 237/255, blue: 236/255, alpha: 1.0)
        ButtonWindow.layer.cornerRadius = self.frame.height/2
        self.addSubview(ButtonWindow)
        
        // Setup the Buttons
        
        OnButton.frame = CGRectMake(0.0, 0.0, self.bounds.size.width / 2+20, self.bounds.size.height)
        OnButton.backgroundColor = UIColor.clearColor()
        
        OnButton.enabled = false
        OnButton.addTarget(self, action: #selector(Switcher.toggleSwitch(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(OnButton)
        
        OffButton = UIButton()
        OffButton.frame = CGRectMake(20, 0.0, self.bounds.size.width / 2+20, self.bounds.size.height)
//        OffButton.frame = CGRectMake(self.bounds.size.width / 2, 0.0, self.bounds.size.width / 2+20, self.bounds.size.height)

        OffButton.backgroundColor = UIColor.clearColor()
        OffButton.enabled = true
        OffButton.addTarget(self, action: #selector(Switcher.toggleSwitch(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(OffButton)
        
        // Setup the Labels
        
        OnLabel = UILabel()
        OnLabel.frame = CGRectMake(5.0, (self.bounds.size.height / 2) - 25.0, self.bounds.size.width / 2+10, 50.0)
        OnLabel.alpha = 1.0
//        OnLabel.text = "出发地"
        OnLabel.textAlignment = NSTextAlignment.Center
        OnLabel.textColor = UIColor.blackColor()
//        OnLabel.font = UIFont(name: "AvenirNext-Demibold", size: 15.0)
        OnLabel.font=UIFont.systemFontOfSize(14)
        OnButton.addSubview(OnLabel)
        
        OffLabel = UILabel()
        OffLabel.frame = CGRectMake(5.0, (self.bounds.size.height / 2) - 25.0, self.bounds.size.width / 2+10, 50.0)
        OffLabel.alpha = 1.0
//        OffLabel.text = ""
        OffLabel.textAlignment = NSTextAlignment.Center
        OffLabel.textColor = UIColor.whiteColor()
//        OffLabel.backgroundColor=UIColor.redColor()
//        OffLabel.font = UIFont(name: "AvenirNext-Demibold", size: 15.0)
        OffLabel.font=UIFont.systemFontOfSize(14)
        OffButton.addSubview(OffLabel)
        
        // Set up the center Label
        
//        CenterCircleLabel = UILabel()
//        CenterCircleLabel.frame = CGRectMake((self.bounds.size.width / 2) - 12.0, (self.bounds.size.height / 2) - 12.0, 24.0, 24.0)
//        CenterCircleLabel.text = "出发地"
//        CenterCircleLabel.textAlignment = NSTextAlignment.Center
//        CenterCircleLabel.textColor = UIColor(red:0.49, green:0.49, blue:0.49, alpha:1)
//        CenterCircleLabel.font = UIFont(name: "AvenirNext-Regular", size: 11.0)
//        CenterCircleLabel.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
//        CenterCircleLabel.layer.cornerRadius = 12.0
//        CenterCircleLabel.clipsToBounds = true
//        self.addSubview(CenterCircleLabel)
//        
//        isOff = false
        if switcherTag==0 {
            OnLabel.text = "出发地"
            OffLabel.text=""
        }
        else{
            OnLabel.text = ""
            OffLabel.text="目的地"
        }
    }
    
    func toggleSwitch(sender: UIButton) {
        onOrOff(!isOff)
        if (isOff==true){
            switcherTag=1
        }else{
            switcherTag=0
        }
    }
    
    func onOrOff(on : Bool){
        
        if(on == isOff){
            return
        }
        isOff = on
        
        UIView.animateWithDuration(0.4,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.8,
                                   initialSpringVelocity: 14.0,
                                   options: UIViewAnimationOptions.CurveEaseOut,
                                   animations: { () -> Void in
//                                    self.ButtonWindow.frame.origin.x += self.frame.size.width / 2 * (on ? 1 : -1)
                                    self.ButtonWindow.frame.origin.x += self.frame.size.width / 2 * (on ? 0.5 : -0.5)
            },
                                   completion: nil)
        
        animateLabel(self.OffLabel, toColor: (on ? UIColor.blackColor() : UIColor.whiteColor()))
        animateLabel(self.OnLabel, toColor: (on ? UIColor.whiteColor() : UIColor.blackColor()))
        
        self.OnButton.enabled = !self.OnButton.enabled
        self.OffButton.enabled = !self.OffButton.enabled
        if(isOff==false){
//            OnLabel.hidden=false
//            OffLabel.hidden=true
            OnLabel.text="出发地"
            OffLabel.text=""
            BackGroundView.backgroundColor=StartAddressColor
        }else{
//            OnLabel.hidden=true
//            OffLabel.hidden=false
            OnLabel.text=""
            OffLabel.text="目的地"
            BackGroundView.backgroundColor=EndAddressColor
        }
    }
    
    private func animateLabel(label : UILabel!, toColor : UIColor){
        UIView.transitionWithView(label,
                                  duration: 0.4,
                                  options: [UIViewAnimationOptions.CurveEaseOut,
//                                    UIViewAnimationOptions.TransitionCrossDissolve,
                                    UIViewAnimationOptions.BeginFromCurrentState],
                                  animations: { () -> Void in
                                    label.textColor = toColor
            },
                                  completion: nil)
    }


}
