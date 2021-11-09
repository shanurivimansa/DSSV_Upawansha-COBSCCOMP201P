//
//  TermsVC.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-11-09.
//

import UIKit
import WebKit


class TermsVC: UIViewController,WKUIDelegate {
    
    
    
    var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    
}



