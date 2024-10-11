//
//  NetworkManger.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import Foundation

final class NetworkManger {
    static let shared = NetworkManger()
    
    static let baseURL = "http://127.0.0.1:5000/auth/"
    private let registerURL = baseURL + "register"
    private let loginURL = baseURL + "login"
    private let chatURL = baseURL + "chats"
    
    private init(){}
    
    func signup(user: Signup) async throws -> SignupResponse {
        
        guard let url = URL(string: registerURL) else {
            throw MMError.invalidURL
        }
        
        guard let encoded = try? JSONEncoder().encode(user) else {
            throw MMError.invalidData
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            
            let (data,_) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(SignupResponse.self, from: data)
            print(response)
            return response
            
        } catch {
            throw MMError.invalidData
        }
        
        
        
    }
}
