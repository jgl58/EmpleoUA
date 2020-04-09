//
//  Tag.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 09/04/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import Foundation

struct Tag : Decodable {
    var id : Int
    var email : String
    var name : String
    var notes : String?
    var parentTag : tipoTag?
}
