//
//  ViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 26/03/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController{

    @IBOutlet var webView: WKWebView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var categories = [Tag]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APIRequest.getTags(url: "/apiCategorias/tags"){ data in
            
            if let tags = data {
               self.categories = tags
                OperationQueue.main.addOperation {
                    self.buttonCreation()
                }
                
            }
            
        }
        
        
       /* let url = URL(string: "https://cvnet.cpd.ua.es/uacloud/home/indexVerificado")!
        webView.load(URLRequest(url: url))
          
        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    */}
    @IBAction func apiCall(_ sender: UIButton) {
        
    }
    
    
    func buttonCreation() {

       scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let numberofRows = self.categories.count
        let px = 0
        var py = 0

        for i in 1...numberofRows {
           
            let Button = UIButton()
            Button.tag = self.categories[i-1].id
            Button.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            Button.frame = CGRect(x: px, y: py, width: Int(scrollView.visibleSize.width / 2), height: Int(scrollView.visibleSize.width / 4))
            Button.layer.borderWidth = 1.0
            Button.layer.masksToBounds = true
            Button.setTitleColor(UIColor.black, for: .normal)
            Button.setTitle(self.categories[i-1].name, for: .normal)
            Button.center.x = self.view.center.x
            
            scrollView.addSubview(Button)
          
            py = py + 150
        }

        scrollView.contentSize = CGSize(width: px, height: py)

    }
    
    
}
    

