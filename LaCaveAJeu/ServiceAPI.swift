//
//  ServiceAPI.swift
//  LaCaveAJeu
//
//  Created by etud on 15/03/2025.
//

import Foundation

class APIService : ObservableObject{
    @Published var games: [Game] = []
    
    @Published var acheteurs : [Acheteur] = []
    static let shared = APIService()
    private let baseURL = "https://awiback-30abadc2c48e.herokuapp.com/api"
    
    
    func fetchVendeurs(completion: @escaping ([Vendeur]) -> Void ){
        guard let url = URL(string : "\(baseURL)/vendeur") else {return}
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Vendeur].self, from:data)
                    DispatchQueue.main.async {
                        completion(decodedData)
                    }
                }catch{
                    print("erreur de decodage : ", error)
                }
            }
            
        }.resume()
    }
    
    func fetchAcheteurs(){
        guard let url = URL(string : "\(baseURL)/vendeur") else {return}
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.acheteurs = (try? JSONDecoder().decode([Acheteur].self, from: data)) ?? []
                }
            }
            
        }.resume()
    }
    
    func fetchGames() {
           guard let url = URL(string: "\(baseURL)/jeu") else { return }

           URLSession.shared.dataTask(with: url) { data, _, error in
               if let data = data {
                   DispatchQueue.main.async {
                       self.games = (try? JSONDecoder().decode([Game].self, from: data)) ?? []
                   }
               }
           }.resume()
       }
//
//       func addItem(name: String) {
//           guard let url = URL(string: "http://localhost:5000/items") else { return }
//
//           var request = URLRequest(url: url)
//           request.httpMethod = "POST"
//           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//           let body = ["name": name]
//           request.httpBody = try? JSONSerialization.data(withJSONObject: body)
//
//           URLSession.shared.dataTask(with: request) { _, _, _ in
//               DispatchQueue.main.async {
//                   self.fetchItems()  // Rafraîchir les données après ajout
//               }
//           }.resume()
//       }


}
