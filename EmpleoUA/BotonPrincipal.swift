//
//  File.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 30/04/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import Foundation
import UIKit
class BotonPrincipal: UIView {

    let nibName = "BotonPrincipal"
    var contentView: UIView?
    @IBOutlet weak var titulo: UILabel!
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
