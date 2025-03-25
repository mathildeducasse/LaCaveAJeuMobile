//
//  FilterView.swift
//  LaCaveAJeu
//
//  Created by etud on 19/03/2025.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject var viewModel: JeuxViewModel
    @StateObject private var viewModelVend = VendeurlViewModel()
    @State private var proprietaire : String? = nil
    @State private var prix_min : String? = nil
    @State private var prix_max : String? = nil
    @State private var intitule : String? = nil
    @State private var categories : [String] = []
    @State private var quantites : String? = nil
    @State private var statut : String? = nil
    @State private var editeur : String? = nil
    @State private var showcate : Bool = false
    var body: some View {
        
        let redark = Color(red : 149/255.0, green :29/255.0, blue:25/255.0)
        let yellowlight2 = Color(red : 242/255.0, green : 233/255.0,blue:  223/255.0)
        VStack {
            ScrollView {
                Picker("Statut", selection: $statut) {
                    Text("---Statuts---").tag(nil as String?)
                    Text("pas disponible").tag("pas disponible" as String?)
                    Text("disponible").tag("disponible" as String?)
                    Text("vendu").tag("vendu" as String?)
                }.pickerStyle(WheelPickerStyle())
                
                HStack{
                    Text("Vendeur")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(redark)
                    Picker("proprietaire",selection: $proprietaire) {
                        Text("Sans selection").tag(nil as String?)
                        ForEach(viewModelVend.vendeurs) { vendeur in
                            Text("\(vendeur.nom) \(vendeur.prenom)").tag("\(vendeur.id)")
                        }
                        
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Spacer()
                }
                
                HStack{
                    Text("Editeur :")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(redark)
                    Picker("editeur",selection: $editeur) {
                        Text("Sans selection").tag(nil as String?)
                        ForEach(viewModel.games) { game in
                            Text("\(game.editeur)").tag("\(game.editeur)")
                        }
                        
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Spacer()
                }
                
                
                HStack{
                    Text("Prix min:")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(redark)
                    TextField("Min", text: Binding(
                        get: { prix_min ?? "" },  // Si prix_min est nil, on affiche ""
                        set: { prix_min = $0.isEmpty ? nil : $0 }  // Si l’utilisateur vide le champ, on met nil
                    ))
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    Text("€ ")
                        .foregroundColor(redark)
                    Text("Prix max:").font(.subheadline)
                        .bold()
                        .foregroundColor(redark)
                    TextField("Max", text: Binding(
                        get: { prix_max ?? "" },  // Si prix_min est nil, on affiche ""
                        set: { prix_max = $0.isEmpty ? nil : $0 }  // Si l’utilisateur vide le champ, on met nil
                    ))
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    Text("€ ")
                        .foregroundColor(redark)
                }
                
                HStack{
                    Text("Intutilé : ")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(redark)
                    Picker("intulé",selection: $intitule) {
                        Text("Sans selection").tag(nil as String?)
                        
                        ForEach(viewModel.games) { game in
                            Text("\(game.intitule)")
                        }
                        
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Spacer()
                }
                
                
                VStack {
                    HStack {
                        Text("Catégorie")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(redark)
                         
                         Button(action: {
                            withAnimation {
                              showcate.toggle()
                                        }
                            }){
                          Text(showcate ? "−" : "+")
                           .font(.title)
                           .bold()
                           .foregroundColor(redark)
                            }
                        Spacer()
                        }
                    if showcate {
                        ForEach(viewModel.categories) { categorie in
                            Button(action: {
                                if let index = categories.firstIndex(of: categorie.name) {
                                    categories.remove(at: index)
                                } else {
                                    categories.append(categorie.name)
                                }
                            }) {
                                HStack {
                                    Text("\(categorie.name)")
                                    Spacer()
                                    if categories.contains(categorie.name) {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.blue)
                                    } else {
                                        Image(systemName: "circle")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding()
                            }
                        }}
                }
                
                
                HStack{
                    Text("Quantité:")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(redark)
                    TextField("...", text: Binding(
                        get: { quantites ?? "" },  // Si prix_min est nil, on affiche ""
                        set: { quantites = $0.isEmpty ? nil : $0 }  // Si l’utilisateur vide le champ, on met nil
                    )).frame(width:60, height: 20)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    Spacer()
                }
                Button(action: handleFiltre){
                    Text("Appliquer ")
                        .padding(.vertical, 10.0)
                        .padding(.horizontal, 20.0)
                        .foregroundColor(yellowlight2)
                        .bold()
                }.background(redark)
                    .cornerRadius(10)
                    .padding(.top)
                
            }
            
        }.frame(width : 250, height: 500)
        .transition(.move(edge: .top).combined(with: .opacity))
            .padding(.horizontal)
            .background(yellowlight2)
            .cornerRadius(10)
            .onAppear {
                viewModel.fetchGame()
                viewModelVend.fetchVendeurs()
                viewModel.getCategories()
            }
    }
    
    
    func handleFiltre(){
        guard let quantite  = Int(quantites ?? "") else { return }
        viewModel.filterItems(proprietaire: proprietaire, prix_min: prix_min, prix_max: prix_max, categorie: categories, intitule: intitule, statut: statut, editeur: editeur, quantites: quantite){
            viewModel.fetchGame()
        }
    }
}

//struct FilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterView()
//    }
//}
