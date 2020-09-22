//
//  MisActividadesController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 21/09/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit

class MisActividadesController: UITableViewController {
    
    var appDelegate : AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
      

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        print(appDelegate.misActividades.count)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appDelegate.misActividades.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MisActividadesCell", for: indexPath) as! MisActividadesCell
        
        let actividad = appDelegate.misActividades[indexPath.row]
        cell.datosActividades.text = actividad.nombre!
        
        cell.fechaActividades.text = formatData(fecha: actividad.fechaFin!)
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
