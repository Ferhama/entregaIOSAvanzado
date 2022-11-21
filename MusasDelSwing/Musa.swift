//
//  Musa.swift
//  MusasDelSwing
//
//  Created by Fernando Haro Martínez on 17/11/22.
//

import UIKit

class Musa {
    var nombre : String
    var foto : String
    var fecha : String
    var bio : String?
    var apodo : String
    var linkArray : [String]

    init(nombre: String, foto: String, fecha: String, bio: String?,apodo: String, linkArray: [String]) {
        self.nombre = nombre
        self.fecha = fecha
        self.foto = foto
        self.bio = bio
        self.apodo = apodo
        self.linkArray = linkArray
    }
}
