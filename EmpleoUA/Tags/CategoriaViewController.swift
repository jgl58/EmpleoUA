//
//  CategoriaViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 07/08/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit

class CategoriaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Categoria"
    }
  
    
    
    /*lazy var scrollView: CustomScrollView = {
        let sview = CustomScrollView(view: view, buttonHeight: 400.0)
        return sview
    }()

 
 
 OperationQueue.main.addOperation {
                        self.tableView.isHidden = true

                        self.view.addSubview(self.scrollView)
                        self.setupButtons()
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
     button.addTarget(self, action: #selector(pressedPracticas), for: .touchUpInside)
     
     self.view.addSubview(button)
     
     idColor += 1
     myY += myHeight + padding
     
     let buttonPortal = UIButton(frame: CGRect(x: myX, y: myY, width: myWidth, height:myHeight))
     buttonPortal.tag = 2
     buttonPortal.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.3019607843, blue: 0.4196078431, alpha: 1)
     buttonPortal.setTitle("Portal de empleo", for: [])
     buttonPortal.titleLabel?.font = UIFont(name: "Quicksand", size: 20.0)
     buttonPortal.addTarget(self, action: #selector(pressedPracticas), for: .touchUpInside)
     
     self.view.addSubview(buttonPortal)
         
 }*/

}
