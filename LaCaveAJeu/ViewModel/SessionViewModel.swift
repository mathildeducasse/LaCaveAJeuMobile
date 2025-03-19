//
//  SessionViewModel.swift
//  LaCaveAJeu
//
//  Created by etud on 18/03/2025.
//

import SwiftUI

class SessionViewModel: ObservableObject {
    @Published var session: Session? // Une seule session en cours
    @Published var nextSession: Session?
    @Published var sessions: [Session] = [] // Si vous avez besoin de gérer un tableau

    private let apiservice = APIService()
    
    func fetchNextSession() {
        apiservice.fetchNextSession() { [weak self] session in
            DispatchQueue.main.async {
                self?.nextSession = session
            }
        }
    }
    
    func fetchSessionEnCours() {
        apiservice.fetchSessionEnCours() { [weak self] session in
            DispatchQueue.main.async {
                self?.session = session
            }
        }
    }

    func fetchSessions() {
        apiservice.fetchSession() { [weak self] sessions in
            DispatchQueue.main.async {
                self?.sessions = sessions
            }
        }
    }
}

