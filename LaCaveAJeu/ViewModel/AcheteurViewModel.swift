//
//  AcheteurViewModel.swift
//  LaCaveAJeu
//
//  Created by etud on 21/03/2025.
//

import SwiftUI

class AcheteurViewModel : ObservableObject {
    @Published var acheteurs : [Acheteur] = []
    private let apiservice = AcheteurService()
    
    func fetchAcheteurs(){
        apiservice.fetchAcheteurs() {[weak self] acheteur in
            DispatchQueue.main.async {
                self?.acheteurs = acheteur
            }
            
        }
    }
    
    func addAcheteur(_ acheteur : Acheteur){
        apiservice.addAcheteur(acheteur)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.fetchAcheteurs()
                }
    }
    
    
}
