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
    

        self.tableView.delegate = self
        self.tableView.dataSource = self
//        view.addSubview(scrollView)
      //  scrollView.addSubview(containerView)

         APIRequest.getTags(url: "/apiCategorias/tags"){ data in

            if let tags = data {
                for t in tags {
                   if t.name != "Zona empresas" && t.name != "Centro de Empleo"{
                        self.categories.append(t)
                    }
                }
               

                OperationQueue.main.addOperation {
//                    self.setupTags()

                    self.tableView.reloadData()
                }

            }

        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tagSegue" {
            if let nextViewController = segue.destination as? TagDetallesViewController {
                
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
        cell.backgroundColor = colorOrder[indexPath.row]
        cell.titulo.text = categories[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
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
