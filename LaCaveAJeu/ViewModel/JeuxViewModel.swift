//
//  JeuxViewModel.swift
//  LaCaveAJeu
//
//  Created by etud on 17/03/2025.
//

import SwiftUI


class JeuxViewModel: ObservableObject {
    @Published var games: [Game] = []
    @Published var categories : [String] = []
    private let apiservice = APIService()
    
    
    func fetchGame(){
        apiservice.fetchGame() {[weak self] games in
            DispatchQueue.main.async {
                self?.games = games
            }
            
        }
    }
    
    func filterItems(proprietaire : String?, prix_min : String? , prix_max : String?,categorie : [String],intitule : String? ,statut : String? , editeur : String? ,quantites : String?) {
        apiservice.fetchFilteredGames(proprietaire : proprietaire, prix_min : prix_min, prix_max : prix_max,categorie : categorie, intitule : intitule, statut : statut, editeur : editeur, quantites  :quantites ) { [weak self] jeux in
               DispatchQueue.main.async {
                   self?.games = jeux
               }
           }
       }
    
    func getCategories() {
        fetchGame()
        for game in games {
            print(game.categories)
            categories.append(contentsOf: game.categories)
            }
    }
    
    func addGame(_ game : Game){
        apiservice.addGame(game)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.fetchGame()
                }
    }
    
    
    
}


