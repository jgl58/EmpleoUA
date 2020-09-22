//
//  MisCitasController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 21/09/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit

class MisCitasController: UITableViewController {

    var appDelegate : AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        self.title = "Mis citas"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appDelegate.misCitas.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 91.0
    }

    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "MisCitasCell", for: indexPath) as! MisCitasCell
         
         let cita = appDelegate.misCitas[indexPath.row]
         
         
        cell.dia?.text = getDay(cita)
        
        let form = DateFormatter()
        form.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        cell.hora?.text = dateFormatter.string(from: form.date(from: cita)!)
      
        return cell
     }
    
    func getDay(_ event: String) -> String?{
          let dayFormaterGet = DateFormatter()
             dayFormaterGet.dateFormat = "dd-MM-yyyy HH:mm:ss"
         
         let dayFormater = DateFormatter()
         dayFormater.dateFormat = "dd-MM-yyyy"
          
          if let d = dayFormaterGet.date(from: event) {
            return dayFormater.string(from: d)
          } else {
              return nil
          }
          
      }
  

}
class MisCitasCell : UITableViewCell {

    @IBOutlet weak var dia: UILabel!
    
    @IBOutlet weak var hora: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
