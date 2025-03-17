//
//  ServiceAPI.swift
//  LaCaveAJeu
//
//  Created by etud on 15/03/2025.
//

import Foundation

class APIService : ObservableObject{

    static let shared = APIService()
    private let baseURL = "https://awiback-30abadc2c48e.herokuapp.com/api"
    
    
    //Vendeurs : --------------------------------------------
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
    
    func addVendeur(_ vendeur : Vendeur) {
            guard let url = URL(string : "\(baseURL)/vendeur") else {return}
            
            do {
                let jsonData = try JSONEncoder().encode(vendeur)
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Erreur de requête : \(error.localizedDescription)")
                        return
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Statut HTTP : \(httpResponse.statusCode)")
                    }

                    if let data = data {
                        let jsonString = String(data: data, encoding: .utf8) ?? "Aucune réponse"
                        print(" Réponse JSON : \(jsonString)")
                        
//                        DispatchQueue.main.async {
//                            self.fetchVendeurs()
//                        }
                    }
                }.resume()
                
            } catch {
                print("Erreur d'encodage JSON : \(error)")
            }
        }
        
    func resetSolde(_ id : String){
        guard let url = URL(string : "\(baseURL)/vendeur/solde/\(id)") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erreur de requête : \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("Statut HTTP : \(httpResponse.statusCode)")
            }

            if let data = data {
                let jsonString = String(data: data, encoding: .utf8) ?? "Aucune réponse"
                print("Réponse JSON : \(jsonString)")
            }
        }.resume()
        
    }

    func deleteVendeur(_ id : String){
        guard let url = URL(string: "\(baseURL)/vendeur/\(id)") else {
                print("URL invalide")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Erreur de requête : \(error.localizedDescription)")
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    print("Statut HTTP : \(httpResponse.statusCode)")
                }

                if let data = data {
                    let jsonString = String(data: data, encoding: .utf8) ?? "Aucune réponse"
                    print("Réponse JSON : \(jsonString)")
                }
            }.resume()
    }
//------------------------------------------------------------------
    
//Jeux -------------------------------------------------------------
    func fetchJeux(completion: @escaping ([Game]) -> Void ){
        guard let url = URL(string : "\(baseURL)/jeu") else {return}
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Game].self, from:data)
                    DispatchQueue.main.async {
                        completion(decodedData)
                    }
                }catch{
                    print("erreur de decodage : ", error)
                }
            }
            
        }.resume()
    }
    
    
    func addGame(_ game : Game) {
            guard let url = URL(string : "\(baseURL)/jeu") else {return}
            
            do {
                let jsonData = try JSONEncoder().encode(game)
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Erreur de requête : \(error.localizedDescription)")
                        return
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Statut HTTP : \(httpResponse.statusCode)")
                    }

                    if let data = data {
                        let jsonString = String(data: data, encoding: .utf8) ?? "Aucune réponse"
                        print(" Réponse JSON : \(jsonString)")
                        
                    }
                }.resume()
                
            } catch {
                print("Erreur d'encodage JSON : \(error)")
            }
        }
//------------------------------------------------------------------
}
