//
//  DepotView.swift
//  LaCaveAJeu
//
//  Created by etud on 21/03/2025.
//

import SwiftUI

struct DepotView: View {
    @StateObject private var viewModelJeux = JeuxViewModel()
    @StateObject  var viewModelVendeur = VendeurlViewModel()
    @StateObject private var viewModelAcheteur = AcheteurViewModel()
    @StateObject private var viewModelTransac = TransactionViewModel()
    @State private  var idVendeur : String = ""
    @State var showCreer = false
    let bleufonce = Color(red: 45/255.0, green: 85/255.0,blue: 166/255.0)
    let bleuclair = Color(red:121/255.0, green :178/255.0,blue: 218/255.0)
    let yellowlight = Color(red : 240/255.0,green: 230/255.0, blue:158/255.0)
    let bluegris = Color(red : 193/255.0, green : 205/255.0, blue: 214/255.0)
    let bleutresclair = Color(red: 216/255.0, green: 239/255.0,blue: 255/255.0)
    
    @State private var vendeur = ""
    @State private var intitule = ""
    @State private var editeur = ""
    @State private var statut = ""
    @State private var prix = ""
    @State private var quantites = ""
    @State private var categories = ""
        
    @State private var panier: [Game] = []
    var body: some View {
        ZStack{
            bleufonce.ignoresSafeArea()
            VStack{
                Spacer().frame(height: 80);
                HStack{
                    Spacer()
                    Text("🎲")
                        .font(.system(size:40))
                        .padding(.trailing, 30.0)
                    
                }
                HStack{
                    Spacer()
                    Text("Faire un dépot")
                        .font(.jomhuriaBigger())
                        .foregroundColor(bleuclair)
                    Spacer()
                }
                Spacer().frame(height: 10);
                VStack{
                    ScrollView{
                        HStack{
                            Text("Selectionner un vendeur : ")
                                .font(.system(size:20))
                                .bold()
                                .foregroundColor(bleufonce)
                                .padding(.leading, 20)
                                .padding(.top, 20)
                            Spacer()
                        }
                        Picker("vendeur",selection: $idVendeur) {
                            Text("Sans selection").tag("")
                            ForEach(viewModelVendeur.vendeurs) { vendeur in
                                if let idvendeur = vendeur.id {
                                    Text("\(vendeur.nom) \(vendeur.prenom) ")
                                    .tag("\(idvendeur)" as String)}
                            }
                            
                        }
                        .pickerStyle(MenuPickerStyle())
                        .background(bleutresclair)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(bleufonce, lineWidth: 1)
                        )
                        HStack{
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    showCreer.toggle()
                                }
                            })
                            {
                                Text(showCreer ? "cacher" : "Creer un nouveau vendeur")
                                    .font(.system(size:14))
                                    .font(.title)
                                    .foregroundStyle(bleufonce)
                                    .underline()
                                    .padding(.trailing, 25)
                                    .padding(.top, 5)

                            }}
                        if showCreer {
                            creerVendeurView(viewModel : viewModelVendeur)
                        }
                        
                        HStack{
                            Text("Ajouter des jeux : ")
                                .font(.system(size:20))
                                .bold()
                                .foregroundColor(bleufonce)
                                .padding(.leading, 20)
                                .padding(.top, 20)
                            Spacer()
                        }
                        VStack {
                            TextField("Intitulé", text: $intitule)
                                .padding(.leading)
                                .padding(.vertical, 5)
                                .background(.white)
                                .foregroundColor(bleufonce)
                                .cornerRadius(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(bleufonce, lineWidth: 1) // Ajoute une bordure bleue
                                )
                                .padding([.top, .leading], 10)
                                .padding(.trailing)
                                
                            TextField("Éditeur", text: $editeur)
                                .padding(.leading)
                                .padding(.vertical, 5)
                                .background(.white)
                                .foregroundColor(bleufonce)
                                .cornerRadius(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(bleufonce, lineWidth: 1) // Ajoute une bordure bleue
                                )
                                .padding([.top, .leading], 10)
                                .padding(.trailing)
                                
                            TextField("Prix", text: $prix).padding(.leading)
                                .padding(.vertical, 5)
                                .background(.white)
                                .foregroundColor(bleufonce)
                                .cornerRadius(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(bleufonce, lineWidth: 1) // Ajoute une bordure bleue
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
                                        .stroke(bleufonce, lineWidth: 1) // Ajoute une bordure bleue
                                )
                                .padding([.top, .leading], 10)
                                .padding(.trailing)
//                            TextField("Catégories (séparées par des virgules)", text: $categories)
                                            
                              Button("Ajouter au dépôt") {
                                  ajouterAuDepot()}
                              
                              .foregroundColor(bleufonce)
                              .padding()
                              .background(bleutresclair)
                              .cornerRadius(10)
                              .overlay(
                                  RoundedRectangle(cornerRadius: 10)
                                      .stroke(bleufonce, lineWidth: 1) // Ajoute une bordure bleue
                              )
                              .padding(10)
                              
                        }.padding(.vertical, 10)
                        .background(bluegris)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            
                        List(panier) { jeu in
                        VStack(alignment: .leading) {
                            Text(jeu.intitule).font(.headline)
                            Text("Éditeur: \(jeu.editeur)").font(.subheadline)
                            Text("Prix: \(jeu.prix, specifier: "\"%.2f\"") €")
                            Text("Quantité: \(jeu.quantites)")
                              }
                        }.navigationTitle("Dépôt de jeux")
                        
                    }
                }.frame(width: 340, height: 600)
                    .background(yellowlight)
                    .cornerRadius(10)
                    .padding(.horizontal, 30.0)
                    
                    .shadow(radius: 6)
                    .onAppear{
                        viewModelVendeur.fetchVendeurs()
                    }
                
                Spacer()
            }
        }
    }
    
    private func ajouterAuDepot() {
            guard let prixDouble = Double(prix), let quantitesInt = Int(quantites) else { return }
            
            let nouveauJeu = Game(id : nil, vendeur: vendeur,intitule: intitule, editeur: editeur,prix: prixDouble, categorie: [], quantite: quantitesInt, statut: "disponible")
            
            panier.append(nouveauJeu)
            
            // Réinitialiser les champs
            vendeur = ""
            intitule = ""
            editeur = ""
            statut = ""
            prix = ""
            quantites = ""
            categories = ""
        }
}

#Preview {
    DepotView()
}
