//
//  SolicitarViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 17/08/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit
import FSCalendar

class SolicitarViewController: AuthViewController {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var listaCitas: UITableView!
    
    var appDelegate : AppDelegate!
    
    var tipoSolicitud : String?
    var eventosDias = [String]()
    
    let dateFormatter = DateFormatter()

    var datesForEvents = [String]()
    
    var days = [String]()
    var diccionario = [String:[String]]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        listaCitas.delegate = self
        listaCitas.dataSource = self
        
        listaCitas.separatorStyle = .none
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        APIRequest.getCitas(url: self.tipoSolicitud!){ data in
           if let citas = data {
               let dateFormatterGet = DateFormatter()
               dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "dd-MM-yyyy HH:mm:ss"
            
                self.days = citas.map({ (event) -> String in
                    let date = dateFormatterPrint.string(from: dateFormatterGet.date(from: event.fechaInicio!)!)
                    self.datesForEvents.append(date)
                    return self.getDay(date)!
                })
                self.loadEvents()
                OperationQueue.main.addOperation {
                    self.calendar.reloadData()
                }
            
           }
       }

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

    
    func loadEvents(){
        for event in datesForEvents {
            
            if diccionario.count != 0 {
                
                if !checkEvent(event: event) {
                    diccionario[getDay(event)!] = [event]
                }
            }else{
                diccionario[getDay(event)!] = [event]
            }
        }
    }
    
        
    func checkEvent(event: String) -> Bool{
        for (e, _) in diccionario {
            if e == getDay(event) {
                var arr = diccionario[e]
                arr?.append(event)
                diccionario[e] = arr
                return true
            }
        }
        return false
    }
    


}

extension SolicitarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        self.view.layoutIfNeeded()
        calendar.reloadData()
    }
  
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    
        dateFormatter.dateFormat = "dd-MM-yyyy"
         
        if let ev = diccionario[dateFormatter.string(from: date)] {
           eventosDias = ev
            self.listaCitas.separatorStyle = .singleLine
        }else{
            print("No hay eventos")
            eventosDias = []
            self.listaCitas.separatorStyle = .none
        }
        self.listaCitas.reloadData()
    }

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
//        Filtramos por dias para conocer en los que hay eventos
        if days.count != 0 {
            print(dateFormatter.string(from: date))
            if days.contains(dateFormatter.string(from: date)) {
                return 1
            } else {
                return 0
            }
        } else {
            return 0
        }

    }
    
}

extension SolicitarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventosDias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell", for: indexPath)
      
        if eventosDias.count != 0{

            cell.textLabel?.text = getDay(eventosDias[indexPath.row])
            
            let form = DateFormatter()
            form.dateFormat = "dd-MM-yyyy HH:mm:ss"
            
            dateFormatter.dateFormat = "HH:mm"
            
            cell.detailTextLabel?.text = dateFormatter.string(from: form.date(from: eventosDias[indexPath.row])!)
        
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        solicitarCita()
//        falta añadir logica de la reserva
    }
    
    func solicitarCita(){
        let defaults = UserDefaults.standard
       if let authToken = defaults.string(forKey: "Token"){
           print(authToken)
           let alert = UIAlertController(title: "Has reservado la cita", message: "", preferredStyle: .alert)

           alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            
            let id = self.listaCitas.indexPathForSelectedRow?.row
            self.appDelegate.misCitas.append(self.eventosDias[id!])
            Notificaciones.setNotificacionCita(cita: self.eventosDias[id!])
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
    
}
