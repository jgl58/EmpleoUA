//
//  AuthViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 13/08/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    //Clase base que se encarga de controlar la autenticación y de la que heredan todas
    override func viewWillAppear(_ animated: Bool) {
        if let _ = UserDefaults.standard.string(forKey: "Token") {
            navigationItem.rightBarButtonItem =
                       UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        }else{
            navigationItem.rightBarButtonItem =
                       UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(login))
        }
    }
    
    @objc func logout(){
        if let _ = UserDefaults.standard.string(forKey: "Token") {
            print("Cerramos sesion")
            UserDefaults.standard.removeObject(forKey: "Token")
            navigationItem.rightBarButtonItem =
                       UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(login))
        }
    }

    @objc func login(){
        print("Inicio sesion")
        navigationController?.pushViewController(LoginController(),animated: true)
    }

}
