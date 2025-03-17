//
//  VendeurView.swift
//  LaCaveAJeu
//
//  Created by etud on 16/03/2025.
//

import SwiftUI

struct VendeurView: View {
    @StateObject private var viewModel = VendeurlViewModel()
    @State private var showAdd = false
    @State private var showDetails = false
    var body: some View {
        let bleuclair = Color(red:121/255.0, green :178/255.0,blue: 218/255.0)
        let yellowlight = Color(red : 240/255.0,green: 230/255.0, blue:158/255.0)
        let bleufonce = Color(red: 45/255.0, green: 85/255.0,blue: 166/255.0)
        let bleutresclair = Color(red: 216/255.0, green: 239/255.0,blue: 255/255.0)
        
        NavigationView{
            VStack{
                
                HStack{
                    Spacer()
                    Text("🤑")
                        .font(.system(size:40))
                        .padding(.trailing, 30.0)
                    
                }
                HStack{
                    Spacer()
                    Text("Vendeurs")
                        .font(.jomhuriaBigger())
                        .foregroundColor(bleuclair)
                    Spacer()
                }
                Spacer().frame(height: 10);
                //Carte de vendeurs
                VStack {
                    ScrollView {
                        //Bouton pour ajouter
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    showAdd.toggle()
                                }
                            })
                            {VStack{
                                Text(showAdd ? "−" : "+")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.blue)
                                    .padding(10)
                                    .frame(width:60, height:60)
                            }
                            .background(bleutresclair)
                            .cornerRadius(10)
                                
                            }.padding(10)
                                .padding([.top, .trailing], 10.0)
                        }
                        if showAdd {
                            creerVendeurView()
                        }
                        ForEach($viewModel.vendeurs) { $vendeur in
                            NavigationLink(destination: VendeurdetailView(vendeur : $vendeur)){
                                VStack() {
                                    HStack{
                                        Text(vendeur.nom)
                                            .font(.system(size:24))
                                            .foregroundColor(bleufonce)
                                        Spacer()
                                    }
                                    .padding(.leading)
                                    HStack{
                                        Text("----------")
                                            .font(.system(size:24))
                                            .foregroundColor(bleuclair)
                                        Spacer()
                                        let formattedSolde = String(format: "%.1f", vendeur.soldes)
                                        Text("Solde : " + formattedSolde + " €")
                                            .padding(.trailing, 13.0)
                                            .foregroundColor(bleufonce)
                                    }.padding(.leading)
                                }.frame(width:300,height: 70)
                                    .background(bleutresclair)
                                    .cornerRadius(10)
                                    .padding()
                            }}
                        
                        Spacer()
                    }.frame(width: 340, height: 600)
                        .background(bleufonce)
                        .cornerRadius(10)
                        .padding(.horizontal, 30.0)
                        .shadow(radius: 6)
                        .onAppear {
                            viewModel.fetchVendeurs()
                        }
                }
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(yellowlight)
            
            
        }
    }
    
}

struct VendeurView_Previews: PreviewProvider {
    static var previews: some View {
        VendeurView()
    }
}
