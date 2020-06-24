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

    @IBOutlet weak var webView: WKWebView!
    var url : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://appempleo.ua.es/actividad/ver/\(self.url!)")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
