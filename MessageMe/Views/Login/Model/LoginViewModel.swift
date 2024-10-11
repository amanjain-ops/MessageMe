//
//  LoginViewModel.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import Foundation


class LoginViewModel: ObservableObject {
    @Published var loginUser = Login()
    @Published var loginResponsee: LoginResponse?
    
    
    func login() {
        
        Task { @MainActor in
            do {
                loginResponsee = try await NetworkManger.shared.login(user: loginUser)
            } catch {
                throw MMError.invalidData
            }
        }
    }
}
