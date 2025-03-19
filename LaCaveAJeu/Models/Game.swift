//
//  Game.swift
//  LaCaveAJeu
//
//  Created by etud on 16/03/2025.
//

import Foundation

struct Game : Codable, Identifiable{
    
    var id : String?
    var vendeur : String
    var intitule : String
    var editeur : String
    var statut : String
    var prix : Double
    var quantites : Int
    var categories : [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "etiquette"
        case vendeur,intitule , editeur, statut, prix, quantites , categories
       }
    
    init(id: String?, vendeur: String, intitule: String,editeur : String, prix: Double, categorie: [String], quantite: Int, statut: String) {
        self.id = id
        self.vendeur = vendeur
        self.intitule = intitule
        self.editeur = editeur
        self.prix = prix
        self.categories = categorie
        self.quantites = quantite
        self.statut = statut
    }
    
   
    
}
