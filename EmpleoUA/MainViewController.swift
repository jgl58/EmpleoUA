//
//  MainViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 16/04/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

 
    @IBOutlet weak var scrollView: UIScrollView!
    
    var colorOrder = [#colorLiteral(red: 0.0431372549, green: 0.3019607843, blue: 0.4196078431, alpha: 1),#colorLiteral(red: 0.1529411765, green: 0.462745098, blue: 0.462745098, alpha: 1),#colorLiteral(red: 0.5882352941, green: 0.2980392157, blue: 0.1411764706, alpha: 1),#colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1),#colorLiteral(red: 0.6549019608, green: 0.2784313725, blue: 0.3803921569, alpha: 1)]
    var categories = [Tag]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIRequest.getTags(url: "/apiCategorias/tags"){ data in
            
            if let tags = data {
               self.categories = tags
                OperationQueue.main.addOperation {
                    
                    self.setupScrollView()
                    self.setupButtons()
                }
                
            }
            
        }
        
        
    }

    func setupScrollView(){
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true

        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
        
    }
    func setupButtons(){
        let frame = self.view.frame
        
        let myX = frame.width/4
        var myY : CGFloat = 0.0
        
        let myHeight = frame.height/5
        let myWidth = frame.width/2
        let padding : CGFloat = 10.0
        
        var idColor = 0
        for tag in self.categories {
            
            if tag.name != "Zona empresas" && tag.name != "Centro de Empleo"{
                let button = UIButton(frame: CGRect(x: myX, y: myY, width: myWidth, height:myHeight))
                button.tag = tag.id
                button.backgroundColor = self.colorOrder[idColor]
                button.setTitle(tag.name, for: [])
                button.titleLabel?.font = UIFont(name: "Quicksand", size: 20.0)
                button.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
                
                self.scrollView.addSubview(button)
                
                idColor += 1
                myY += myHeight + padding
            }
        }

    }
    
    @objc func pressed(_ sender: UIButton!) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TagDetalle") as! TagDetallesViewController
        
        for tag in self.categories {
            if sender.tag == tag.id {
                newViewController.title = tag.name
                newViewController.tagID = tag.id
                self.navigationController!.pushViewController(newViewController, animated: true)
            }
        }

    }
}
