//
//  VendeurIViewModel.swift
//  LaCaveAJeu
//
//  Created by etud on 17/03/2025.
//

import SwiftUI

class VendeurlViewModel : ObservableObject {
    @Published var vendeurs : [Vendeur] = []
    private let apiservice = APIService()
    
    func fetchVendeurs(){
        apiservice.fetchVendeurs() {[weak self] vendeurs in
            DispatchQueue.main.async {
                self?.vendeurs = vendeurs
            }
            
        }
    }
    
    func addVendeurs(_ vendeur : Vendeur){
        apiservice.addVendeur(vendeur)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.fetchVendeurs()
                }
    }
    
    func resetSolde(id : String){
        apiservice.resetSolde(id)
    }
    
    func deleteVendeur(id : String){
        apiservice.deleteVendeur(id)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.fetchVendeurs()  // Rafraîchir la liste après suppression
            }
    }
    
}


