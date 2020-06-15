//
//  ActividadItem.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 01/06/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import UIKit

class ActividadItem: UITableViewCell {

    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var fecha: UILabel!
    
    @IBOutlet weak var imagen: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
