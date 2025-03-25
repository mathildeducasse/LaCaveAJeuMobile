import Foundation

// Décode un token JWT sans vérification de la signature
func decodeJWTToken(_ token: String) -> [String: Any]? {
    let segments = token.split(separator: ".")
    guard segments.count == 3 else { return nil }

    var base64 = String(segments[1])
        .replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")

    while base64.count % 4 != 0 {
        base64 += "="
    }

    guard let payloadData = Data(base64Encoded: base64),
          let jsonObject = try? JSONSerialization.jsonObject(with: payloadData),
          let payload = jsonObject as? [String: Any] else {
        return nil
    }

    return payload
}


class GestionnaireSession {
    static let shared = GestionnaireSession()

    private init() {}

    var token: String? {
        UserDefaults.standard.string(forKey: "userToken")
    }

    var gestionnaireID: String? {
        guard let token = token,
              let payload = decodeJWTToken(token),
              let id = payload["id"] as? String else {
            return nil
        }
        return id
    }

    var pseudo: String? {
        guard let token = token,
              let payload = decodeJWTToken(token),
              let pseudo = payload["pseudo"] as? String else {
            return nil
        }
        return pseudo
    }
    
    
    
    func logout(completion: @escaping (Bool) -> Void) {
        guard let pseudo = self.pseudo else {
            completion(false)
            return
        }

        GestionnaireService.shared.logout(pseudo: pseudo) { result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                print("Erreur lors de la déconnexion : \(error)")
                completion(false)
            }
        }
    }
}
