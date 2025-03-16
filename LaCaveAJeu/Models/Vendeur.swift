//
//  Vendeur.swift
//  LaCaveAJeu
//
//  Created by etud on 16/03/2025.
//

import Foundation

struct Vendeur {
    var id : String
    var nom : String
    var prenom  : String
    var email : String
    var telephone : String
    var solde : Double
    
    init(id: String, nom: String, prenom: String, email: String, telephone: String, solde: Double) {
        self.id = id
        self.nom = nom
        self.prenom = prenom
        self.email = email
        self.telephone = telephone
        self.solde = solde
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
    
    var getTelephone : String {
        return telephone
    }
    
    var getSolde : Double {
        return solde
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
    
    mutating func setTelephone (_ telephone : String){
        self.telephone = telephone
    }
    
    mutating func setSolde (_ solde : Double){
        self.solde = solde
    }
}
