import SwiftUI

class BilanViewModel: ObservableObject {
    private let apiService = APIService.shared
    private let transactionService = ServiceTransaction.shared
    private let vendeurService = APIService()
    
    @Published var bilan: BilanVendeur?
    
        func fetchBilan(for vendeurId: String) {
            guard !vendeurId.isEmpty else {
                self.bilan = nil
                return
            }
            
            var nbDepots = 0
            var nbVentes = 0
            var fraisTotal = 0.0
            var jeuxVendus = 0
            var jeuxRestants = 0
            var portefeuilleTotal = 0.0

            let group = DispatchGroup()

            vendeurService.fetchVendeurs { vendeurs in
                guard let vendeur = vendeurs.first(where: { $0.id == vendeurId }) else {
                    DispatchQueue.main.async { self.bilan = nil }
                    return
                }

                portefeuilleTotal = vendeur.soldes

                // 1. VENTES
                group.enter()
                self.transactionService.fetchFilteredTransaction(
                    gestionnaire: nil, acheteur: nil, proprietaire: nil,
                    prix_min: nil, prix_max: nil, remise: nil,
                    nameJeu: nil, statut: "vente"
                ) { transactions in
                    for transaction in transactions {
                        var prop = false
                        for jeu in transaction.jeux {
                            if jeu.vendeur == vendeur.nom {
                                prop = true
                                jeuxVendus += jeu.quantite
                            }
                        }
                        if prop {
                            nbVentes += 1
                        }
                    }
                    group.leave()
                }

                // 2. DEPOTS
                group.enter()
                self.transactionService.fetchFilteredTransaction(
                    gestionnaire: nil, acheteur: nil, proprietaire: vendeur.id,
                    prix_min: nil, prix_max: nil, remise: nil,
                    nameJeu: nil, statut: "depot"
                ) { transactions in
                    for transaction in transactions {
                        nbDepots += 1
                        fraisTotal += Double(transaction.frais - transaction.remise)
                    }
                    group.leave()
                }

                // 3. JEUX RESTANTS
                group.enter()
                self.apiService.fetchFilteredGames(
                    proprietaire: vendeur.id,
                    prix_min: nil, prix_max: nil,
                    categorie: [], intitule: nil,
                    statut: "disponible", editeur: nil,
                    quantites: nil
                ) { jeux in
                    jeuxRestants = jeux.reduce(0) { $0 + $1.quantites }
                    group.leave()
                }

                // Quand les 3 appels sont terminés
                group.notify(queue: .main) {
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

   
