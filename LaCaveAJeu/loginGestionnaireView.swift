//
//  loginGestionnaire.swift
//  LaCaveAJeu
//
//  Created by etud on 12/03/2025.
//

import SwiftUI

struct loginGestionnaireView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        let prettyBlue = Color(red:45/255.0, green: 85/255.0, blue :166/255.0)
        let bluelight2 = Color(red : 121/255.0, green : 178/255.0, blue: 218/255.0)
        var yellowlight = Color(red: 241/255.0, green: 227/255.0, blue: 129/255.0)
        let redark = Color(red : 149/255.0, green :29/255.0, blue:25/255.0)
        NavigationView(){
            ZStack{
                VStack {
//                    // Bouton retour
//                    HStack {
//                        Button(action: {
//                            // Action pour revenir en arrière
//                        }) {
//                            Image(systemName: "arrow.left")
//                                .foregroundColor(.white)
//                                .padding()
//                                .background(Color.blue)
//                                .clipShape(Circle())
//                        }
//                        .padding(.leading)
//                        Spacer()
//                    }
//                    .padding(.top, 20)
                    Spacer()
                    Spacer()
                    
                    // Carte de connexion
                    VStack(spacing: 0) {
                        Text("Login")
                            .font(.jomhuriaBig())
                            .fontWeight(.bold)
                            .foregroundColor(yellowlight)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("pseudo")
                                .font(.jomhuriaLittle())
                                .foregroundColor(yellowlight)
                            TextField("pseudo", text: $username)
                                .padding()
                                .background(bluelight2)
                                .cornerRadius(10)
                                .foregroundColor(redark)
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("mot de passe")
                                .font(.jomhuriaLittle())
                                .foregroundColor(yellowlight)
                            SecureField("**********", text: $password)
                                .padding()
                                .background(bluelight2)
                                .cornerRadius(10)
                                .foregroundColor(redark)
                        }
                        Spacer().frame(height: 40);                           Button(action: {
                                // Action pour la connexion
                            }) {
                                Text("se connecter")
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue.opacity(0.5))
                                    .cornerRadius(10)
                            }
                    }
                    .padding()
                    .background(prettyBlue)
                    .cornerRadius(20)
                    .padding(.horizontal, 40)
                    
                    Spacer()
                    
                    // Logo en bas
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                        .padding(.bottom, 20)
                }
            }.background(Image("Image")
                .resizable()
                .ignoresSafeArea(.all)
            )
        }
    }
}

struct loginGestionnaire_Previews: PreviewProvider {
    static var previews: some View {
        loginGestionnaireView()
    }
}
