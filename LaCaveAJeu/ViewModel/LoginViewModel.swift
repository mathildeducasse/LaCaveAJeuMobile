import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var pseudo: String = ""
    @Published var motDePasse: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    @Published var token: String?

    private var cancellables = Set<AnyCancellable>()

    func login() {
        guard let url = URL(string: "https://awiback-30abadc2c48e.herokuapp.com/api/gestionnaire/login") else {
            errorMessage = "URL invalide"
            return
        }

        let body: [String: String] = [
            "pseudo": pseudo,
            "mot_de_passe": motDePasse
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            errorMessage = "Erreur encodage JSON"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: LoginResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = "Erreur: \(error.localizedDescription)"
                    self.isAuthenticated = false
                }
            } receiveValue: { response in
                self.token = response.token
                self.isAuthenticated = true
                self.errorMessage = nil
                UserDefaults.standard.set(response.token, forKey: "userToken") // Sauvegarde du token
                print("Token reçu: \(response.token)")
            }
            .store(in: &cancellables)
    }
}

struct LoginResponse: Codable {
    let message: String
    let token: String
}
