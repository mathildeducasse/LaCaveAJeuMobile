//
//  StocksView.swift
//  LaCaveAJeu
//
//  Created by etud on 12/03/2025.
//

import SwiftUI

import SwiftUI



struct StocksView: View {
    @State var showFilters = false
    @StateObject private var viewModel = JeuxViewModel()
    @StateObject private var viewModelVend = VendeurlViewModel()
    @State private var proprietaire : String? = nil
    @State private var prix_min : String? = nil
    @State private var prix_max : String? = nil
    @State private var intitule : String? = nil
    @State private var categorie : [String] = []
    @State private var quantites : String? = nil
    @State private var statut : String? = nil
    @State private var editeur : String? = nil
    var body: some View {
        let yellowlight = Color(red: 241/255.0, green: 227/255.0, blue: 129/255.0)
        let redark = Color(red : 149/255.0, green :29/255.0, blue:25/255.0)
        let yellowlight2 = Color(red : 242/255.0, green : 233/255.0,blue:  223/255.0)
        ZStack {
            // Image de fond
            Image("Image")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            ScrollView {
               
                VStack {
                        
                    Spacer().frame(height: 60);
                                
                    // Panneau dynamique
                    VStack() {
                        // Bouton pour afficher/masquer les filtres
                        HStack {
                            Text("Filtres")
                                .font(.jomhuria())
                                .foregroundColor(redark)
                             Spacer()
                             Button(action: {
                                withAnimation {
                                  showFilters.toggle()
                                            }
                                })
                            {
                              Text(showFilters ? "−" : "+")
                               .font(.title)
                               .bold()
                               .foregroundColor(redark)
                                }
                            }
                            .padding()
                            .background(yellowlight2)
                            .cornerRadius(10)

                // Affichage conditionnel des filtres
                if showFilters {
                    FilterView(viewModel : viewModel)
                            }
                Spacer().frame(height: 12);
                // Liste des jeux
                VStack {
                     ForEach($viewModel.games) { $game in
                         JeuxView(jeu : $game)
                    }} }
                    .padding(.horizontal, 20.0)
                    .padding(.vertical, 30)
                    .background(yellowlight)
                    .cornerRadius(20)
                    .onAppear {
                        viewModel.fetchGame()
                        viewModelVend.fetchVendeurs()
                    }
                    
                            }
                .padding()
                .frame(width: 350.0)
                        }
        }.navigationBarBackButtonHidden(true)
    }
}


struct StocksView_Previews: PreviewProvider {
    static var previews: some View {
        StocksView()
    }
}
