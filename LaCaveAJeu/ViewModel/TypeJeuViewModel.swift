//
//  TypeJeuViewModel.swift
//  LaCaveAJeu
//
//  Created by etud on 24/03/2025.
//

import SwiftUI

class TypeJeuViewModel: ObservableObject {
    @Published var typesJeu: [TypeJeu] = []
    //@Published var typeJeuById: [TypeJeu] = []
    private let apiservice = APIService()
    @Published var typeJeuById: [String: TypeJeu] = [:]
    @Published var intitulesCache: [String: String] = [:] // Stocker les intitulés des jeux

        func fetchIntitule(for id: String) {
            if intitulesCache[id] == nil {
                fetchTypeJeuxById(id: id) { typeJeu in
                    DispatchQueue.main.async {
                        self.intitulesCache[id] = typeJeu?.intitule ?? "Inconnu"
                        self.objectWillChange.send()
                    }
                }
            }
        }
    func fetchTypeJeu(){
        apiservice.fetchTypeJeux() {[weak self] typegames in
            DispatchQueue.main.async {
                self?.typesJeu = typegames
            }
            
        }
    }
    
    
    func fetchTypeJeuxById(id: String, completion: @escaping (TypeJeu?) -> Void) {
                // Simuler un appel réseau asynchrone
                DispatchQueue.global().async {
                    let typeJeu = self.typeJeuById[id] // Simuler un retour depuis une API
                    DispatchQueue.main.async {
                        completion(typeJeu)
                    }
                }
            }
    
    
}

