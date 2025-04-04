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
                    print("erreur de decodage get vendeur: ", error)
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
                print("Erreur d'encodage JSON add vendeur : \(error)")
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
    func fetchGame(completion: @escaping ([Game]) -> Void ){
        guard let url = URL(string : "\(baseURL)/jeu") else {return}
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Game].self, from:data)
                    DispatchQueue.main.async {
                        completion(decodedData)
                    }
                }catch{
                    print("erreur de decodage recup jeu: ", error)
                }
            }
            
        }.resume()
    }
    
    func fetchFilteredGames(proprietaire: String?, prix_min: String?, prix_max: String?, categorie: [String], intitule: String?, statut: String?, editeur: String?, quantites: String?, completion: @escaping ([Game]) -> Void) {
        
        guard let url = URL(string: "\(baseURL)/jeu/filtered") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Construction du body JSON sans valeurs nulles
        var body: [String: Any] = [:]
        
        if let proprietaire = proprietaire { body["proprietaire"] = proprietaire }
        if let prix_min = prix_min { body["prix_min"] = prix_min }
        if let prix_max = prix_max { body["prix_max"] = prix_max }
        if !categorie.isEmpty { body["categories"] = categorie }
        if let intitule = intitule { body["intitule"] = intitule }
        if let statut = statut { body["statut"] = statut }
        if let editeur = editeur { body["editeur"] = editeur }
        if let quantites = quantites { body["quantites"] = quantites }
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("Erreur lors de la conversion du body en JSON :", error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Réponse JSON brute :", json)
                    let decodedData = try JSONDecoder().decode([Game].self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedData)
                        
                    }
                } catch {
                    print("Erreur de décodage pour jeux filtrés :", error)
                }
            }
        }.resume()
    }
    
    func addGame(_ game : JeuTp) {
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
                print("Erreur d'encodage JSON ajout jeu: \(error)")
            }
        }
//------------------------------------------------------------------
    
//TypeJeu : --------------------------------------------------------
    func fetchTypeJeux(completion: @escaping ([TypeJeu]) -> Void ){
        guard let url = URL(string : "\(baseURL)/typejeu") else {return}
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([TypeJeu].self, from:data)
                    DispatchQueue.main.async {
                        completion(decodedData)
                    }
                }catch{
                    print("erreur de decodage type jeu: ", error)
                }
            }
            
        }.resume()
    }
    
    func fetchTypeJeuxById(id: String, completion: @escaping (TypeJeu) -> Void ){
        guard let url = URL(string : "\(baseURL)/typejeu/\(id)") else {return}
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(TypeJeu.self, from:data)
                    DispatchQueue.main.async {
                        completion(decodedData)
                    }
                }catch{
                    print("erreur de decodage jeu by id: ", error)
                }
            }
            
        }.resume()
    }
    
    
    
//------------------------------------------------------------------
    
//Catégorie : ------------------------------------------------------
    
    func fetchCategories(completion: @escaping ([Categorie]) -> Void ){
        guard let url = URL(string : "\(baseURL)/categorie") else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    do {
                        // Décoder un seul objet Session
                        let decodedData = try JSONDecoder().decode([Categorie].self, from: data)
                        DispatchQueue.main.async {
                            completion(decodedData)
                        }
                    } catch {
                        print("Erreur de décodage cate : ", error)
                    }
                }
            }.resume()
    }

    
//------------------------------------------------------------------
//Session : --------------------------------------------------------
    
    func fetchNextSession(completion: @escaping (Session) -> Void ){
        guard let url = URL(string : "\(baseURL)/session/nextsession") else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    do {
                        // Décoder un seul objet Session
                        let decodedData = try JSONDecoder().decode(Session.self, from: data)
                        DispatchQueue.main.async {
                            completion(decodedData)
                        }
                    } catch {
                        print("Erreur de décodage next : ", error)
                    }
                }
            }.resume()
    }
    
    
    func fetchSessionEnCours(completion: @escaping (Session) -> Void ){
        guard let url = URL(string : "\(baseURL)/session/encours") else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    do {
                        // Décoder un seul objet Session
                        let decodedData = try JSONDecoder().decode(Session.self, from: data)
                        DispatchQueue.main.async {
                            completion(decodedData)
                        }
                    } catch {
                        print("Erreur de décodage next : ", error)
                    }
                }
            }.resume()
    }

    func fetchSession(completion: @escaping ([Session]) -> Void ){
        guard let url = URL(string : "\(baseURL)/session") else {return}
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Session].self, from:data)
                    DispatchQueue.main.async {
                        completion(decodedData)
                    }
                }catch{
                    print("erreur de decodage  tout: ", error)
                }
            }
            
        }.resume()
    }

    
//------------------------------------------------------------------
}
