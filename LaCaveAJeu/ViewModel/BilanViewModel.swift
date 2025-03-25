import SwiftUI

class BilanViewModel: ObservableObject {
    private let apiService = APIService.shared
    private let transactionService = ServiceTransaction.shared
    
    @Published var bilan: BilanVendeur?
    
    func fetchBilan(for vendeurId: String) {
        guard !vendeurId.isEmpty else {
            self.bilan = nil
            return
        }
        
        var nbDepots = 0
        var nbVentes = 0
        var portefeuilleTotal = 0.0
        var fraisTotal = 0.0
        var jeuxVendus = 0
        
        transactionService.fetchFilteredTransaction(
            gestionnaire: nil,
            acheteur: nil,
            proprietaire: vendeurId,
            prix_min: nil,
            prix_max: nil,
            remise: nil,
            nameJeu: nil,
            statut: nil
        ) { transactions in
            
            for transac in transactions {
                if transac.statut == "depot" {
                    nbDepots += 1
                    fraisTotal += Double(transac.frais - transac.remise)
                } else if transac.statut == "vente" {
                    nbVentes += 1
                    for jeu in transac.jeux {
                        // On filtre les jeux appartenant à ce vendeur
                        if jeu.vendeur == vendeurId {
                            jeuxVendus += jeu.quantite
                            portefeuilleTotal += Double(jeu.quantite) * jeu.prix_unitaire
                            
                        }
                    }
                }
                
                // Maintenant on récupère les jeux restants
                self.apiService.fetchFilteredGames(
                    proprietaire: vendeurId,
                    prix_min: nil,
                    prix_max: nil,
                    categorie: [],
                    intitule: nil,
                    statut: "disponible",
                    editeur: nil,
                    quantites: nil
                ) { jeux in
                    let jeuxRestants = jeux.reduce(0) { $0 + $1.quantites }
                    
                    DispatchQueue.main.async {
                        self.bilan = BilanVendeur(
                            nbDepots: nbDepots,
                            nbVentes: nbVentes,
                            portefeuilleTotal: portefeuilleTotal,
                            fraisTotal: fraisTotal,
                            jeuxRestants: jeuxRestants,
                            jeuxVendus: jeuxVendus
                        )
                    }
                }
            }
        }
    }
}
