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
        GestionnaireService.shared.login(pseudo: pseudo, motDePasse: motDePasse) { result in
            switch result {
            case .success(let token):
                self.token = token
                self.isAuthenticated = true
                self.errorMessage = nil
                UserDefaults.standard.set(token, forKey: "userToken")
                print("Token reçu : \(token)")
            case .failure(let error):
                self.isAuthenticated = false
                self.errorMessage = "Erreur : \(error.localizedDescription)"
                print(" Login échoué : \(error)")
            }
        }
    }

}

struct LoginResponse: Codable {
    let message: String
    let token: String
}
