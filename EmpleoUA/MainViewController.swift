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

    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
    
//    @IBOutlet weak var scrollView: UIScrollView!
    
    lazy var scrollView: UIScrollView = {
        let sview = UIScrollView(frame: .zero)
        sview.backgroundColor = .gray
        sview.frame = view.bounds
        sview.contentSize = contentViewSize
        return sview
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        return view
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Hola"
        return label
    }()
    
    var colorOrder = [#colorLiteral(red: 0.0431372549, green: 0.3019607843, blue: 0.4196078431, alpha: 1),#colorLiteral(red: 0.1529411765, green: 0.462745098, blue: 0.462745098, alpha: 1),#colorLiteral(red: 0.5882352941, green: 0.2980392157, blue: 0.1411764706, alpha: 1),#colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1),#colorLiteral(red: 0.6549019608, green: 0.2784313725, blue: 0.3803921569, alpha: 1)]
    var categories = [Tag]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
       

        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(label)
        label.center(in: containerView)
        
         APIRequest.getTags(url: "/apiCategorias/tags"){ data in
//        label.center(in: containerView)
            if let tags = data {
               self.categories = tags
                OperationQueue.main.addOperation {
                    self.setupButtons()
                }

            }

        }
        
        
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
//        if UIDevice.current.orientation.isLandscape {
//            print("Landscape")
//            scrollView.contentSize = CGSize(width:self.view.frame.height, height: self.view.frame.width)
//        } else {
//            print("Portrait")
//            scrollView.contentSize = CGSize(width:self.view.frame.width, height: self.view.frame.height)
//        }
    }

    func setupScrollView(){
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true

        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
        
    }
    func setupButtons(){
        let myX = contentViewSize.width
        var myY : CGFloat = 0.0
        
        let myHeight : CGFloat = contentViewSize.height / 6
        let myWidth = contentViewSize.width

        var idColor = 0
//        Creamos una variable VIEW para añadir dentro nuestro stack
        let view = UIView()
        var buttonsStack : [UIButton] = []
        for tag in self.categories {
            
            if tag.name != "Zona empresas" && tag.name != "Centro de Empleo"{
                let button = UIButton(frame: CGRect(x: myX, y: myY, width: myWidth, height:myHeight))
                button.tag = tag.id
                button.backgroundColor = self.colorOrder[idColor]
                button.setTitle(tag.name, for: [])
                button.titleLabel?.font = UIFont(name: "Quicksand", size: 20.0)
                button.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
                button.height(myHeight)
                
                view.addSubview(button)
                buttonsStack.append(button)
//                hacemos que el boton se ancle a los lados de la view excepto bottom
                button.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
                
                idColor += 1
            }
        }
        containerView.stack(buttonsStack,axis: .vertical,width: contentViewSize.width,height: contentViewSize.height,spacing: 20)
       
    
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
