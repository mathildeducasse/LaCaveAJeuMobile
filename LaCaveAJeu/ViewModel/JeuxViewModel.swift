//
//  JeuxViewModel.swift
//  LaCaveAJeu
//
//  Created by etud on 17/03/2025.
//

import SwiftUI

class JeuxViewModel: ObservableObject {
    @Published var games: [Game] = []
    private let apiservice = APIService()
    
    
    func fetchGame(){
        apiservice.fetchGame() {[weak self] games in
            DispatchQueue.main.async {
                self?.games = games
            }
            
        }
    }
    
    func addGame(_ game : Game){
        apiservice.addGame(game)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.fetchGame()
                }
    }
    
}


