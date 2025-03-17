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
    
}


