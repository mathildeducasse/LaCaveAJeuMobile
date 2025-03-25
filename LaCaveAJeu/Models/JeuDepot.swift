//
//  JeuDepot.swift
//  LaCaveAJeu
//
//  Created by etud on 25/03/2025.
//

import Foundation

struct JeuDepot : Codable {
    var jeuId : String
    var quantite : Int
    var prix_unitaire : Double
    
    init(jeuid : String, quantites : Int, prixUnitaire : Double){
        self.jeuId = jeuid
        self.prix_unitaire = prixUnitaire
        self.quantite = quantites
    }
    
}
