//
//  JeuxView.swift
//  LaCaveAJeu
//
//  Created by etud on 19/03/2025.
//

import SwiftUI

struct JeuxView: View {
    @Binding var jeu: Game
    @StateObject private var viewModel = JeuxViewModel()
    let yellowlight = Color(red: 241/255.0, green: 227/255.0, blue: 129/255.0)
    let redark = Color(red : 149/255.0, green :29/255.0, blue:25/255.0)
    let yellowlight2 = Color(red : 242/255.0, green : 233/255.0,blue:  223/255.0)
    
    var body: some View {
        HStack {
            let formattedPrix = String(format: "%.1f", jeu.prix)
            VStack(alignment: .leading) {
                
                Text(jeu.intitule)
                    .font(.title2)
                    .foregroundColor(redark)
                Text("\(jeu.vendeur)  —  \(jeu.quantites)")
                    .font(.subheadline)
                    .foregroundColor(redark)
            }
            Spacer()
            Text("\(formattedPrix) €")
                .font(.jomhuriaLittle())
                .bold()
                .foregroundColor(redark)
        }
        .padding()
        .background(yellowlight2)
        .cornerRadius(10)
    }
}

//struct JeuxView_Previews: PreviewProvider {
//    static var previews: some View {
//        JeuxView()
//    }
//}
