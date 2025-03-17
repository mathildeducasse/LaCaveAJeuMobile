//
//  VendeurView.swift
//  LaCaveAJeu
//
//  Created by etud on 16/03/2025.
//

import SwiftUI

struct VendeurView: View {
    @StateObject var apiService = APIService()
    var body: some View {
        VStack {
            if apiService.vendeurs.isEmpty {
                            ProgressView("Chargement...") // Indicateur de chargement
            } else {
                List(apiService.vendeurs) { vendeur in
                    Text(vendeur.nom)
                }
                
            }
            Text("ahhh")
        }.background(Color.red)
            .onAppear {
                    apiService.fetchVendeurs()
                }
        
    }
    
}

struct VendeurView_Previews: PreviewProvider {
    static var previews: some View {
        VendeurView()
    }
}
