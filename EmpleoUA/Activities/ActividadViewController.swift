//
//  ActividadViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 13/04/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit

class ActividadViewController: UIViewController {

    var actividad : Actividad?
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var lugar: UILabel!
    @IBOutlet weak var capacidad: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titulo.text = actividad?.nombre
        fecha.text = actividad?.fechaFin
        lugar.text = actividad?.lugar
        capacidad.text = "\(actividad!.capacidad!)"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

