//
//  MainViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 16/04/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit
import TinyConstraints

class MainViewController: UIViewController {

    lazy var scrollView: CustomScrollView = {
        let sview = CustomScrollView(view: view,buttonHeight: 200.0)
       return sview
   }()
 
    var categories: [Tag]!
    var colorOrder = [#colorLiteral(red: 0.0431372549, green: 0.3019607843, blue: 0.4196078431, alpha: 1),#colorLiteral(red: 0.1529411765, green: 0.462745098, blue: 0.462745098, alpha: 1),#colorLiteral(red: 0.5882352941, green: 0.2980392157, blue: 0.1411764706, alpha: 1),#colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1),#colorLiteral(red: 0.6549019608, green: 0.2784313725, blue: 0.3803921569, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(scrollView)
      //  scrollView.addSubview(containerView)

         APIRequest.getTags(url: "/apiCategorias/tags"){ data in

            if let tags = data {
                self.categories = tags
                OperationQueue.main.addOperation {
                    self.setupTags()
                }

            }

        }
        
    }
    func setupTags(){
              
          var idColor = 0
      //        Creamos una variable VIEW para añadir dentro nuestro stack
              let view = UIView()
              var buttonsStack : [UIButton] = []
              for tag in categories {
                  
                  if tag.name != "Zona empresas" && tag.name != "Centro de Empleo"{
                      let button = UIButton()
                      button.tag = tag.id
                      button.backgroundColor = self.colorOrder[idColor]
                      button.setTitle(tag.name, for: [])
                      button.titleLabel?.font = UIFont(name: "Quicksand", size: 30.0)
                      button.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
                    button.height(self.scrollView.buttonHeight!)
                      
                      view.addSubview(button)
                      buttonsStack.append(button)
      //                hacemos que el boton se ancle a los lados de la view excepto bottom
                      button.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
                      
                      idColor += 1
                  }
              }
          
            self.scrollView.updateScrollViewSize(buttonsStack)
          
          }
          
          @objc func pressed(_ sender: UIButton!) {
              let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
              let newViewController = storyBoard.instantiateViewController(withIdentifier: "TagDetalle") as! TagDetallesViewController
              
              for tag in self.categories {
                  if sender.tag == tag.id {
                      newViewController.title = tag.name
                      newViewController.tagID = tag.id
                    navigationController!.pushViewController(newViewController, animated: true)
                  }
              }

          }
    
}
