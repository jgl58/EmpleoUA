//
//  WebViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 23/06/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView?
    var url : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.webView = WKWebView(frame: .zero)
        self.view = self.webView

        let url = URL(string: self.url!)!
        webView!.load(URLRequest(url: url))
        webView!.allowsBackForwardNavigationGestures = true
    }
    
    

}

