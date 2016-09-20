//
//  CPComicController.swift
//  i84cpn
//
//  Created by 爱巴士-余夏伟 on 16/6/7.
//  Copyright © 2016年 5i84. All rights reserved.
//

import UIKit

class CPComicController: UIViewController,UIWebViewDelegate {

    private var webView = UIWebView()
    private var hud = MBProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(webView)
        webView.frame = self.view.frame
        webView.delegate = self
        let request = NSURLRequest.init(URL: NSURL.init(string: "http://q.eqxiu.com/s/AP3XyaiC#rd?toPage=489482731&toPage=489482900&toPage=489483049&toPage=489483240")!)
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
