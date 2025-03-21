//
//  ServiceTransactions.swift
//  LaCaveAJeu
//
//  Created by etud on 19/03/2025.
//

import Foundation

class ServiceTransaction : ObservableObject{
    static let shared = ServiceTransaction()
    private let baseURL = "https://awiback-30abadc2c48e.herokuapp.com/api"
    
    func fetchTransactions(completion: @escaping ([Transaction]) -> Void ){
        guard let url = URL(string : "\(baseURL)/transaction") else {return}
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Transaction].self, from:data)
                    DispatchQueue.main.async {
                        completion(decodedData)
                    }
                }catch{
                    print("erreur de decodage get transactions: ", error)
                }
            }
            
        }.resume()
    }
    
    func addTransaction(_ transaction : Transaction) {
            guard let url = URL(string : "\(baseURL)/transaction") else {return}
            
            do {
                let jsonData = try JSONEncoder().encode(transaction)
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
                print("Erreur d'encodage JSON ajout transaction: \(error)")
            }
        }
    
    func fetchFilteredTransaction(gestionnaire : String?, acheteur : String? ,proprietaire: String?, prix_min: String?, prix_max: String?, remise : Float?, nameJeu: String?, statut: String?, completion: @escaping ([Transaction]) -> Void) {
        
        guard let url = URL(string: "\(baseURL)/transaction/filtered") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Construction du body JSON sans valeurs nulles
        var body: [String: Any] = [:]
        
        if let proprietaire = proprietaire { body["proprietaire"] = proprietaire }
        if let gestionnaire = gestionnaire { body["gestionnaire"] = gestionnaire }
        if let acheteur = acheteur { body["acheteur"] = acheteur }
        if let prix_min = prix_min { body["prix_min"] = prix_min }
        if let prix_max = prix_max { body["prix_max"] = prix_max }
        if let remise = remise { body["remise"] = remise }
        if let nameJeu = nameJeu { body["nameJeu"] = nameJeu }
        if let statut = statut { body["statut"] = statut }
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("Erreur lors de la conversion du body en JSON :", error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Transaction].self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedData)
                    }
                } catch {
                    print("Erreur de décodage pour transactions filtrés :", error)
                }
            }
        }.resume()
    }
    
}
