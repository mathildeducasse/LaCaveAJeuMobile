//
//  TransactionViewModel.swift
//  LaCaveAJeu
//
//  Created by etud on 20/03/2025.
//

import SwiftUI

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    private let apiservice = ServiceTransaction()
    
    
    func fetchTransaction(){
        apiservice.fetchTransactions() {[weak self] transactions in
            DispatchQueue.main.async {
                self?.transactions = transactions
            }
            
        }
    }
    
    func addTransaction(_ transaction : Transaction){
        apiservice.addTransaction(transaction)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.fetchTransaction()
                }
    }
    
    func addDepot(_ depot : Depot){
        apiservice.addDepot(depot)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.fetchTransaction()
                }
    }
    
    func filterItems(gestionnaire : String?, acheteur : String? ,proprietaire: String?, prix_min: String?, prix_max: String?, remise : Float?, nameJeu: String?, statut: String?) {
        apiservice.fetchFilteredTransaction(gestionnaire : gestionnaire, acheteur : acheteur ,proprietaire: proprietaire, prix_min: prix_min, prix_max: prix_max, remise : remise, nameJeu: nameJeu, statut: statut) { [weak self] transactions in
               DispatchQueue.main.async {
                   self?.transactions = transactions
               }
           }
       }
    
}
