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
    @StateObject private var viewModelAcheteur = AcheteurViewModel()
    @StateObject private var viewModelTransac = TransactionViewModel()
    @State private var showAlert = false
    @State private var showAlert2 = false
    @State private var nomAcheteur : String = ""
    @State private var prenomAcheteur : String = ""
    @State private var emailAcheteur : String = ""
    @State private var adresseAcheteur : String = ""
    @State private  var theID : String = ""
    let bleuclair = Color(red:121/255.0, green :178/255.0,blue: 218/255.0)
    let yellowlight = Color(red : 240/255.0,green: 230/255.0, blue:158/255.0)
    let bleufonce = Color(red: 45/255.0, green: 85/255.0,blue: 166/255.0)
    let bleutresclair = Color(red: 216/255.0, green: 239/255.0,blue: 255/255.0)
    
    var body: some View {
        ZStack{
            yellowlight.ignoresSafeArea()
            VStack{
                Spacer().frame(height: 80);
                HStack{
                    Spacer()
                    Text("🛒")
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
                        
                        VStack{
                            HStack{
                                Text("Acheteur :").foregroundColor(bleufonce)
                                Spacer()
                            }.bold()
                                .padding(.top, 10)
                                .padding(.leading, 10)
                            HStack{
                                Text("Nom").foregroundColor(bleufonce)
                                Spacer()
                            }.padding(.top, 5)
                                .padding(.leading, 10)
                            TextField("", text: $nomAcheteur)
                                .background(.white)
                                .cornerRadius(7)
                                .padding(.horizontal, 15)
                                .padding(.trailing, 20)
                            HStack{
                                Text("Prenom").foregroundColor(bleufonce)
                                Spacer()
                            }.padding(.leading, 10)
                            TextField("", text: $prenomAcheteur)
                                .background(.white)
                                .cornerRadius(7)
                                .padding(.horizontal, 15)
                                .padding(.trailing, 20)
                            HStack{
                                Text("Email").foregroundColor(bleufonce)
                                Spacer()
                            }.padding(.leading, 10)
                            TextField("", text: $emailAcheteur)
                                .background(.white)
                                .cornerRadius(7)
                                .padding(.horizontal, 15)
                                .padding(.trailing, 20)
                            HStack{
                                Text("Adresse").foregroundColor(bleufonce)
                                Spacer()
                            }.padding(.leading, 10)
                            TextField("", text: $adresseAcheteur)
                                .background(.white)
                                .cornerRadius(7)
                                .padding(.horizontal, 15)
                                .padding([.bottom, .trailing], 20)
                            
                            Button(action: handleCreate){
                                Text("Créer")
                                    .padding(.vertical, 10.0)
                                    .padding(.horizontal, 40.0)
                                    .foregroundColor(bleufonce)
                                    .bold()
                            }.background(yellowlight)
                                .cornerRadius(10)
                                .padding(.bottom, 15)
                                .alert("Acheteur créée !", isPresented: $showAlert) {
                                    Button("OK", role: .cancel) {} // Bouton pour fermer l'alerte
                                } message: {
                                    Text("Cet acheteur à bien été créé. Vous pouvez maintenant le selectionner.")
                                }
                            
                        }.background(bleutresclair)
                            .cornerRadius(10)
                            .padding(.horizontal, 25.0)
                            .padding(.vertical, 4)
                        VStack{
                            Text("Selectionner un acheteur : ")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(yellowlight)
                            
                            Picker("acheteur",selection: $theID) {
                                Text("Sans selection").tag("")
                                ForEach(viewModelAcheteur.acheteurs) { acheteur in
                                    if let idacheteur = acheteur.id {
                                        Text("\(acheteur.nom) \(acheteur.prenom) ").tag("\(idacheteur)" as String)}
                                }
                                
                            }
                            .pickerStyle(MenuPickerStyle())
                            .tint(yellowlight)
                            Spacer()
                        }
                        VStack{
                            Text("🛒 Panier :").padding()
                                .font(.title3)
                                .foregroundColor(bleufonce)
                            ForEach(viewModel.panier){ item in
                                HStack {
                                    Text("\(item.jeu.intitule) x\(item.quantite)").foregroundColor(bleufonce)
                                    Spacer()
                                    Text("\(Double(item.quantite) * item.jeu.prix, specifier: "%.2f")€").foregroundColor(bleufonce)
                                }.padding()
                            }
                        }.background(bleutresclair)
                            .cornerRadius(10)
                            .padding(.horizontal, 25.0)
                        
                        Button(action: handleDepot){
                            Text("Finaliser la commande")
                                .padding(.vertical, 10.0)
                                .padding(.horizontal, 40.0)
                                .foregroundColor(bleufonce)
                                .bold()
                        }.background(yellowlight)
                            .cornerRadius(10)
                            .padding(.bottom, 15)
                            .alert("Acheteur créée !", isPresented: $showAlert2) {
                                Button("OK", role: .cancel) {} // Bouton pour fermer l'alerte
                            } message: {
                                Text("Cet acheteur à bien été créé. Vous pouvez maintenant le selectionner.")
                            }
                        
                    }
                    
                }.frame(width: 340, height: 600)
                    .background(bleufonce)
                    .cornerRadius(10)
                    .padding(.horizontal, 30.0)
                    .shadow(radius: 6)
                    .onAppear {
                        viewModelVentes.fetchVendeurs()
                        viewModelJeux.filterItems(proprietaire : nil, prix_min : nil , prix_max : nil,categorie :[],intitule : nil ,statut : "disponible" , editeur : nil ,quantites : nil)
                        viewModelAcheteur.fetchAcheteurs()
                    }
                Spacer()
            }.background(yellowlight)
                .edgesIgnoringSafeArea(.all)
            
            
        }.navigationBarBackButtonHidden(true)
    }
    
    func handleCreate(){
        let acheteur : Acheteur = Acheteur(id: nil, nom: nomAcheteur, prenom: prenomAcheteur, email: emailAcheteur, adresse: adresseAcheteur)
        viewModelAcheteur.addAcheteur(acheteur)
        if nomAcheteur != "" && prenomAcheteur != "" && emailAcheteur != "" && adresseAcheteur != ""{
            showAlert = true
        }
        
    }
    
    func handleDepot(){
        let prixTot = viewModel.getPrixPanier()
        print("the id of acheteur ahh : " +  theID)
        var jeuxTr : [JeuTr] = []
        for item in viewModel.panier{
            let jeu : JeuTr = JeuTr(id: item.jeu.id, vendeur: item.jeu.vendeur, intitule: item.jeu.intitule,editeur : item.jeu.editeur, prix_unitaire: item.jeu.prix, categorie: item.jeu.categories, quantite: item.jeu.quantites)
            jeuxTr.append(jeu)
        }
        if let idgestionnaie = GestionnaireSession.shared.gestionnaireID{
            
            let transaction : Transaction = Transaction(id: nil, statut: "depot", gestionnaire: idgestionnaie, date_transaction: nil, prix_total: prixTot, frais: 10, remise: 0, proprietaire: nil, acheteur : theID, jeux: jeuxTr)
                viewModelTransac.addTransaction(transaction)
            showAlert2 = true
            }else{
            print("pas de gestionnaire connecté")
        }}
}

struct VentesView_Previews: PreviewProvider {
    static var previews: some View {
        VentesView()
    }
}
