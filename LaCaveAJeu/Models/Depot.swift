//
//  Depot.swift
//  LaCaveAJeu
//
//  Created by etud on 25/03/2025.
//

import Foundation

struct Depot : Codable{
    var gestionnaire : String
    var proprietaire : String
    var acheteur : String?
    var prix_total : Float
    var frais: Float
    var jeux : [JeuDepot]
    var remise : Float
     
    init(gestionnaire: String, proprietaire : String, prix_total: Float, frais: Float, remise: Float, jeux: [JeuDepot]) {
        self.gestionnaire = gestionnaire
        self.prix_total = prix_total
        self.frais = frais
        self.remise = remise
        self.proprietaire = proprietaire
        self.acheteur = nil
        self.jeux = jeux
    }
    
}
