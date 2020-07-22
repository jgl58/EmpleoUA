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
    

//    @IBOutlet weak var webView: WKWebView!
    var webView: WKWebView?
    var url : String?
    let userContentController = WKUserContentController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = WKWebViewConfiguration()
        config.userContentController = userContentController
        userContentController.add(self, name: "userLogin")
        
        self.webView = WKWebView(frame: .zero, configuration: config)
 
        self.view = self.webView

//        let url = URL(string: self.url!)!
//        let url = URL(string: "https://autentica.cpd.ua.es/cas/login?service=https%3A%2F%2Fappempleo.ua.es%2Fcas%2Fauth.php")
        let url = URL(string: "https://jonaygilabert.ddns.net")
        webView!.load(URLRequest(url: url!))
        webView!.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
    
    

}

extension WebViewController: WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let dict = message.body as! [String:AnyObject]
        let username    = dict["username"] as! String
        let secretToken = dict["secretToken"] as! String

        print(username)
        print(secretToken)
        print("HOLA")

    }
}
