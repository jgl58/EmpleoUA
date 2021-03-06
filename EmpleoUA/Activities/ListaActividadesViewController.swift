//
//  ListaActividadesViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 07/08/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit
import WebKit

class ListaActividadesViewController: AuthViewController {

    var tagID : Int?
    
    var activities = [Actividad]()
    var colorOrder = [#colorLiteral(red: 0.0431372549, green: 0.3019607843, blue: 0.4196078431, alpha: 1),#colorLiteral(red: 0.1529411765, green: 0.462745098, blue: 0.462745098, alpha: 1),#colorLiteral(red: 0.5882352941, green: 0.2980392157, blue: 0.1411764706, alpha: 1),#colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1),#colorLiteral(red: 0.6549019608, green: 0.2784313725, blue: 0.3803921569, alpha: 1)]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .singleLine
  
       APIRequest.getActividadesByTag(tag: tagID!){ data in
            if let act = data {
            
                    OperationQueue.main.addOperation {
                        self.activities = act
                        self.tableView.reloadData()
                    }
                
                
            }
        }

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
        dateFormatterPrint.dateFormat = "dd/MM/yyyy 'a las' HH:mm"
        

        if let date = dateFormatterGet.date(from: fecha) {
            return dateFormatterPrint.string(from: date)

        } else {
           print("There was an error decoding the string")
        }
        return nil
    }

    

  
}

extension ListaActividadesViewController: UITableViewDelegate, UITableViewDataSource{
    
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
        if let date = actividad.fechaInicio{
            if let f = formatData(fecha: date){
                cell.fecha.text = f
            }else{
                cell.fecha.text = "No hay fecha todavia"
            }
        }
        
        if let url = actividad.urlFoto {
            //setImage(from: url, imageView: cell.imagen)
            cell.imagen.loadThumbnail(urlString: url)
        }else{
            cell.imagen.image = UIImage(named: "UALOGO3")
        }
        cell.lugar.text = actividad.lugar

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
