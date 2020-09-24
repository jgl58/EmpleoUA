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
    
    static func setNotificacionActividad(actividad: Actividad){
        
        self.dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        var date = dateFormatterInput.date(from: actividad.fechaInicio!)

        let content = UNMutableNotificationContent()
        content.title = "Recordatorio de actividad"
        content.subtitle = actividad.nombre!
        content.body = actividad.lugar!
        content.sound = UNNotificationSound.default
        
        let date = dateFormatterInput.date(from: "2020-09-24T10:49:00Z")
        
            let calendar = Calendar.current
            let notificacionDate = calendar.date(byAdding: .minute, value: -5, to: date!)
        
        
        var fecha = DateComponents()
        fecha.hour = calendar.component(.hour, from: notificacionDate!)
        fecha.minute = calendar.component(.minute, from: notificacionDate!)
        fecha.day = calendar.component(.day, from: notificacionDate!)
        fecha.month = calendar.component(.month, from: notificacionDate!)
        fecha.year = calendar.component(.year, from: notificacionDate!)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: fecha, repeats: false)
        
        let uuid = UUID().uuidString
    
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
           if let error = error {
              print("Se ha producido un error: \(error)")
           }
        }

    }
}
