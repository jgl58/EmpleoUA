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
                UIBarButtonItem(image: UIImage(named: "Logout")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(logout))
        }else{
            navigationItem.rightBarButtonItem =
                UIBarButtonItem(image: UIImage(named: "Login")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(login))
        }
    }
    
    @objc func logout(){
        if let _ = UserDefaults.standard.string(forKey: "Token") {
            
            let alert = UIAlertController(title: "¿Desea cerrar sesión?", message: "", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                print("Cerramos sesion")
                UserDefaults.standard.removeObject(forKey: "Token")
                self.navigationItem.rightBarButtonItem =
                    UIBarButtonItem(image: UIImage(named: "Login")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.login))
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

            self.present(alert, animated: true)
            
            
            
        }
    }

    @objc func login(){
        print("Inicio sesion")
        navigationController?.pushViewController(LoginController(),animated: true)
    }

}
