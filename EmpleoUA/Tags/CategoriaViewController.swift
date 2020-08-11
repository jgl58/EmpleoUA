//
//  CategoriaViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 07/08/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit

class CategoriaViewController: UIViewController {
    
    var categoryID : Int!
    @IBOutlet weak var tableView: UITableView!
    var color : UIColor!
    
    var options : [String]!
    
//    lazy var scrollView: CustomScrollView = {
//        let sview = CustomScrollView(view: view, buttonHeight: 400.0)
//        return sview
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        print(categoryID)
        switch categoryID {
        
        case 2:
            options = ["Prácticas","Portal de empleo para titulados o tituladas de la UA"]
            break
        case 5:
            options = ["¿Tienes una idea emprendedora?","¿Cómo afrontar la busqueda de empleo?","¿Cómo desarrollar mi currciculum?",
            "¿Cómo preparar una entrevista de trabajo?", "Tengo discapacidad o necesito apoyo educativo, ¿cómo busco trabajo?",
            "Programa de actividades de orientación", "Recursos"]
            break
        case 6:
            options = ["Programa Mejora tu inserción laboral","TAlleres UA:Emprende Lab","Factoria de Desarrollo",
            "GENNERA-Retos empresas-estudiantes", "Tabarca Emprende",
            "Congreso SeoPlus"]
            break
            
        default:
             options = ["Formación para el emprendedor","Explorer","Programa de desarrollo de ideas",
                       "Concursos", "Cita de orientación emprendedora",
                       "Cita de orientación emprendedora"]
            break
        }
        
//
//        // Do any additional setup after loading the view.
//        OperationQueue.main.addOperation {
//          //  self.view.addSubview(self.scrollView)
//            self.setupButtons()
//        }
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
         
    }
    
    @objc func pressedPracticas(_ sender: UIButton!) {
        var url : String = ""
        if sender.tag == 1 {
             url = "https://web.ua.es/es/centro-empleo/practicas-y-empleo/practicas-en-la-ua/"
            
        }else if sender.tag == 2 {
             url = "https://web.ua.es/es/centro-empleo/practicas-y-empleo/ofertas-de-empleo-para-titulados-de-la-ua/"
            
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WebView") as! WebViewController
        
         newViewController.url = url
         navigationController!.pushViewController(newViewController, animated: true)
        
    }
    

}

extension CategoriaViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return options.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriaCell", for: indexPath) as! CategoriaCell
        let actividad = options[indexPath.row]
        cell.titulo.text = actividad
        cell.backgroundColor = self.color
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

class CategoriaCell: UITableViewCell {
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
