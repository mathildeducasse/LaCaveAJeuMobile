//
//  VendeurdetailView.swift
//  LaCaveAJeu
//
//  Created by etud on 17/03/2025.
//

import SwiftUI

struct VendeurdetailView: View {
    @Binding var vendeur: Vendeur
    @StateObject private var viewModel = VendeurlViewModel()
    var body: some View {
        let yellowlight = Color(red : 240/255.0,green: 230/255.0, blue:158/255.0)
        let bleufonce = Color(red: 45/255.0, green: 85/255.0,blue: 166/255.0)
        let bleutresclair = Color(red: 216/255.0, green: 239/255.0,blue: 255/255.0)
        let formattedSolde = String(format: "%.1f", vendeur.soldes)
        let redark = Color(red : 149/255.0, green :29/255.0, blue:25/255.0)
        VStack{
            Spacer()
            VStack (alignment: .leading){
                
                Text("\(vendeur.nom) \(vendeur.prenom) ").foregroundColor(bleutresclair)
                    .font(.jomhuriaBig())
                
                Text("\(vendeur.email)").foregroundColor(bleutresclair)
                    .font(.system(size: 20))
                Text("\(vendeur.telephone)").foregroundColor(bleutresclair)
                    .font(.system(size: 20))
                HStack{
                    Text("Solde : ").foregroundColor(bleutresclair)
                    let color = isSoldeok()
                    Text("\(formattedSolde) €").foregroundColor(color)
                        .font(.system(size: 20))
                }
                
            }.frame(width:350,height: 200)
            .background(bleufonce)
            .cornerRadius(10)
            
            Button(action: handleReset){
                Text("Réinitialiser le solde")
                    .padding(.vertical, 10.0)
                    .padding(.horizontal, 40.0)
                    .foregroundColor(bleufonce)
                    .bold()
            }.frame(width:350,height: 50)
            .background(bleutresclair)
            .cornerRadius(10)
            
            Button(action: handleDelete){
                Text("Supprimer le vendeur")
                    .padding(.vertical, 10.0)
                    .padding(.horizontal, 40.0)
                    .foregroundColor(yellowlight)
                    .bold()
            }.frame(width:350,height: 50)
            .background(redark)
            .cornerRadius(10)
            
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(yellowlight)
    }
    
    func handleReset(){
        guard let idd : String = vendeur.id else{return}
        viewModel.resetSolde(id: idd)
        viewModel.fetchVendeurs()
    }
    
    func handleDelete(){
        guard let idd : String = vendeur.id else{return}
        viewModel.deleteVendeur(id: idd)
    }
    
    func isSoldeok() -> Color {
        let yellowlight = Color(red : 240/255.0,green: 230/255.0, blue:158/255.0)
        if vendeur.soldes == 0.0 {
            return yellowlight
        }else if vendeur.soldes > 0.0{
            return Color(.green)
        }else{
            return Color(.red)
        }
    }
}


