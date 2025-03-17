//
//  Game.swift
//  LaCaveAJeu
//
//  Created by etud on 16/03/2025.
//

import Foundation

struct Game : Codable{
    var id : String
    var proprietaire : String
    var typeJeu : String
    var prix : Double
    var categorie : String
    var quantite : Int
    var statut : String
    
    init(id: String, proprietaire: String, typeJeu: String, prix: Double, categorie: String, quantite: Int, statut: String) {
        self.id = id
        self.proprietaire = proprietaire
        self.typeJeu = typeJeu
        self.prix = prix
        self.categorie = categorie
        self.quantite = quantite
        self.statut = statut
    }
    
    //Getters
    
    var getId: String {
        return id
    }
    
    var getProprietaire : String {
        return proprietaire
    }
    
    var getTypeJeu: String {
        return typeJeu
    }
    
    var getPrix : Double {
        return prix
    }
    var getCategorie: String {
        return categorie
    }
    
    var getquantite : Int {
        return quantite
    }
    
    var getStatut : String {
        return statut
    }
    
    //Setters
    
    mutating func setId(_ id : String){
        self.id = id
    }
    
    mutating func setProprietaire(_ proprietaire : String){
        self.proprietaire = proprietaire
    }
    
    mutating func setTypeJeu(_ tJ : String){
        self.typeJeu = tJ
    }
    
    mutating func setPrix(_ prix : Double){
        self.prix = prix
    }
    
    mutating func setCategorie(_ cate : String){
        self.categorie = cate
    }
    
    mutating func setquantite(_ quantite : Int){
        self.quantite = quantite
    }
    
    mutating func setStatut(_ statut : String){
        self.statut = statut
    }
}
