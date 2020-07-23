//
//  LoginController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 23/07/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit
import WebKit

class LoginController: UIViewController, WKScriptMessageHandler {

        var webView: WKWebView?
        let userContentController = WKUserContentController()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let config = WKWebViewConfiguration()
            config.userContentController = userContentController
            
            userContentController.add(self, name: "userLogin")
            
            self.webView = WKWebView(frame: .zero, configuration: config)
            self.view = self.webView

    //        let url = URL(string: "https://autentica.cpd.ua.es/cas/login?service=https%3A%2F%2Fappempleo.ua.es%2Fcas%2Fauth.php")
            let url = URL(string: "https://jonaygilabert.ddns.net/login")
            webView!.load(URLRequest(url: url!))
            webView!.allowsBackForwardNavigationGestures = true
            // Do any additional setup after loading the view.
        }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            let dict = message.body as! [String:AnyObject]
            let message    = dict["message"] as! String
            print(message)
            if let secretToken = dict["secretToken"] as? String {
                print(secretToken)
                saveToken(token: secretToken)
                _ = navigationController?.popViewController(animated: true)

            }
        }
        
        
        func saveToken(token: String){
            let defaults = UserDefaults.standard
            defaults.set(token, forKey: "Token")
    //            let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]() Leer token de UserDefaults

        }
        
        

}
