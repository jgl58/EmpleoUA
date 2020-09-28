//
//  MisCitasController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 21/09/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit

class MisCitasController: AuthViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var appDelegate : AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.title = "Mis Citas"
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(appDelegate.misCitas.count)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appDelegate.misCitas.count
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 91.0
    }

    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "MisCitasCell", for: indexPath) as! MisCitasCell
         
         let cita = appDelegate.misCitas[indexPath.row]
         
        print(cita)
         
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
