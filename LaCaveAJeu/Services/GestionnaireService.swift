import Foundation

class GestionnaireService: ObservableObject {
    static let shared = GestionnaireService()
    private let baseURL = "https://awiback-30abadc2c48e.herokuapp.com/api/gestionnaire"

    struct LoginResponse: Codable {
        let message: String
        let token: String
    }

    func login(pseudo: String, motDePasse: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else {
            completion(.failure(NSError(domain: "URL invalide", code: -1)))
            return
        }

        let body = [
            "pseudo": pseudo,
            "mot_de_passe": motDePasse
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(NSError(domain: "Aucune donnée", code: -1)))
                    }
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decoded.token))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }.resume()

        } catch {
            completion(.failure(error))
        }
    }

    func logout(pseudo: String, completion: @escaping (Result<Void, Error>) -> Void) {
    guard let url = URL(string: "\(baseURL)/logout") else {
        completion(.failure(NSError(domain: "URL invalide", code: -1)))
        return
    }

    let body: [String: String] = ["pseudo": pseudo]

    do {
        let jsonData = try JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                // Nettoyage local
                UserDefaults.standard.removeObject(forKey: "userToken")
                completion(.success(()))
            }
        }.resume()
    } catch {
        completion(.failure(error))
    }
}

}
