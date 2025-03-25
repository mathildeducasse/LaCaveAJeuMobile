//
//  AjoutJeuDepotView.swift
//  LaCaveAJeu
//
//  Created by etud on 24/03/2025.
//

import SwiftUI

struct AjoutJeuDepotView: View {
    @ObservedObject var viewModelTJ : TypeJeuViewModel
    @Binding var panier : [Item]
    let idVendeur : String
    @State private var idTypeJeu = ""
    @State private var prix = ""
    @State private var quantites = ""
    
    let bleufonce = Color(red: 45/255.0, green: 85/255.0,blue: 166/255.0)
    let bluegris = Color(red : 193/255.0, green : 205/255.0, blue: 214/255.0)
    let bleutresclair = Color(red: 216/255.0, green: 239/255.0,blue: 255/255.0)
    var body: some View {
        VStack {
            HStack{
                Text("Selectionner un jeu : ")
                    .font(.system(size:17))
                    .foregroundColor(bleufonce)
                    .padding(.leading, 20)
                    
                Spacer()
            }
            Picker("typeJeu",selection: $idTypeJeu) {
                Text("Sans selection").tag("")
                ForEach(viewModelTJ.typesJeu) { tj in
                    if let idTj = tj.id {
                        Text("\(tj.intitule) ")
                        .tag("\(idTj)" as String)}
                }
            }
            .pickerStyle(MenuPickerStyle())
            .tint(bleufonce)
                
            TextField("Prix", text: $prix).padding(.leading)
                .padding(.vertical, 5)
                .background(.white)
                .foregroundColor(bleufonce)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(bleufonce, lineWidth: 1)
                )
                .padding([.top, .leading], 10)
                .padding(.trailing)
            TextField("Quantité", text: $quantites).padding(.leading)
                .padding(.vertical, 5)
                .background(.white)
                .foregroundColor(bleufonce)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(bleufonce, lineWidth: 1)
                )
                .padding([.top, .leading], 10)
                .padding(.trailing)
                            
              Button("Ajouter au dépôt") {
                  ajouterAuDepot()}
              
              .foregroundColor(bleufonce)
              .padding()
              .background(bleutresclair)
              .cornerRadius(10)
              .overlay(
                  RoundedRectangle(cornerRadius: 10)
                      .stroke(bleufonce, lineWidth: 1)
              )
              .padding(10)
              
        }.padding(.vertical, 10)
        .background(bluegris)
            .cornerRadius(10)
            .padding(.horizontal, 20)
            .onAppear{
                viewModelTJ.fetchTypeJeu()
            }
    }
    
    
    private func ajouterAuDepot() {
            guard let prixDouble = Double(prix), let quantitesInt = Int(quantites) else { return }
          //  guard let idVend = idVendeur else { return }
            let nouveauJeu = JeuTp(proprietaire: idVendeur, typejeu: idTypeJeu, prix: prixDouble, statut: "disponible", quantites: quantitesInt)
        
            let item = Item(typeJeu: nouveauJeu)
            panier.append(item)
            
            idTypeJeu = ""
            prix = ""
            quantites = ""

        }
}


