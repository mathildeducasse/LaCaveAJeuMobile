//
//  VentesView.swift
//  LaCaveAJeu
//
//  Created by etud on 21/03/2025.
//

import SwiftUI

struct VentesView: View {
    @StateObject private var viewModel = VenteViewModel()
    @State private var quantiteSelectionnee: [String?: Int] = [:]
    @StateObject private var viewModelJeux = JeuxViewModel()
    @StateObject private var viewModelVentes = VendeurlViewModel()
    let bleuclair = Color(red:121/255.0, green :178/255.0,blue: 218/255.0)
    let yellowlight = Color(red : 240/255.0,green: 230/255.0, blue:158/255.0)
    let bleufonce = Color(red: 45/255.0, green: 85/255.0,blue: 166/255.0)
    let bleutresclair = Color(red: 216/255.0, green: 239/255.0,blue: 255/255.0)
    
    var body: some View {
        VStack{
            Spacer().frame(height: 80);
            HStack{
                Spacer()
                Text("💸")
                    .font(.system(size:40))
                    .padding(.trailing, 30.0)
                
            }
            HStack{
                Spacer()
                Text("Faire une vente")
                    .font(.jomhuriaBigger())
                    .foregroundColor(bleuclair)
                Spacer()
            }
            Spacer().frame(height: 10);
            VStack{
                ScrollView{
                    Spacer().frame(height: 30);
                    ForEach(viewModelJeux.games) { jeu in
                        VStack {
                            HStack{
                                Text("\(jeu.intitule)").font(.headline)
                                    .foregroundColor(bleufonce)
                                Spacer()
                            }.padding(.top, 3)
                                .padding(.leading, 10)
                            HStack{
                                Text("Vendeur : \(jeu.vendeur)").foregroundColor(bleufonce)
                                Spacer()
                            }.padding(.leading, 10)
                            HStack {
                                Text("Stock : \(jeu.quantites)").font(.subheadline).foregroundColor(bleufonce)
                                Text("Prix : \(jeu.prix, specifier: "%.2f")€").font(.subheadline).foregroundColor(bleufonce)
                                Spacer()
                            }.padding(.leading, 10)
                            HStack{
                                Stepper(value: Binding(
                                    
                                    get: { quantiteSelectionnee[jeu.id, default: 1] },
                                    set: { quantiteSelectionnee[jeu.id] = min($0, jeu.quantites) }
                                ), in: 1...jeu.quantites) {
                                    Text("Quantité:   \(quantiteSelectionnee[jeu.id, default: 1])").foregroundColor(bleufonce)
                                }
                                Button("Ajouter") {
                                    viewModel.ajouterAuPanier(jeu: jeu, quantite: quantiteSelectionnee[jeu.id, default: 1])
                                }
                            }.padding(.horizontal, 10)
                            
                        }.background(bleutresclair)
                        .cornerRadius(10)
                        .padding(.horizontal, 25.0)
                        .padding(.vertical, 4)
                    }
                    
                    Text("Panier").font(.title).padding()
                    ForEach(viewModel.panier){ item in
                        HStack {
                            Text("\(item.jeu.intitule) x\(item.quantite)")
                            Spacer()
                            Text("\(Double(item.quantite) * item.jeu.prix, specifier: "%.2f")€")
                                 }
                    }
                     
                }
            }.frame(width: 340, height: 600)
                .background(bleufonce)
                .cornerRadius(10)
                .padding(.horizontal, 30.0)
                .shadow(radius: 6)
                .onAppear {
                    viewModelVentes.fetchVendeurs()
                    viewModelJeux.fetchGame()
                }
        }.background(yellowlight)
            .edgesIgnoringSafeArea(.all)
        
        
        
    }
}

struct VentesView_Previews: PreviewProvider {
    static var previews: some View {
        VentesView()
    }
}
