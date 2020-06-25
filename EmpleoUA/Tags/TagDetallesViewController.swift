//
//  TagDetallesViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 23/04/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit
import WebKit
import TinyConstraints

class TagDetallesViewController: UIViewController {
    
    var tagID : Int?
    private let webView = WKWebView(frame: .zero)
    
    var activities = [Actividad]()
    var colorOrder = [#colorLiteral(red: 0.0431372549, green: 0.3019607843, blue: 0.4196078431, alpha: 1),#colorLiteral(red: 0.1529411765, green: 0.462745098, blue: 0.462745098, alpha: 1),#colorLiteral(red: 0.5882352941, green: 0.2980392157, blue: 0.1411764706, alpha: 1),#colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1),#colorLiteral(red: 0.6549019608, green: 0.2784313725, blue: 0.3803921569, alpha: 1)]
    @IBOutlet weak var tableView: UITableView!
    

    //    @IBOutlet weak var scrollView: UIScrollView!

    lazy var scrollView: CustomScrollView = {
        let sview = CustomScrollView(view: view, buttonHeight: 400.0)
        return sview
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
  
        APIRequest.getTag(url: "/apiCategorias/tags/"+String(tagID!)){ data in
            if let tag = data {
                if tag.name == "Prácticas y empleo"{
                    OperationQueue.main.addOperation {
                        self.tableView.isHidden = true

                        self.view.addSubview(self.scrollView)
                        self.setupButtons()
                        
                    }
                }else{

                    APIRequest.getActividadesByTag(tag: 1){ data in
                        if let act = data {
                            print(String(tag.id) + " " + tag.name)
                            print("Nº de actividades: "+String(act.count))
                            OperationQueue.main.addOperation {
                                self.tableView.isHidden = false
                               
                                self.activities = act
                                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filtrar", style: .plain, target: self, action: #selector(self.menu))
                                self.tableView.reloadData()
                                //self.setupActivites()
                            }
                        }
                    }
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "activitySegue" {
            if let newViewController = segue.destination as? ActividadViewController {

                newViewController.title = "Actividad"
                newViewController.actividad = activities[self.tableView.indexPathForSelectedRow!.row]
                
                
            }
        }
    }
    func formatData(fecha: String) -> String?{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"

        if let date = dateFormatterGet.date(from: fecha) {
            return (dateFormatterPrint.string(from: date))
        } else {
           print("There was an error decoding the string")
        }
        return nil
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
        
        if sender.tag == 1 {
            print("Hola")
            let url = URL(string: "https://web.ua.es/es/centro-empleo/practicas-y-empleo/practicas-en-la-ua/")!
            setWebView(url: url)
        }else if sender.tag == 2 {
            let url = URL(string: "https://web.ua.es/es/centro-empleo/practicas-y-empleo/ofertas-de-empleo-para-titulados-de-la-ua/")!
            setWebView(url: url)
        }
        
    }
    
    @objc func menu() {
        

    }
    
    
    func setImage(from url: String,imageView: UIImageView) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }

}

extension TagDetallesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ActividadItem
        let actividad = activities[indexPath.row]
        cell.titulo.text = actividad.nombre
        if let date = actividad.fechaFin{
            if let f = formatData(fecha: date){
                cell.fecha.text = f
            }else{
                cell.fecha.text = "No hay fecha todavia"
            }
        }
        
        if let url = actividad.urlFoto {
            setImage(from: url, imageView: cell.imagen)
        }
        cell.lugar.text = actividad.lugar
        
        // Configure the cell...

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
