//
//  APIRequest.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 09/04/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
}



class APIRequest {
    
    static let base_url = "https://appempleo.ua.es"
    static let activities_url = "/apiActividades/obtener"
    static let citas_url = "/apiCitas/obtener"
    static let activities_filter = "?sort=fechaInicio&order=desc&curso=2&tipoTag="
    
    static func getTags(url: String,callback: @escaping ([Tag]?)->Void){
        let session = URLSession.shared
        let url = URL(string: self.base_url+url)!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
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
    
    static func getCitas(url: String,callback: @escaping ([Cita]?)->Void){
        let session = URLSession.shared
        
        let url = URL(string: self.base_url+self.citas_url+"?tipo="+url)!
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if error != nil {
                print(error as Any)
                callback(nil)
            }
            do {
                let json = try JSONDecoder().decode([Cita].self, from: data!)
                callback(json)
           } catch {
               print("Error during JSON serialization: \(error.localizedDescription)")
           }
        })
        task.resume()
        
    }
    
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
    
//    PARTE PARA DESCARGAR IMAGENES
    
    private static func getData(url: URL,
                                completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    public static func downloadImage(url: URL,
                                     completion: @escaping (Result<Data>) -> Void) {
        APIRequest.getData(url: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async() {
                completion(.success(data))
            }
        }
    }
    
}
