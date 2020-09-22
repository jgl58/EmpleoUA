//
//  MisActividadesController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 21/09/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit

class MisActividadesController: AuthViewController, UITableViewDelegate, UITableViewDataSource {
    
    var appDelegate : AppDelegate!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = "Mis Actividades"
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        print(appDelegate.misActividades.count)
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appDelegate.misActividades.count
    }

   
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MisActividadesCell", for: indexPath) as! MisActividadesCell
        
        let actividad = appDelegate.misActividades[indexPath.row]
        cell.datosActividades.text = actividad.nombre!
        
        cell.fechaActividades.text = formatData(fecha: actividad.fechaFin!)
       
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
    }
    
    func formatData(fecha: String) -> String?{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy - HH:mm"

        if let date = dateFormatterGet.date(from: fecha) {
            return (dateFormatterPrint.string(from: date))
        } else {
           print("There was an error decoding the string")
        }
        return nil
    }
}


class MisActividadesCell : UITableViewCell {
    @IBOutlet weak var datosActividades: UILabel!
    
    @IBOutlet weak var fechaActividades: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
