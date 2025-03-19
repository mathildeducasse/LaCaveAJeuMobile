//
//  SessionView.swift
//  LaCaveAJeu
//
//  Created by etud on 18/03/2025.
//

import SwiftUI

struct SessionView: View {
    @StateObject private var viewModel = SessionViewModel()
    @State private var currentTime = Date()
    @State private var timer: Timer?
    
    var redark = Color(red: 149/255.0, green: 29/255.0, blue: 25/255.0)
    let yellowlight = Color(red: 241/255.0, green: 227/255.0, blue: 129/255.0)
    
    var body: some View {
        VStack {
            if let sessionEnCours = viewModel.session {
                let date = formatter(dateString: sessionEnCours.dateFin)
                Text("\(timeFormatted(datee: date))")
                    .foregroundColor(redark)
                    .padding()
                    .background(yellowlight)
                    .cornerRadius(10)
            } else if let nextSession = viewModel.nextSession {
                let date = formatter(dateString: nextSession.dateDebut)
                Text("Prochaine session : ")
                Text("\(timeFormatted(datee: date))")
                    .foregroundColor(redark)
                    .padding()
                    .background(yellowlight)
                    .cornerRadius(10)
            }
        }
        .onAppear {
            startTimer()
            viewModel.fetchNextSession()
            viewModel.fetchSessionEnCours()
            viewModel.fetchSessions()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            currentTime = Date() // Met à jour le temps actuel
        }
    }
    
    func stopTimer() {
        timer?.invalidate() // Arrête le timer quand la vue disparaît
    }
    
    func timeFormatted(datee: Date?) -> String {
        if let date = datee {
            let now = currentTime // Utilise le temps actuel pour les calculs
            let components = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: now, to: date)
            
            let days = components.day ?? 0
            let hours = components.hour ?? 0
            let minutes = components.minute ?? 0
            let seconds = components.second ?? 0
            
            return "\(days) jours \(hours) h \(minutes) m \(seconds) s"
        } else {
            return "Erreur"
        }
    }
    
    func formatter(dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Format exact de ta date
        formatter.timeZone = TimeZone(abbreviation: "UTC") // S'assurer que la date est bien en UTC
        formatter.locale = Locale(identifier: "fr_FR")
        let date = formatter.date(from: dateString)
        return date
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}
