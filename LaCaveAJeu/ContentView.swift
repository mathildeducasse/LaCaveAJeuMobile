//
//  ContentView.swift
//  LaCaveAJeu
//
//  Created by etud on 12/03/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            
                ZStack {
                    
                    VStack {
                        var yellowlight = Color(red: 241/255.0, green: 227/255.0, blue: 129/255.0)
                        Image("texteBienv")
                            .resizable()
                            .padding(.horizontal, 22.0)
                            .scaledToFit()
                            .clipped()
                        
                        CountdownView()
                            
                        Spacer()
                        
                        NavigationLink(destination: GestionnaireView()) {
                            Text("Gestionnaire")
                                .font(.title2)
                                .foregroundColor(.brown)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(yellowlight)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                        }
                        .padding(.horizontal, 40)
                        
                        NavigationLink(destination: AcheteurView()) {
                            Text("Acheteur")
                                .font(.title2)
                                .foregroundColor(.brown)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(yellowlight)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                        }
                        .padding(.horizontal, 40)
                        
                        Spacer()
                    }
                }.background(Image("Image")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                )
            
            }
        
}

struct CountdownView: View {
    @State private var timeRemaining = 3 * 24 * 3600 + 12 * 3600 + 24 // Exemple de 3 jours 12h 24s
    var yellowlight = Color(red: 241/255.0, green: 227/255.0, blue: 129/255.0)
    var body: some View {
        Text("\(timeFormatted())")
            .font(.title2)
            .foregroundColor(.black)
            .padding()
            .background(yellowlight)
            .cornerRadius(10)
    }
    
    func timeFormatted() -> String {
        let hours = (timeRemaining / 3600) % 24
        let minutes = (timeRemaining / 60) % 60
        let seconds = timeRemaining % 60
        return "3 jours \(hours)h \(minutes)m \(seconds)s"
    }
}

struct GestionnaireView: View {
    var body: some View {
        Text("Page Gestionnaire")
    }
}

struct AcheteurView: View {
    var body: some View {
        Text("Page Acheteur")
    }
}

struct FestivalView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
