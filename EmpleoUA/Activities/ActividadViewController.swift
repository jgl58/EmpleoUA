//
//  ActividadViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 13/04/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit
import UserNotifications

class ActividadViewController: AuthViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var actividad : Actividad?
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var lugar: UILabel!
    @IBOutlet weak var capacidad: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titulo.text = actividad?.nombre
        
        if let _ = actividad?.fechaInicio {
           fecha.text = formatData(fecha: actividad!.fechaInicio!)
        }else{
            fecha.text = ""
        }
        
        lugar.text = actividad?.lugar
        if let _ = actividad?.capacidad {
           capacidad.text = "Aforo: \(actividad!.capacidad!) personas"
        }else{
            capacidad.text = "Aforo: Ilimitado"
        }
        
        if let url =  actividad?.urlFoto{
         setImage(from: url, imageView: imagen)
        }
        
       
        // Do any additional setup after loading the view.
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
    
    @IBAction func goWebsite(_ sender: Any) {
        
       let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WebView") as! WebViewController
        
        newViewController.url = "https://appempleo.ua.es/actividad/ver/\(actividad?.urlAmigable ?? "")"
         navigationController!.pushViewController(newViewController, animated: true)
    }
    @IBAction func inscribirse(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        if let authToken = defaults.string(forKey: "Token"){
            print(authToken)
            let alert = UIAlertController(title: "Te has inscrito a la oferta", message: "", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                
                self.appDelegate.misActividades.append(self.actividad!)
                Notificaciones.setNotificacionActividad(actividad: self.actividad!)
                
            }))

            self.present(alert, animated: true)
        }else{
            let alert = UIAlertController(title: "No has iniciado sesión", message: "Se necesita iniciar sesión para poder registrarte", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Si", style: .default, handler: { action in
                self.navigationController?.pushViewController(LoginController(), animated: true)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

            self.present(alert, animated: true)
        }
    }
    
   
    
    func formatData(fecha: String) -> String?{
          let dateFormatterGet = DateFormatter()
          dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

          let dateFormatterPrint = DateFormatter()
          dateFormatterPrint.dateFormat = "dd/MM/yyyy 'a las' HH:mm"

          if let date = dateFormatterGet.date(from: fecha) {
              return (dateFormatterPrint.string(from: date))
          } else {
             print("There was an error decoding the string")
          }
          return nil
      }
      
}

