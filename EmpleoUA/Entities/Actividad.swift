//
//  Actividad.swift
//  EmpleoUA
//
//  Created by Jonay Gilabert López on 09/04/2020.
//  Copyright © 2020 Jonay Gilabert López. All rights reserved.
//

import Foundation

struct Actividad : Codable {
    var id : Int
    var capacidad : Int
    var contenido : String
    var curso : cursoAux
    var estadoMatriculaPorDefecto : estadoMatriculaPorDefecto
    var fechaFin : String
    var fechaFinMatricula : String
    var fechaInicio : String
    var fechaInicioMatricula : String
    var lugar : String
    var nombre : String
    var tipoActividad : tipoActividad
    var tipoTag : tipoTag
    var urlAmigable : String
    var urlFoto : String?
    var visible : Bool
}

struct cursoAux : Codable {
    var `class` : String
    var id : Int
}

struct estadoMatriculaPorDefecto : Codable {
    var `class` : String
    var id : Int
}

struct tipoActividad : Codable {
    var `class` : String
    var id : Int
}

struct tipoTag : Codable {
    var `class` : String
    var id : Int
}
