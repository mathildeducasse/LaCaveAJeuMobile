//
//  AcheteurService.swift
//  LaCaveAJeu
//
//  Created by etud on 21/03/2025.
//

import Foundation

class AcheteurService : ObservableObject{
    static let shared = AcheteurService()
    private let baseURL = "https://awiback-30abadc2c48e.herokuapp.com/api"
    
    func fetchAcheteurs(completion: @escaping ([Acheteur]) -> Void ){
        guard let url = URL(string : "\(baseURL)/acheteur") else {return}
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Acheteur].self, from:data)
                    DispatchQueue.main.async {
                        completion(decodedData)
                    }
                }catch{
                    print("erreur de decodage acheteur: ", error)
                }
            }
            
        }.resume()
    }
    
    func addAcheteur(_ acheteur : Acheteur) {
            guard let url = URL(string : "\(baseURL)/acheteur") else {return}
            
            do {
                let jsonData = try JSONEncoder().encode(acheteur)
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
                print("Erreur d'encodage JSON adding acheteur: \(error)")
            }
        }
    
}
