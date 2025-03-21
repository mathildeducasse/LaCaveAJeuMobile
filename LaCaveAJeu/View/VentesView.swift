//
//  VentesView.swift
//  LaCaveAJeu
//
//  Created by etud on 21/03/2025.
//

import SwiftUI

struct VentesView: View {
    @StateObject private var viewModelJeux = JeuxViewModel()
    @StateObject private var viewModelVentes = VendeurlViewModel()
    let bleuclair = Color(red:121/255.0, green :178/255.0,blue: 218/255.0)
    let yellowlight = Color(red : 240/255.0,green: 230/255.0, blue:158/255.0)
    let bleufonce = Color(red: 45/255.0, green: 85/255.0,blue: 166/255.0)
    let bleutresclair = Color(red: 216/255.0, green: 239/255.0,blue: 255/255.0)
    
    var body: some View {
        VStack{
            Spacer().frame(height: 80);
            HStack{
                Spacer()
                Text("💸")
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
                    
                }
            }.frame(width: 340, height: 600)
                .background(bleufonce)
                .cornerRadius(10)
                .padding(.horizontal, 30.0)
                .shadow(radius: 6)
                .onAppear {
                    viewModelVentes.fetchVendeurs()
                }
        }.background(yellowlight)
            .edgesIgnoringSafeArea(.all)
        
        
    }
}

struct VentesView_Previews: PreviewProvider {
    static var previews: some View {
        VentesView()
    }
}
