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
    
    var eventosDias = [String]()
    
    let dateFormatter = DateFormatter()
    
    let datesForEvents = ["2020-09-03 12:00:00",
                          "2020-09-03 18:00:00",
                          "2020-09-06 18:00:00",
                          "2020-09-25 17:00:00",
                          "2020-10-02 12:00:00"]
    
    var days = [String]()
    var diccionario = [String:[String]]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        listaCitas.delegate = self
        listaCitas.dataSource = self
        
        listaCitas.separatorStyle = .none
     
        days = datesForEvents.map({ (event) -> String in
            return getDay(event)!
        })
             
        loadEvents()
        
    }
    
    func getDay(_ event: String) -> String?{
        let dayFormaterGet = DateFormatter()
           dayFormaterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
       
       let dayFormater = DateFormatter()
       dayFormater.dateFormat = "yyyy-MM-dd"
        
        if let d = dayFormaterGet.date(from: event) {
          return dayFormater.string(from: d)
        } else {
            return nil
        }
        
    }

    
    func loadEvents(){
        for event in datesForEvents {
            
            if diccionario.count != 0 {
                print(event)
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
  
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    
        dateFormatter.dateFormat = "yyyy-MM-dd"
         
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
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if days.count != 0 {
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
            form.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
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

           alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

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
