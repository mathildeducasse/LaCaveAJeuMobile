//
//  TypeJeu.swift
//  LaCaveAJeu
//
//  Created by etud on 24/03/2025.
//

import Foundation

struct TypeJeu: Codable, Identifiable {
    var id : String?
    var intitule : String
    var editeur : String
    var categories : [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case intitule , editeur, categories
       }
    init(){
        self.id = nil
        self.intitule = "intitule"
        self.editeur = "editeur"
        self.categories = []
    }
    
    init(id : String?, intitule : String, editeur : String, categories :[String] ){
        self.id = id
        self.intitule = intitule
        self.editeur = editeur
        self.categories = categories
    }
    
    
}
