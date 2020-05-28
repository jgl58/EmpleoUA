//
//  ActividadViewController.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 13/04/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit

class ActividadViewController: UIViewController {

    @IBOutlet weak var descripcion: UITextView!
    var actividad : Actividad?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APIRequest.getActividad(class: Actividad.self, url: "/apiActividades/obtener/1"){ data in
            if let act = data {
               self.actividad = act
                
                print(self.actividad?.contenido!.withoutHtml)
                OperationQueue.main.addOperation {
                                    self.descripcion.text = self.actividad!.contenido!.withoutHtml

                }
            }
            
        }
        
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

extension String {
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }

        return attributedString.string
    }
}
