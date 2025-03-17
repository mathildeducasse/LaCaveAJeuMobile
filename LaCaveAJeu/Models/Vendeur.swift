//
//  Vendeur.swift
//  LaCaveAJeu
//
//  Created by etud on 16/03/2025.
//

import Foundation

struct Vendeur : Codable, Identifiable{
    var id : String?
    var nom : String
    var prenom  : String
    var email : String
    var telephone : String
    var soldes : Double
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"   // Convertit "_id" en "id" pour Swift
        case nom, prenom, email, telephone, soldes
       }
    
    init( id : String?, nom: String, prenom: String, email: String, telephone: String, soldes: Double) {
        self.id = id
        self.nom = nom
        self.prenom = prenom
        self.email = email
        self.telephone = telephone
        self.soldes = soldes
    }
    
   
}
