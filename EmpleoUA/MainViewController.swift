//
//  MainViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 16/04/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit
import TinyConstraints

class MainViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
 
    var categories = [Tag]()
    var colorOrder = [#colorLiteral(red: 0.0431372549, green: 0.3019607843, blue: 0.4196078431, alpha: 1),#colorLiteral(red: 0.1529411765, green: 0.462745098, blue: 0.462745098, alpha: 1),#colorLiteral(red: 0.5882352941, green: 0.2980392157, blue: 0.1411764706, alpha: 1),#colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1),#colorLiteral(red: 0.6549019608, green: 0.2784313725, blue: 0.3803921569, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "EmpleoUA"
    
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
         APIRequest.getTags(url: "/apiCategorias/tags"){ data in

            if let tags = data {
                for t in tags {
                   if t.name != "Zona empresas" && t.name != "Centro de Empleo"{
                        self.categories.append(t)
                    }
                }
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }

            }

        }
        
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tagSegue" {
            if let nextViewController = segue.destination as? ListaActividadesViewController {
                
                nextViewController.title = self.categories[self.tableView.indexPathForSelectedRow!.row].name
                    nextViewController.tagID = self.categories[self.tableView.indexPathForSelectedRow!.row].id
                
            }
        }
    }
    
    
}

extension MainViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath) as! TagCell
        cell.tag = categories[indexPath.row].id
        cell.containerView.backgroundColor = colorOrder[indexPath.row]
        cell.titulo.text = categories[indexPath.row].name
        cell.containerView.layer.cornerRadius = 5

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        switch indexPath.row {
            //Utilizmos el UIStoryboard para tener cargados los outlets
            case 0:
                let nextViewController : CategoriaViewController = storyBoard.instantiateViewController(withIdentifier: "Categoria") as! CategoriaViewController
                nextViewController.title = self.categories[indexPath.row].name
                nextViewController.categoryID = self.categories[indexPath.row].id
                nextViewController.color = self.colorOrder[indexPath.row]
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
                
            case 1:
                let nextViewController : ListaActividadesViewController = storyBoard.instantiateViewController(withIdentifier: "ListaActividades") as! ListaActividadesViewController

                nextViewController.title = self.categories[indexPath.row].name
                nextViewController.tagID = 1
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
                
            case 2:
                let nextViewController : CategoriaViewController = storyBoard.instantiateViewController(withIdentifier: "Categoria") as! CategoriaViewController
                nextViewController.title = self.categories[indexPath.row].name
                nextViewController.categoryID = self.categories[indexPath.row].id
                nextViewController.color = self.colorOrder[indexPath.row]
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            case 3 :
                let nextViewController : CategoriaViewController = storyBoard.instantiateViewController(withIdentifier: "Categoria") as! CategoriaViewController
                nextViewController.title = self.categories[indexPath.row].name
                nextViewController.categoryID = self.categories[indexPath.row].id
                nextViewController.color = self.colorOrder[indexPath.row]
                self.navigationController?.pushViewController(nextViewController, animated: true)
            
            default:
                let nextViewController : CategoriaViewController = storyBoard.instantiateViewController(withIdentifier: "Categoria") as! CategoriaViewController
                nextViewController.title = self.categories[indexPath.row].name
                nextViewController.categoryID = self.categories[indexPath.row].id
                nextViewController.color = self.colorOrder[indexPath.row]
                self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        
        
        
        
    }
}

class TagCell: UITableViewCell {
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
