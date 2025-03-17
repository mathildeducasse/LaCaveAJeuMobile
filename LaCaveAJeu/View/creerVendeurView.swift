//
//  creerVendeurView.swift
//  LaCaveAJeu
//
//  Created by etud on 17/03/2025.
//

import SwiftUI

struct creerVendeurView: View {
    @StateObject private var viewModel = VendeurlViewModel()
    @State private var nom : String = ""
    @State private var prenom : String = ""
    @State private var email : String = ""
    @State private var telephone : String = ""
    
    var body: some View {
        let bleuclair = Color(red:121/255.0, green :178/255.0,blue: 218/255.0)
        let blueweird = Color(red : 121/255.0,green: 178/255.0, blue:218/255.0)
        let bleufonce = Color(red: 45/255.0, green: 85/255.0,blue: 166/255.0)
        let bleutresclair = Color(red: 216/255.0, green: 239/255.0,blue: 255/255.0)
        VStack{
            Text("Créer")
                .font(.jomhuriaBigger())
                .foregroundColor(bleufonce)
            HStack{
                Text("Nom").foregroundColor(bleufonce)
                Spacer()
            }
            TextField("", text: $nom)
                .frame(width : 250, height : 30)
                .background(.white)
                .cornerRadius(7)
            HStack{
                Text("Prenom").foregroundColor(bleufonce)
                Spacer()
            }
            TextField("", text: $prenom)
                .frame(width : 250, height : 30)
                .background(.white)
                .cornerRadius(7)
            HStack{
                Text("Email").foregroundColor(bleufonce)
                Spacer()
            }
            TextField("", text: $email)
                .frame(width : 250, height : 30)
                .background(.white)
                .cornerRadius(7)
            HStack{
                Text("Téléphone").foregroundColor(bleufonce)
                Spacer()
            }
            TextField("", text: $telephone)
                .frame(width : 250, height : 30)
                .background(.white)
                .cornerRadius(7)
            
            Button(action: handleCreate){
                Text("Créer")
                    .padding(.vertical, 10.0)
                    .padding(.horizontal, 40.0)
                    .foregroundColor(bleufonce)
                    .bold()
            }.background(blueweird)
            .cornerRadius(10)
            .padding(.top)
            
            
            
        }.padding(.horizontal, 17.0)
            .frame(width:280,height: 450)
                .background(bleutresclair)
                .cornerRadius(10)
    }
    
    func handleCreate(){
        let vendeur : Vendeur = Vendeur(id:nil, nom: nom, prenom : prenom, email : email, telephone : telephone, soldes : 0.0)
        viewModel.addVendeurs(vendeur)
        nom = ""
        prenom = ""
        email = ""
        telephone = ""
    }
}
    struct creerVendeurView_Previews: PreviewProvider {
        static var previews: some View {
            creerVendeurView()
        }
    }

