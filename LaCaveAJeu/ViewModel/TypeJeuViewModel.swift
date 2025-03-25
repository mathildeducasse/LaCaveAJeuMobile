//
//  TypeJeuViewModel.swift
//  LaCaveAJeu
//
//  Created by etud on 24/03/2025.
//

import SwiftUI

class TypeJeuViewModel: ObservableObject {
    @Published var typesJeu: [TypeJeu] = []
    @Published var typeJeuById: [TypeJeu] = []
    private let apiservice = APIService()
    
    func fetchTypeJeu(){
        apiservice.fetchTypeJeux() {[weak self] typegames in
            DispatchQueue.main.async {
                self?.typesJeu = typegames
            }
            
        }
    }
    
    func fetchTypeJeuxById(id : String){
        apiservice.fetchTypeJeuxById(id: id) {[weak self] typegames in
            DispatchQueue.main.async {
                self?.typeJeuById.append(typegames)
            }
            
        }
    }
    
}

