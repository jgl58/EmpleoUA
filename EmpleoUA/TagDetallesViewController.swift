//
//  TagDetallesViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 23/04/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit
import WebKit

class TagDetallesViewController: UIViewController {
    
    var tagID : Int?
    private let webView = WKWebView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIRequest.getTag(url: "/apiCategorias/tags/"+String(tagID!)){ data in
            if let act = data {
                if act.name == "Prácticas y empleo"{
                    OperationQueue.main.addOperation {
                        self.setupButtons()
                    }
                }else{
                    APIRequest.getActividad(class: Actividad.self, url: "/apiActividades/obtener/?sort="+String(self.tagID!)+"&order=asc"){ data in
                        if let act = data {
                            print(act)
                        }
                        
                    }
                }
            }
            
        }

        // Do any additional setup after loading the view.
    }
    
    
    func setWebView(url: URL){
        
        webView.translatesAutoresizingMaskIntoConstraints = false
           self.view.addSubview(self.webView)
        // You can set constant space for Left, Right, Top and Bottom Anchors
                            NSLayoutConstraint.activate([
                                self.webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                                self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                                self.webView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                                self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                ])
            // For constant height use the below constraint and set your height constant and remove either top or bottom constraint
            //self.webView.heightAnchor.constraint(equalToConstant: 200.0),

            self.view.setNeedsLayout()
            let request = URLRequest(url: url)
            self.webView.load(request)
    }
    
    func setupButtons(){
        let frame = self.view.frame
        
        let myX = frame.width/4
        var myY = frame.height/3
        
        let myHeight = frame.height/5
        let myWidth = frame.width/2
        let padding : CGFloat = 10.0
        
        var idColor = 0
        
        let button = UIButton(frame: CGRect(x: myX, y: myY, width: myWidth, height:myHeight))
        button.tag = 1
        button.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.3019607843, blue: 0.4196078431, alpha: 1)
        button.setTitle("Prácticas", for: [])
        button.titleLabel?.font = UIFont(name: "Quicksand", size: 20.0)
        button.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        idColor += 1
        myY += myHeight + padding
        
        let buttonPortal = UIButton(frame: CGRect(x: myX, y: myY, width: myWidth, height:myHeight))
        buttonPortal.tag = 2
        buttonPortal.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.3019607843, blue: 0.4196078431, alpha: 1)
        buttonPortal.setTitle("Portal de empleo", for: [])
        buttonPortal.titleLabel?.font = UIFont(name: "Quicksand", size: 20.0)
        buttonPortal.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
        
        self.view.addSubview(buttonPortal)
            
    }
    
    @objc func pressed(_ sender: UIButton!) {
        
        if sender.tag == 1 {
            print("Hola")
            let url = URL(string: "https://web.ua.es/es/centro-empleo/practicas-y-empleo/practicas-en-la-ua/")!
            setWebView(url: url)
        }else if sender.tag == 2 {
            let url = URL(string: "https://web.ua.es/es/centro-empleo/practicas-y-empleo/ofertas-de-empleo-para-titulados-de-la-ua/")!
            setWebView(url: url)
        }
        
    }

}
