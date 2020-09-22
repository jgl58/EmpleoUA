//
//  CategoriaViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 07/08/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit

class CategoriaViewController: AuthViewController {
    
    var categoryID : Int!
    @IBOutlet weak var tableView: UITableView!
    var color : UIColor!
    
    var options : [Opciones]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadOpciones()
        
    }
  
    func loadOpciones(){
        switch categoryID {
        
        case 2:
            options = [
                Opciones(titulo: "Prácticas", tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/practicas-y-empleo/practicas-en-la-ua/"),
                Opciones(titulo: "Portal de empleo para titulados o tituladas de la UA",tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/practicas-y-empleo/ofertas-de-empleo-para-titulados-de-la-ua/"),
                Opciones(titulo: "Otras actividades",tipo: .Actividad, url: "1")
            ]
            break
        case 5:
            options = [
                Opciones(titulo: "¿Tienes una idea emprendedora?",tipo: .Solicitar, solicitudTipo: "1"),
                Opciones(titulo: "¿Cómo afrontar la busqueda de empleo?",tipo: .Solicitar, solicitudTipo: "2"),
                Opciones(titulo: "¿Cómo desarrollar mi currciculum?",tipo: .Solicitar, solicitudTipo: "3"),
                Opciones(titulo: "¿Cómo preparar una entrevista de trabajo?",tipo: .Solicitar, solicitudTipo: "4"),
                Opciones(titulo: "Tengo discapacidad o necesito apoyo educativo, ¿cómo busco trabajo?",tipo: .Solicitar, solicitudTipo: "5"),
                Opciones(titulo: "Programa de actividades de orientación",tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/orientacion/programa-de-actividades-de-orientacion.html"),
                Opciones(titulo: "Recursos",tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/orientacion/recursos.html"),
                Opciones(titulo: "Otras actividades",tipo: .Actividad,url: "5")
            ]
            break
        case 6:
            options = [
                Opciones(titulo: "Programa Mejora tu inserción laboral", tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/formacion/programa-mejora-tu-insercion-laboral.html"),
                Opciones(titulo: "Talleres UA:Emprende Lab", tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/formacion/talleres-ua-emprende-lab.html"),
                Opciones(titulo: "Factoria de Desarrollo", tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/formacion/factoria-de-desarrollo.html"),
                Opciones(titulo: "GENNERA-Retos empresas-estudiantes", tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/formacion/gennera-retos-empresas-estudiantes.html"),
                Opciones(titulo: "Tabarca Emprende", tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/formacion/tabarca-emprende.html"),
                Opciones(titulo: "Congreso SeoPlus", tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/formacion/congreso-seoplus.html"),
                Opciones(titulo: "Otras actividades",tipo: .Actividad, url: "6")
            ]
            break
            
        default:
            options = [
                Opciones(titulo: "Formación para el emprendedor",tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/emprendimiento/formacion-emprendedor/"),
                Opciones(titulo: "Explorer",tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/emprendimiento/explorer/"),
                Opciones(titulo: "Programa de desarrollo de ideas",tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/emprendimiento/programa-desarrollo-de-ideas/"),
                Opciones(titulo: "Concursos",tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/emprendimiento/concursos/"),
                Opciones(titulo: "Cita de orientación emprendedora",tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/emprendimiento/cita-de-orientacion-emprendedora/"),
                Opciones(titulo: "Espacios de trabajo",tipo: .WebKit, url: "https://web.ua.es/es/centro-empleo/emprendimiento/espacios-de-trabajo/"),
                Opciones(titulo: "Otras actividades",tipo: .Actividad, url: "7")
            ]
            break
        }
    }
    
    @objc func loadWebView(_ sender: UIButton!) {
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
        cell.titulo.text = actividad.titulo
   
        cell.containerView.backgroundColor = self.color
        cell.containerView.layer.cornerRadius = 5
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let actividad = options[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch actividad.tipo {
            case .Actividad:
                let nextViewController : ListaActividadesViewController = storyboard.instantiateViewController(withIdentifier: "ListaActividades") as! ListaActividadesViewController
                nextViewController.tagID = Int(actividad.url ?? "1")
                self.navigationController?.pushViewController(nextViewController, animated: true)
                break
            case .Solicitar:
                let nextViewController : SolicitarViewController = storyboard.instantiateViewController(withIdentifier: "Solicitar") as! SolicitarViewController
                nextViewController.tipoSolicitud = actividad.solicitudTipo!
                nextViewController.title = "Solicitar cita"
                           self.navigationController?.pushViewController(nextViewController, animated: true)
                break
            default://webkit
                let nextViewController : WebViewController = storyboard.instantiateViewController(withIdentifier: "WebView") as! WebViewController
                nextViewController.url = actividad.url
                self.navigationController?.pushViewController(nextViewController, animated: true)
                break
        }
        
        
        
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

//Clase para separar el tipo de opciones de cada categoria

enum TipoOpciones {
    case WebKit, Actividad, Solicitar
}

class Opciones{
    
    var titulo : String
    var tipo : TipoOpciones
    var url : String?
    var solicitudTipo: String?
    
    init(titulo: String, tipo: TipoOpciones) {
        self.tipo = tipo
        self.titulo = titulo
    }
    init(titulo: String, tipo: TipoOpciones, url: String) {
        self.tipo = tipo
        self.titulo = titulo
        self.url = url
    }
    
    init(titulo: String, tipo: TipoOpciones, solicitudTipo: String) {
        self.tipo = tipo
        self.titulo = titulo
        self.solicitudTipo = solicitudTipo
    }
}

