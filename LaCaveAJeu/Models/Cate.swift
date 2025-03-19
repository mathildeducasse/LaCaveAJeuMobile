//
//  Categorie.swift
//  LaCaveAJeu
//
//  Created by etud on 19/03/2025.
//

import Foundation

struct Cate : Codable, Identifiable {
    
    var id : String?
    var name : String
    var createdAt : String?
    var updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt , updatedAt
       }
    
    init(name : String){
        self.id = nil
        self.name = name
        self.createdAt = nil
        self.updatedAt = nil
    }
}
