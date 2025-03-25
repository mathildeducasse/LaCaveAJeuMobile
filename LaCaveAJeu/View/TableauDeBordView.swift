//
//  TableauDeBordView.swift
//  LaCaveAJeu
//
//  Created by etud on 17/03/2025.
//

import SwiftUI

struct TableauDeBordView: View {
    @State private var navigateToLogin = false
    var body: some View {
        let yellowlight = Color(red : 240/255.0,green: 230/255.0, blue:158/255.0)
        let bluefonce = Color(red : 45/255.0,green: 85/255.0, blue:166/255.0)
        let bleuclair = Color(red:121/255.0, green :178/255.0,blue: 218/255.0)
        NavigationView{
            VStack{
                //image
                Spacer().frame(height: 40);
                Image("tableaudebord")
                    .resizable()
                    .frame(width: 200,height: 140)
                //Le menu
                HStack(spacing:0){
                    VStack(spacing:20){
                        NavigationLink(destination: DepotView()) {
                            VStack{
                                Spacer().frame(height: 40);
                                Text("🎲")
                                    .font(.system(size:40))
                                Spacer().frame(height: 10);
                                Text("Faire un dépot")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10.0)
                                Spacer().frame(height: 10);
                            }
                            .frame(width: 160, height: 140)
                            .background(bluefonce)
                            .cornerRadius(10)}
                        NavigationLink(destination: VendeurView()) {
                            VStack{
                                Spacer().frame(height: 40);
                                Text("🤑")
                                    .font(.system(size:40))
                                Spacer().frame(height: 10);
                                Text("Vendeurs")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10.0)
                                Spacer().frame(height: 10);
                            }
                            .frame(width: 160, height: 140)
                            .background(bluefonce)
                            .cornerRadius(10)}
                        NavigationLink(destination: ContentView()) {
                            VStack{
                                Spacer().frame(height: 40);
                                Text("📋")
                                    .font(.system(size:40))
                                Spacer().frame(height: 10);
                                Text("Bilan")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10.0)
                                Spacer().frame(height: 10);
                            }
                            .frame(width: 160, height: 140)
                            .background(bluefonce)
                            .cornerRadius(10)}
                    }.padding()
                    VStack(spacing:20){
                        NavigationLink(destination: VentesView()) {
                            VStack{
                                Spacer().frame(height: 40);
                                Text("🛒")
                                    .font(.system(size:40))
                                Spacer().frame(height: 10);
                                Text("Faire une vente")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10.0)
                                Spacer().frame(height: 10);
                            }
                            .frame(width: 160, height: 140)
                            .background(bluefonce)
                            .cornerRadius(10)}
                        NavigationLink(destination: TransactionView()) {
                            VStack{
                                Spacer().frame(height: 40);
                                Text("💸")
                                    .font(.system(size:40))
                                Spacer().frame(height: 10);
                                Text("Transactions")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10.0)
                                Spacer().frame(height: 10);
                            }
                            .frame(width: 160, height: 140)
                            .background(bluefonce)
                            .cornerRadius(10)}
                        NavigationLink(destination: StocksView()) {
                            VStack{
                                Spacer().frame(height: 40);
                                Text("🧩")
                                    .font(.system(size:40))
                                Spacer().frame(height: 10);
                                Text("Stocks")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10.0)
                                Spacer().frame(height: 10);
                            }
                            .frame(width: 160, height: 140)
                            .background(bluefonce)
                            .cornerRadius(10)}
                    }.padding()
                }.padding()
                Spacer()
                //Bouton se deconnecter
                Button(action: {
                    GestionnaireSession.shared.logout { success in
                        if success {
                            // Redirection manuelle vers la page login
                            // Ici on utilise un flag pour NavigationLink
                            navigateToLogin = true
                        }
                    }
                }) {
                    Text("Se déconnecter")
                        .font(.system(size:15))
                        .foregroundColor(.black)
                        .padding(.vertical, 15.0)
                        .padding(.horizontal, 25.0)
                        .background(bleuclair)
                        .cornerRadius(10)
                }

                NavigationLink(destination: ContentView(), isActive: $navigateToLogin) {
                    EmptyView()
                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(yellowlight)
            
            
        }.navigationBarBackButtonHidden(true)
    }
}

struct TableauDeBordView_Previews: PreviewProvider {
    static var previews: some View {
        TableauDeBordView()
    }
}
