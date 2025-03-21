//
//  Transaction.swift
//  LaCaveAJeu
//
//  Created by etud on 20/03/2025.
//

import Foundation

struct Transaction : Codable, Identifiable{
    var id : String?
    var statut : String
    var gestionnaire : String
    var date_transaction : String?
    var prix_total : Float
    var frais: Float
    var remise : Float
    var proprietaire : String?
    var acheteur : String?
    var jeux : [JeuTr]
    
    
    init(id: String?, statut: String, gestionnaire: String, date_transaction: String?, prix_total: Float, frais: Float, remise: Float, proprietaire: String?, acheteur : String?, jeux: [JeuTr]) {
        self.id = id
        self.statut = statut
        self.gestionnaire = gestionnaire
        self.date_transaction = date_transaction
        self.prix_total = prix_total
        self.frais = frais
        self.remise = remise
        self.proprietaire = proprietaire
        self.acheteur = acheteur
        self.jeux = jeux
    }
    
}
