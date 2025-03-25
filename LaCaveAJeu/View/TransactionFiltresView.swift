//
//  TransactionFiltresView.swift
//  LaCaveAJeu
//
//  Created by etud on 20/03/2025.
//

import SwiftUI

struct TransactionFiltresView: View {
    @ObservedObject var viewModel: TransactionViewModel
    @StateObject private var viewModelJeu = JeuxViewModel()
    @StateObject private var viewModelVend = VendeurlViewModel()
    @StateObject private var viewModelAch = AcheteurViewModel()
    @State var gestionnaire : String? = nil
    @State var acheteur : String?
    @State var proprietaire: String?
    @State var prix_min: String?
    @State var prix_max: String?
    @State var remise : Float? = nil
    @State var nameJeu: String?
    @State var statut: String?
    let bluee = Color(red : 45/255.0, green : 85/255.0, blue: 166/255.0)
    let yelloww = Color(red : 240/255.0, green : 230/255.0, blue: 158/255.0)
    let bluegris = Color(red : 193/255.0, green : 205/255.0, blue: 214/255.0)
    var body: some View {
        VStack{
            ScrollView {
               
                
                Picker("Statut", selection: $statut) {
                    Text("---Statuts---").tag(nil as String?)
                    Text("depot").tag("depot" as String?)
                    Text("vente").tag("vente" as String?)
                }.pickerStyle(WheelPickerStyle())
                
                HStack{
                    Text("Vendeur")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(bluee)
                    Picker("proprietaire",selection: $proprietaire) {
                        Text("Sans selection").tag(nil as String?)
                        ForEach(viewModelVend.vendeurs) { vendeur in
                            Text("\(vendeur.nom) \(vendeur.prenom)").tag(vendeur.id ?? "")
                        }
                        
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Spacer()
                }
                HStack{
                    Text("Acheteur")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(bluee)
                    Picker("acheteur",selection: $acheteur) {
                        Text("Sans selection").tag(nil as String?)
                        ForEach(viewModelAch.acheteurs) { acheteur in
                            Text("\(acheteur.nom) \(acheteur.prenom) ").tag(acheteur.id ?? "")
                        }
                        
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Spacer()
                }
                
                HStack{
                    Text("Jeu concerné :")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(bluee)
                    Picker("nameJeu",selection: $nameJeu) {
                        Text("Sans selection").tag(nil as String?)
                        ForEach(viewModelJeu.games) { game in
                            Text("\(game.intitule)").tag("\(game.intitule)")
                        }
                        
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Spacer()
                }
                
                HStack{
                    Text("Prix min:")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(bluee)
                    TextField("Min", text: Binding(
                        get: { prix_min ?? "" },  // Si prix_min est nil, on affiche ""
                        set: { prix_min = $0.isEmpty ? nil : $0 }  // Si l’utilisateur vide le champ, on met nil
                    ))
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    Text("€ ")
                        .foregroundColor(bluee)
                    Text("Prix max:").font(.subheadline)
                        .bold()
                        .foregroundColor(bluee)
                    TextField("Max", text: Binding(
                        get: { prix_max ?? "" },  // Si prix_min est nil, on affiche ""
                        set: { prix_max = $0.isEmpty ? nil : $0 }  // Si l’utilisateur vide le champ, on met nil
                    ))
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    Text("€ ")
                        .foregroundColor(bluee)
                }
                
                Button(action: handleFiltre){
                    Text("Appliquer ")
                        .padding(.vertical, 10.0)
                        .padding(.horizontal, 20.0)
                        .foregroundColor(yelloww)
                        .bold()
                }.background(bluee)
                    .cornerRadius(10)
                    .padding(.top)
                
            }.transition(.move(edge: .top).combined(with: .opacity))
                .padding(.horizontal)
                .background(bluegris)
                .cornerRadius(10)
                .onAppear {
                    viewModel.fetchTransaction()
                    viewModelAch.fetchAcheteurs()
                    viewModelVend.fetchVendeurs()
                    viewModelJeu.fetchGame()
                }
        }
    }
    
    func handleFiltre(){
        if let prop = proprietaire{
            print("\(prop)")}
        if let statutt = statut{
            print("\(statutt)")}
        viewModel.filterItems(gestionnaire: gestionnaire, acheteur: acheteur, proprietaire: proprietaire, prix_min: prix_min, prix_max: prix_max, remise: remise, nameJeu: nameJeu, statut: statut)
    }
    
}

//struct TransactionFiltresView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionFiltresView()
//    }
//}
