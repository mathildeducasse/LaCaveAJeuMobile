//
//  StocksView.swift
//  LaCaveAJeu
//
//  Created by etud on 12/03/2025.
//

import SwiftUI

import SwiftUI

struct StocksView: View {
    @State private var showFilters = false

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
                                VStack {
                                            FilterSection(title: "Nom du vendeur")
                                            FilterSection(title: "Éditeur")
                                            PriceFilter()
                                            FilterSection(title: "Catégorie")
                                            FilterSection(title: "Statut")
                                            FilterSection(title: "Intitulé")
                                            QuantityFilter()
                                        }
                                        .transition(.move(edge: .top).combined(with: .opacity))
                                        .padding(.horizontal)
                                        .background(yellowlight2)
                                        .cornerRadius(10)
                            }
                            

                                    // Liste des jeux
                                VStack { // ⬅️ Remplace List par VStack pour éviter les conflits dans le ScrollView
                                        GameRow(name: "Jeu de cacarte", seller: "Lisou", quantity: 2, price: 9)
                                        GameRow(name: "Le jeu de la biscotte", seller: "Mathis", quantity: 1, price: 7)
                                        GameRow(name: "Cacache cache", seller: "Aloïs", quantity: 2, price: 12)
                                        GameRow(name: "Mariokakart", seller: "Zolan", quantity: 1, price: 70)
                                        GameRow(name: "My friend love me", seller: "Mathis", quantity: 1, price: 40)
                                        GameRow(name: "My friend love me", seller: "Mathilde", quantity: 3, price: 25)
                                        GameRow(name: "Mariokakart", seller: "Lisou", quantity: 1, price: 65)
                                }
                                }
                    .padding(.horizontal, 20.0)
                    .padding(.vertical, 30)
                    .background(yellowlight)
                    .cornerRadius(20)
                    
                            }
                .padding()
                .frame(width: 350.0)
                        }
        }
    }
}

// Composant pour une ligne de jeu
struct GameRow: View {
    var name: String
    var seller: String
    var quantity: Int
    var price: Int
    let yellowlight = Color(red: 241/255.0, green: 227/255.0, blue: 129/255.0)
    let redark = Color(red : 149/255.0, green :29/255.0, blue:25/255.0)
    let yellowlight2 = Color(red : 242/255.0, green : 233/255.0,blue:  223/255.0)
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.jomhuriaLittle())
                    .foregroundColor(redark)
                Text("\(seller)  —  \(quantity)")
                    .font(.subheadline)
                    .foregroundColor(redark)
            }
            Spacer()
            Text("\(price)€")
                .font(.jomhuriaLittle())
                .bold()
                .foregroundColor(redark)
        }
        .padding()
        .background(yellowlight2)
        .cornerRadius(10)
    }
}

// Composant pour les champs de filtre
struct FilterSection: View {
    let redark = Color(red : 149/255.0, green :29/255.0, blue:25/255.0)
    let yellowlight2 = Color(red : 242/255.0, green : 233/255.0,blue:  223/255.0)
    var title: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .bold()
            Picker(selection: .constant(0), label: Text("Sélectionner")) {
                Text("Option 1").tag(0)
                Text("Option 2").tag(1)
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
}

// Composant pour le filtre de prix
struct PriceFilter: View {
    @State private var minPrice = ""
    @State private var maxPrice = ""

    var body: some View {
        HStack {
            Text("Min")
            TextField("0", text: $minPrice)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 60)
            Text("Max")
            TextField("100", text: $maxPrice)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 60)
        }
    }
}

// Composant pour la quantité
struct QuantityFilter: View {
    @State private var quantity = 1

    var body: some View {
        HStack {
            Text("Quantité")
            Stepper("\(quantity)", value: $quantity, in: 1...10)
        }
    }
}

struct StocksView_Previews: PreviewProvider {
    static var previews: some View {
        StocksView()
    }
}
