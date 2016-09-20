//
//  CPLineCollectionController.swift
//  i84cpn
//
//  Created by 爱巴士-余夏伟 on 16/6/13.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPLineCollectionController: UIViewController,UIWebViewDelegate {

    var url : String?
    
    private var webView = UIWebView()
    private var hud = MBProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "线路征集"
        
        view.addSubview(webView)
        webView.frame = view.frame
        webView.delegate = self
        
        let request = NSURLRequest(URL: NSURL(string: Constants.getLineCollectionURL())!)
        webView.loadRequest(request)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        hud.hide(true)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        hud.hide(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
