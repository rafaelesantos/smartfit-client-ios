//
//  Webservice.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 27/01/22.
//

import Foundation

class Webservice {
    func getHeaderToken(completion: @escaping (HeaderToken?) -> ()) {
        guard let url = URL(string: "https://espacodocliente.smartfit.com.br/_next/data/QuEU8KIgH8nhwInCbWxQZ/pt-BR/person_data.json") else { fatalError("Invalid URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            let headerToken = try? JSONDecoder().decode(HeaderToken.self, from: data)
            DispatchQueue.main.async { completion(headerToken) }
        }.resume()
    }
    
    func postLogin(secret: String, login: String, password: String, completion: @escaping (Login?) -> ()) {
        guard let url = URL(string: "https://espacodocliente.smartfit.com.br/api/v1/login") else { fatalError("Invalid URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(secret, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        struct LoginRequest: Codable {
            let login: String
            let password: String
        }
        
        let loginRequestBody = LoginRequest(login: login, password: password)
        request.httpBody = try? JSONEncoder().encode(loginRequestBody)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            let loginResponse = try? JSONDecoder().decode(Login.self, from: data)
            DispatchQueue.main.async { completion(loginResponse) }
        }.resume()
    }
    
    func getUser(secret: String, completion: @escaping (User?) -> ()) {
        guard let url = URL(string: "https://espacodocliente.smartfit.com.br/api/v1/user") else { fatalError("Invalid URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(secret, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            let userResponse = try? JSONDecoder().decode(User.self, from: data)
            DispatchQueue.main.async { completion(userResponse) }
        }.resume()
    }
    
    func getUserSession(secret: String, completion: @escaping (UserSession?) -> ()) {
        guard let url = URL(string: "https://espacodocliente.smartfit.com.br/api/v1/user-session") else { fatalError("Invalid URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(secret, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            let userSessionResponse = try? JSONDecoder().decode(UserSession.self, from: data)
            DispatchQueue.main.async { completion(userSessionResponse) }
        }.resume()
    }
    
    func getUserPayment(secret: String, completion: @escaping (UserPayment?) -> ()) {
        guard let url = URL(string: "https://espacodocliente.smartfit.com.br/api/v1/user-payment") else { fatalError("Invalid URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(secret, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            let userPaymentResponse = try? JSONDecoder().decode(UserPayment.self, from: data)
            DispatchQueue.main.async { completion(userPaymentResponse) }
        }.resume()
    }
    
    func getUserHistoryAccess(secret: String, userID: Int, lastDays: Int, completion: @escaping (UserHistoryAccess?) -> ()) {
        guard let url = URL(string: ("https://espacodocliente.smartfit.com.br/api/v1/user/\(userID)/accesses?locale=pt-BR&start_at=\(Date.getDateFor(days: -lastDays)?.formatted(with: "yyyy-MM-dd") ?? "")&end_at=\(Date().formatted(with: "yyyy-MM-dd"))").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { fatalError("Invalid URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(secret, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            let userHistoryAccessResponse = try? JSONDecoder().decode(UserHistoryAccess.self, from: data)
            DispatchQueue.main.async { completion(userHistoryAccessResponse) }
        }.resume()
    }
    
    func getLocations(secret: String, token: String, completion: @escaping (Locations?) -> ()) {
        guard let url = URL(string: "https://espacodocliente.smartfit.com.br/api/v2/locations/available?single_access_token=\(token)&locale=pt-BR") else { fatalError("Invalid URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(secret, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            let locationsResponse = try? JSONDecoder().decode(Locations.self, from: data)
            DispatchQueue.main.async { completion(locationsResponse) }
        }.resume()
    }
}
