//
//  ServiceAPI.swift
//  LaCaveAJeu
//
//  Created by etud on 15/03/2025.
//

import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = "https://awiback-30abadc2c48e.herokuapp.com"
    
    
    func fetchVendeurs(){}

    // Exemple de fonction pour recup des jeux
//    func fetchGames(completion: @escaping (Result<[Game], Error>) -> Void) {
//        guard let url = URL(string: "\(baseURL)/games") else {
//            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(NSError(domain: "No Data", code: 0)))
//                return
//            }
//
//            do {
//                let games = try JSONDecoder().decode([Game].self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(games))
//                }
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
}
