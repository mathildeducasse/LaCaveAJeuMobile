//
//  TransactionsView.swift
//  LaCaveAJeu
//
//  Created by etud on 20/03/2025.
//

import SwiftUI

struct TransactionsView: View {
    @Binding var transaction: Transaction
    let blueclair = Color(red : 121/255.0, green : 178/255.0, blue: 218/255.0)
    let bluee = Color(red : 45/255.0, green : 85/255.0, blue: 166/255.0)
    let bluegris = Color(red : 193/255.0, green : 205/255.0, blue: 214/255.0)
    var body: some View {
        HStack {
            let formattedPrix = String(format: "%.1f", transaction.prix_total)
            VStack(alignment: .leading) {
                
                
                    Text("\(smyletStatut())")
                        .font(.title2)
                    .foregroundColor(bluee)
                if (transaction.acheteur == nil){
                    if let prop = transaction.proprietaire {
                        Text("\(prop) - \(transaction.jeux.count) jeu(x)").font(.subheadline)
                            .foregroundColor(bluee)
                    }
                }
                else if let acheteur = transaction.acheteur{
                    
                    if let prop = transaction.jeux[0].vendeur {
                        Text("\(prop)\(multipleVendeurs()) —>  \(acheteur)")
                            .font(.subheadline)
                        .foregroundColor(bluee)
                    }
                }
            }
            Spacer()
            Text("\(formattedPrix) €")
                .font(.jomhuriaLittle())
                .bold()
                .foregroundColor(bluee)
        }
        .padding()
        .background(bluegris)
        .cornerRadius(10)
    }
    
    func multipleVendeurs() -> String {
        if transaction.jeux.count > 1 {
            return " et d'autres.."
        }else{
            return ""
        }
    }
    
    func smyletStatut() -> String {
        if transaction.statut == "depot"{
            return "🎲 Dépot"
        }else{
            return "🛒 Vente"
        }
    }
}

//struct TransactionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionsView()
//    }
//}
