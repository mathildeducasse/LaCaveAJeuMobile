//
//  DepotView.swift
//  LaCaveAJeu
//
//  Created by etud on 21/03/2025.
//

import SwiftUI

struct DepotView: View {
    //@StateObject private var viewModelJeux = JeuxViewModel()
    @StateObject private var viewModelDepot = DepotViewModel()
    @StateObject private var viewModelVendeur = VendeurlViewModel()
    @StateObject private var viewModelTransac = TransactionViewModel()
    @StateObject private var viewModelTJ = TypeJeuViewModel()
    
    @State var showCreer = false
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
                            ForEach(viewModelDepot.panier){ item in
                                   //getTypeJeubyID
                                
                                let intitule = loadIntitule(id: item.typeJeu.typeJeuId)
                                let prixform = String(format: "%.2f", item.typeJeu.prix)
                                Text(" \(intitule) \(prixform)")
                               }
                                                    
                            }.background(bleutresclair)
                            .cornerRadius(10)
                            .padding(.horizontal, 25.0)
                        
                        
                        
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
    
    func loadIntitule(id : String)  -> String{
        i = i + 1
        viewModelTJ.fetchTypeJeuxById(id: id)
        return viewModelTJ.typeJeuById[i].intitule
    }
}


#Preview {
    DepotView()
}
