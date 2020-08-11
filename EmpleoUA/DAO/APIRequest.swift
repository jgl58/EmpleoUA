//
//  APIRequest.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 09/04/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import Foundation

class APIRequest {
    
    static let base_url = "https://appempleo.ua.es"
    static let activities_url = "/apiActividades/obtener"
    static let activities_filter = "?sort=fechaInicio&order=desc&curso=2&tipoTag="
    
    static func getTags(url: String,callback: @escaping ([Tag]?)->Void){
        let session = URLSession.shared
        let url = URL(string: self.base_url+url)!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            // Check if an error occured
            if error != nil {
                print(error as Any)
                callback(nil)
            }
            do {
                let json = try JSONDecoder().decode([Tag].self, from: data!)
                callback(json)
           } catch {
               print("Error during JSON serialization: \(error.localizedDescription)")
           }
        })
        task.resume()
        
    }
    static func getTag(url: String,callback: @escaping (Tag?)->Void){
            let session = URLSession.shared
            let url = URL(string: self.base_url+url)!
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                // Check if an error occured
                if error != nil {
                    // HERE you can manage the error
                    print(error as Any)
                    callback(nil)
                }
                do {
                    let json = try JSONDecoder().decode(Tag.self, from: data!)
    //                let json = try? JSONSerialization.jsonObject(with: data!, options: [])   
                    callback(json)
               } catch {
                   print("Error during JSON serialization: \(error.localizedDescription)")
               }
            })
            task.resume()
            
        }
    
    static func getActividad(class: Any, url: String,callback: @escaping (Actividad?)->Void){
        let session = URLSession.shared
        let url = URL(string: self.base_url+url)!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            // Check if an error occured
            if error != nil {
                // HERE you can manage the error
                print(error as Any)
                callback(nil)
            }
            do {
               let json = try JSONDecoder().decode(Actividad.self, from: data!)
                callback(json)
           } catch {
               print("Error during JSON serialization: \(error.localizedDescription)")
           }
            
        })
        task.resume()
        
    }
//apiActividades/obtener?sort=fechaInicio&order=asc&curso=1&tipoTag=1
    
    static func getActividadesByTag(tag: Int,callback: @escaping ([Actividad]?)->Void){
        let session = URLSession.shared
        let url = URL(string: self.base_url+self.activities_url+self.activities_filter+String(tag))!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            // Check if an error occured
            if error != nil {
                // HERE you can manage the error
                print(error as Any)
                callback(nil)
            }
            do {
               let json = try JSONDecoder().decode([Actividad].self, from: data!)
                callback(json)
           } catch {
               print("Error during JSON serialization: \(error.localizedDescription)")
           }
            
        })
        task.resume()
        
    }
    
}
