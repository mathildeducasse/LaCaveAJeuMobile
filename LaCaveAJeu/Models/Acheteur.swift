//
//  Acheteur.swift
//  LaCaveAJeu
//
//  Created by etud on 16/03/2025.
//

import Foundation

struct Acheteur : Codable{
    var id : String
    var nom : String
    var prenom  : String
    var email : String
    var adresse : String? = nil
    
    
    init(id: String, nom: String, prenom: String, email: String, adresse: String?) {
        self.id = id
        self.nom = nom
        self.prenom = prenom
        self.email = email
        if (adresse != nil){
            self.adresse = adresse
        }
        
    }
    
    //Getters :
    
    var getId : String {
        return id
    }
    
    var getNom : String {
        return nom
    }
    
    var getPrenom : String {
        return nom
    }
    
    var getEmail : String {
        return email
    }
    
    var getAdresse : String? {
        return adresse
    }
    
    
    //Setters :
    
    mutating func setId (_ id : String){
        self.id = id
    }
    
    mutating func setNom (_ nom : String){
        self.nom = nom
    }
    
    mutating func setPrenom (_ prenom : String){
        self.prenom = prenom
    }
    
    mutating func setEmail(_ email : String){
        self.email = email
    }
    
    mutating func setAdresse (_ adresse : String){
        self.adresse = adresse
    }
    
}

