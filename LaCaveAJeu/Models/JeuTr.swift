//
//  JeuTr.swift
//  LaCaveAJeu
//
//  Created by etud on 20/03/2025.
//

import Foundation
//
//  Game.swift
//  LaCaveAJeu
//
//  Created by etud on 16/03/2025.
//

import Foundation

struct JeuTr : Codable, Identifiable{
    
    var id : String?
    var intitule : String
    var editeur : String
    var quantite : Int
    var prix_unitaire : Double
    var vendeur : String
    var categories : [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "jeuId"
        case vendeur,intitule , editeur, prix_unitaire , categories, quantite
       }
    
    init(id: String?, vendeur: String, intitule: String,editeur : String, prix_unitaire: Double, categorie: [String], quantite: Int) {
        self.id = id
        self.vendeur = vendeur
        self.intitule = intitule
        self.editeur = editeur
        self.prix_unitaire = prix_unitaire
        self.categories = categorie
        self.quantite = quantite

    }
    
   
    
}
