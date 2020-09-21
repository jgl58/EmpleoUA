//
//  Cita.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 21/09/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import Foundation

struct Cita : Codable {
    var id : Int
    var curso : cursoAux?
    var estadoCita : auxCita?
    var fechaAsignacion : String?
    var fechaFin : String?
    var fechaInicio : String?
    var tipoCita : auxCita?
    var usuarioAsistente : auxCita?
    var usuarioTecnico : auxCita?
}

struct auxCita : Codable{
    var `class` : String?
    var id : Int?
}

