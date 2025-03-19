//
//  Session.swift
//  LaCaveAJeu
//
//  Created by etud on 18/03/2025.
//

import Foundation

struct Session : Codable, Identifiable {
    
    var id : String?
    var dateDebut : String
    var dateFin : String
    var fraisDepot : String
    var statutSession : String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"   // Convertit "_id" en "id" pour Swift
        case dateDebut, dateFin, fraisDepot, statutSession
       }
    
    init(){
        self.id = nil
        self.dateDebut = "dateDebut"
        self.dateFin = "dateFin"
        self.fraisDepot = "fraisDepot"
        self.statutSession  = "statutSession"
    }
    
    init(id : String?, dateDebut : String, dateFin : String, fraisDepot : String, statutSession : String){
        self.id = id
        self.dateDebut = dateDebut
        self.dateFin = dateFin
        self.fraisDepot = fraisDepot
        self.statutSession  = statutSession
    }
    
    
    
}
