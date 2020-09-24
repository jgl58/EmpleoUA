//
//  Notificaciones.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 23/09/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import Foundation
import UserNotifications

class Notificaciones {
    static var dateFormatterInput = DateFormatter()
    static var dateFormatterOutput = DateFormatter()
    
    static let retrasoMinutos = -5
    static let retrasoHoras = -2
    
    
    static func setNotificacionActividad(actividad: Actividad){
        
        let center = UNUserNotificationCenter.current()
            
        let content = UNMutableNotificationContent()
                   content.title = "Recordatorio de actividad"
                   content.subtitle = actividad.nombre!
                   content.body = actividad.lugar!
                   content.sound = UNNotificationSound.default
        
            
        let dateFormatterInput = DateFormatter()
            dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        //        var date = dateFormatterInput.date(from: actividad.fechaInicio!)

        let date = dateFormatterInput.date(from: "2020-09-24T11:22:00Z")

        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "GMT+2")!
    //        var notificacionDate = calendar.date(byAdding: .minute, value: -30, to: date!)!
        var notificacionDate = calendar.date(byAdding: .minute, value: self.retrasoMinutos, to: date!)!
        notificacionDate = calendar.date(byAdding: .hour, value: self.retrasoHoras, to: notificacionDate)!
        
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: notificacionDate)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let uuid = UUID().uuidString

        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        
        center.add(request) {(error) in
           if let error = error {
              print("Se ha producido un error: \(error)")
           }
        }

    }
    
    
    static func setNotificacionCita(cita: String){
        
        let center = UNUserNotificationCenter.current()
            

        let dateFormatterInput = DateFormatter()
            dateFormatterInput.dateFormat = "dd-MM-yyyy HH:mm:ss"
        //        var date = dateFormatterInput.date(from: actividad.fechaInicio!)

        let date = dateFormatterInput.date(from: "24-09-2020 11:44:00")
        
        let calendar = Calendar.current
    //        var notificacionDate = calendar.date(byAdding: .minute, value: -30, to: date!)!
        var notificacionDate = calendar.date(byAdding: .minute, value: self.retrasoMinutos, to: date!)!
        
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: notificacionDate)
        print(dateComponents)
        
        let content = UNMutableNotificationContent()
        content.title = "Recordatorio de cita"
        content.subtitle = "Hoy a las \(calendar.component(.hour, from: date!)):\(calendar.component(.second, from: date!))"
        content.sound = UNNotificationSound.default

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let uuid = UUID().uuidString

        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        
        center.add(request) {(error) in
           if let error = error {
              print("Se ha producido un error: \(error)")
           }
        }

    }
}
