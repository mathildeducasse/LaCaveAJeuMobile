//
//  JeuxViewModel.swift
//  LaCaveAJeu
//
//  Created by etud on 17/03/2025.
//

import SwiftUI


class JeuxViewModel: ObservableObject {
    @Published var games: [Game] = []
    @Published var categories : [Categorie] = []
    private let apiservice = APIService()
    
    
    func fetchGame(){
        apiservice.fetchGame() {[weak self] games in
            DispatchQueue.main.async {
                self?.games = games
            }
            
        }
    }
    
    func filterItems(proprietaire : String?, prix_min : String? , prix_max : String?,categorie : [String],intitule : String? ,statut : String? , editeur : String? ,quantites : Int?, completion: @escaping () -> Void) {
        apiservice.fetchFilteredGames(proprietaire : proprietaire, prix_min : prix_min, prix_max : prix_max,categorie : categorie, intitule : intitule, statut : statut, editeur : editeur, quantites  :quantites ) { [weak self] jeux in
               DispatchQueue.main.async {
                   self?.games = jeux
                   completion()
               }
           }
       }
    
    func getCategories() {
        apiservice.fetchCategories() {[weak self] categorie in
            DispatchQueue.main.async {
                
                self?.categories = categorie
            }
            
        }
    }
    
    func addGame(_ game : JeuTp, completion: @escaping () -> Void){
        apiservice.addGame(game)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.fetchGame()
                    completion()
                }
    }
    
    
    
}


