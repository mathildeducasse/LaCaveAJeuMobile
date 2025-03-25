//
//  DepotView.swift
//  LaCaveAJeu
//
//  Created by etud on 21/03/2025.
//

import SwiftUI

struct DepotView: View {
    @StateObject private var viewModelJeux = JeuxViewModel()
    @StateObject private var viewModelDepot = DepotViewModel()
    @StateObject private var viewModelVendeur = VendeurlViewModel()
    @StateObject private var viewModelTransac = TransactionViewModel()
    @StateObject private var viewModelTJ = TypeJeuViewModel()
    
    @State var showCreer = false
    @State var showAlert = false

    let bleufonce = Color(red: 45/255.0, green: 85/255.0,blue: 166/255.0)
    let bleuclair = Color(red:121/255.0, green :178/255.0,blue: 218/255.0)
    let yellowlight = Color(red : 240/255.0,green: 230/255.0, blue:158/255.0)
    let bluegris = Color(red : 193/255.0, green : 205/255.0, blue: 214/255.0)
    let bleutresclair = Color(red: 216/255.0, green: 239/255.0,blue: 255/255.0)
    
    @State private  var idVendeur : String = ""
    @State private var idTypeJeu = ""
    @State private var statut = ""
    @State private var prix = ""
    @State private var quantites = ""
    @State var i : Int = 0
    
    var body: some View {
        ZStack{
            bleufonce.ignoresSafeArea()
            VStack{
                Spacer().frame(height: 30);
                HStack{
                    NavigationLink(destination: ContentView()) {
                        VStack{
                            
                            Text("<-")
                                .font(.system(size:10))
                        }
                        //.frame(width: 160, height: 140)
                        .background(yellowlight)
                        .cornerRadius(10)
                        .padding(.leading, 30.0)
                    }
                    
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
                                    Text("\(vendeur.nom) \(vendeur.prenom) ").tag("\(idvendeur)" as String)}
                            }
                            
                        }.pickerStyle(MenuPickerStyle())
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
                                    .foregroundColor(bleufonce)
                                    .underline()
                                    .padding(.trailing, 25)
                                    .padding(.top, 5)
                                
                            }
                        }
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
                        AjoutJeuDepotView(viewModelTJ: viewModelTJ, panier: $viewModelDepot.panier, idVendeur: idVendeur)
                        
                        
                        
                        VStack{
                            HStack{
                                Spacer()
                                Text("🎲 Jeux à déposer : ").foregroundColor(bleufonce)
                                Spacer()
                            }.padding([.top, .leading, .trailing])
                                .padding(.bottom, 10.0)
                            ForEach(viewModelDepot.panier) { item in
                                let id = item.typeJeu.typeJeuId
                                if let intitule = viewModelTJ.intitulesCache[id] {
                                    //Text(" \(intitule) \(String(format: "%.2f", item.typeJeu.prix)) €")
                                    Text("\(intitule) - \(item.typeJeu.quantites)x à \(String(format: "%.2f", item.typeJeu.prix)) €")
                                } else {
                                    Text("Chargement...")
                                        .onAppear {
                                            viewModelTJ.fetchIntitule(for: id)
                                        }
                                }
                            }
                            }.background(bleutresclair)
                            .cornerRadius(10)
                            .padding(.horizontal, 25.0)
                        
                        
                        
                    }
                    
                    Button(action: handleDepot){
                        Text("Déposer des jeux")
                            .padding(.vertical, 10.0)
                            .padding(.horizontal, 40.0)
                            .foregroundColor(yellowlight)
                            .bold()
                    }.background(bleufonce)
                        .cornerRadius(10)
                        .padding(.bottom, 15)
                        .alert("Dépot réalisé !", isPresented: $showAlert) {
                            Button("OK", role: .cancel) {} // Bouton pour fermer l'alerte
                        } message: {
                            Text("Ce dépot a bien été réalisé, les jeux sont disponible à la vente.")
                        }
                    
                }.frame(width: 340, height: 600)
                    .background(yellowlight)
                    .cornerRadius(10)
                    .padding(.horizontal, 30.0)
                
                    .shadow(radius: 6)
                    .onAppear{
                        viewModelVendeur.fetchVendeurs()
                        viewModelTJ.fetchTypeJeu()
                        
                    }
                
                Spacer()
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    func handleDepot() {
        //let prixTot = viewModelTJ.getPrixPanier()
        //print("the id of acheteur ahh : " +  theID)
        var jeux : [JeuDepot] = []
        var prixTot : Float = 0.0
        for item in viewModelDepot.panier{
            prixTot = prixTot + Float(item.typeJeu.quantites) * Float(item.typeJeu.prix)
            let id = item.typeJeu.typeJeuId
            if let intitule = viewModelTJ.intitulesCache[id] {
                viewModelJeux.addGame(item.typeJeu){
                    viewModelJeux.filterItems(proprietaire : idVendeur, prix_min : nil , prix_max : nil,categorie :[], intitule : intitule ,statut : nil , editeur : nil ,quantites : item.typeJeu.quantites){
                        for i in  viewModelJeux.games{
                            if let id = i.id{
                                let jeu : JeuDepot = JeuDepot( jeuid: id, quantites : item.typeJeu.quantites, prixUnitaire : item.typeJeu.prix)
                                jeux.append(jeu)
                            }
                        }
                        finalizeDepot(jeux : jeux, prixTot : prixTot)
                    }}
            }
        }
        func finalizeDepot(jeux : [JeuDepot], prixTot : Float){
            if let idgestionnaire = GestionnaireSession.shared.gestionnaireID{
                
                let depot : Depot = Depot(gestionnaire: idgestionnaire, proprietaire: idVendeur, prix_total: prixTot, frais: 10, remise: 0, jeux: jeux)
                
                viewModelTransac.addDepot(depot)
                showAlert = true
                }else{
                print("pas de gestionnaire connecté")
            }
            
        }
        }
}


#Preview {
    DepotView()
}
