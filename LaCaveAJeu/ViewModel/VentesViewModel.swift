//
//  VentesViewModel.swift
//  LaCaveAJeu
//
//  Created by etud on 21/03/2025.
//

import SwiftUI

struct PanierItem: Identifiable {
    let id = UUID()
    let jeu: Game
    var quantite: Int
}

class VenteViewModel: ObservableObject {
    @Published var panier: [PanierItem] = []
    private let apiservice = APIService()
    
    func ajouterAuPanier(jeu: Game, quantite: Int) {
        if let index = panier.firstIndex(where: { $0.jeu.id == jeu.id }) {
            if panier[index].quantite + quantite <= jeu.quantites {
                panier[index].quantite += quantite
            }
        } else {
            if quantite <= jeu.quantites {
                panier.append(PanierItem(jeu: jeu, quantite: quantite))
            }
        }
    }
    
    func getPrixPanier() -> Float {
        var prixTotal: Float = 0.0
        for item in panier {
            prixTotal = prixTotal + Float(item.jeu.prix) * Float(item.quantite)
        }
        return prixTotal
    }
}
