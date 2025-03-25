//
//  StcokViewModel.swift
//  LaCaveAJeu
//
//  Created by etud on 22/03/2025.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let typeJeu: JeuTp
}

class DepotViewModel : ObservableObject {
    @Published var panier: [Item] = []
    private let apiservice = ServiceTransaction()
    
    func ajouterItem(_ item: Item) {
            DispatchQueue.main.async {
                self.panier.append(item)
            }
        
        }
    
}

