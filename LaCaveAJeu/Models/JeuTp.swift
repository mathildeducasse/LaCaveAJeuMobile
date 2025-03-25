//
//  JeuTp.swift
//  LaCaveAJeu
//
//  Created by etud on 24/03/2025.
//

import Foundation

struct JeuTp : Codable {
    var proprietaire : String
    var typeJeuId : String
    var statut : String
    var prix : Double
    var quantites : Int
    
    init(proprietaire : String, typejeu : String, prix : Double, statut : String, quantites : Int){
        self.proprietaire = proprietaire
        self.typeJeuId = typejeu
        self.prix = prix
        self.statut = statut
        self.quantites = quantites
    }
    
}
