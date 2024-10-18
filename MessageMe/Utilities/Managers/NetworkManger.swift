//
//  NetworkManger.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import Foundation

final class NetworkManger {
    static let shared = NetworkManger()
    
    private var loginViewModel: LoginViewModel?
    
    static let baseAuthURL = "http://127.0.0.1:5000/auth/"
    static let baseChatURL = "http://127.0.0.1:5000/chats/"
    static let baseUserURL = "http://127.0.0.1:5000/users/"
    private let registerURL = baseAuthURL + "register"
    private let loginURL = baseAuthURL + "login"
    private let getChatsURL = baseChatURL + "chatlist"
    private let getUserListURL = baseUserURL + "userlist"
    private let getMessagesURL = baseChatURL + "messagelist"
    private let getUserURL = baseUserURL + "getuser"
    private let updateNameURL = baseUserURL + "updatename"
    
    private init(){}
    
    // Signup network call
    func signup(user: Signup) async throws -> (SignupResponse, HTTPURLResponse) {
        
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
            
            let (data,httpResponse) = try await URLSession.shared.upload(for: request, from: encoded)
            
            guard let httpRespons = httpResponse as? HTTPURLResponse  else {
                throw MMError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(SignupResponse.self, from: data)
            print(response)
            return (response , httpRespons)
            
        } catch {
            throw MMError.invalidData
        }
        
        
        
    }
    
    
    
    
    func login(user: Login) async throws -> LoginResponse {
        
        guard let url = URL(string: loginURL) else {
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
            
            let decoded = JSONDecoder()
            decoded.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoded.decode(LoginResponse.self, from: data)
            
            return response
            
        } catch {
            throw MMError.invalidData
        }
    }
    
    
    func getChats(with viewModel: LoginViewModel) async throws -> [Chats] {
        guard let url = URL(string: getChatsURL) else{
            throw MMError.invalidURL
        }
        
        guard let accessToken = viewModel.loginResponsee?.accessToken else {
            print("Access token is not available")
            throw MMError.invalidData
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data,_) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let chats = try decoder.decode([Chats].self, from: data)
            return chats
        } catch {
            throw MMError.invalidData
        }
    }
    
    
    
    func getUsers(with viewModel: LoginViewModel) async throws -> [Profile] {
        
        guard let url = URL(string: getUserListURL) else{
            throw MMError.invalidURL
        }
        
        guard let accessToken = viewModel.loginResponsee?.accessToken else {
            print("Access token is not available")
            throw MMError.invalidData
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data,_) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let profile = try decoder.decode([Profile].self, from: data)
            
            return profile
        }catch {
            throw MMError.invalidData
        }
    }
    
    
    
    func getMessages(with viewModel: LoginViewModel, chatId: ChatId) async throws -> [Messages] {
        
        guard let url = URL(string: getMessagesURL) else {
            throw MMError.invalidURL
        }
        
        guard let accessToken = viewModel.loginResponsee?.accessToken else {
            print("Access token is not available")
            throw MMError.invalidData
        }
        
        guard let encoder = try? JSONEncoder().encode(chatId) else {
            throw MMError.invalidData
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        print("calling network call")
        do {
            let (data,_) = try await URLSession.shared.upload(for: request, from: encoder)
            let decoder = JSONDecoder()
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode([Messages].self, from: data)
            return response
        } catch {
            throw MMError.invalidData
        }
    }
    
    
    func getUserInfo(with viewModel: LoginViewModel) async throws -> Profile {
        
        guard let url = URL(string: getUserURL) else {
            throw MMError.invalidURL
        }
        
        guard let accessToken = viewModel.loginResponsee?.accessToken else {
            throw MMError.invalidData
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        do {
            let(data,_) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Profile.self, from: data)
        }
    }
    
    func updateName(with viewModel: LoginViewModel, name: String) async throws -> Profile {
        guard let url = URL(string: updateNameURL) else {
            throw MMError.invalidURL
            }
        
        guard let accessToken = viewModel.loginResponsee?.accessToken else {
            throw MMError.invalidData
        }
        
        let bodyData = ["profile_name": name]
        
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(Profile.self, from: data)
            
        }
    }
}
