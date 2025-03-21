//
//  Acheteur.swift
//  LaCaveAJeu
//
//  Created by etud on 16/03/2025.
//

import Foundation

struct Acheteur : Codable, Identifiable {
    var id : String?
    var nom : String
    var prenom  : String
    var email : String
    var adresse : String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nom, prenom, email, adresse
    }
    
    init(id: String?, nom: String, prenom: String, email: String, adresse: String?) {
        self.id = id
        self.nom = nom
        self.prenom = prenom
        self.email = email
        if (adresse != nil){
            self.adresse = adresse
        }
        
    }
    
    
    
}

