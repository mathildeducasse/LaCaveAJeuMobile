//
//  ContentView.swift
//  LaCaveAJeu
//
//  Created by etud on 12/03/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = VendeurlViewModel()
    var body: some View {
        let redark = Color(red : 149/255.0, green :29/255.0, blue:25/255.0)
        NavigationView{
            ZStack {
                let yellowlight = Color(red: 241/255.0, green: 227/255.0, blue: 129/255.0)
                
                VStack {
                    
                    Spacer()
                    Image("texteBienv")
                        .resizable()
                        .padding([ .leading, .trailing], 22.0)
                    
                        .scaledToFit()
                        .clipped()
                    
                    SessionView()
                        .padding(.bottom, 60)
                    
                    NavigationLink(destination: loginGestionnaireView()) {
                        Text("Gestionnaire")
                            .font(.jomhuria())
                            .foregroundColor(redark)
                            .padding(.vertical, 8.0)
                            .frame(maxWidth: .infinity)
                            .background(yellowlight)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom,20)
                    
                    NavigationLink(destination: StocksView()) {
                        Text("Acheteur")
                            .font(.jomhuria())
                            .foregroundColor(redark)
                            .padding(.vertical, 8.0)
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
            
        }.navigationBarBackButtonHidden(true)
    }
        
}

struct CountdownView: View {
    var redark = Color(red : 149/255.0, green :29/255.0, blue:25/255.0)
    @State private var timeRemaining = 3 * 24 * 3600 + 12 * 3600 + 24 // Exemple de 3 jours 12h 24s
    let yellowlight = Color(red: 241/255.0, green: 227/255.0, blue: 129/255.0)
    var body: some View {
        Text("\(timeFormatted())")
            .foregroundColor(redark)
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


//Des pages vides pour relier les boutons pour tests--------
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
//-----------------------------------------------------------

struct FestivalView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
