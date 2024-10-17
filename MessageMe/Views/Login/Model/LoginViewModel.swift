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
    @Published var errorMessage: String = ""
    
    
    func login() {
        
        Task { @MainActor in
            guard isValidDForm else { return }
            do {
                loginResponsee = try await NetworkManger.shared.login(user: loginUser)
            } catch {
                throw MMError.invalidData
            }
        }
    }
    
    var isValidDForm: Bool {
        guard !loginUser.email.isEmpty, !loginUser.password.isEmpty else {
//                alertItem = AlertContext.invalidForm
            DispatchQueue.main.async{
                self.errorMessage = "Enter all fields"
                
            }
            return false
        }
        
        guard loginUser.email.isValidEmail else {
//                alertItem = AlertContext.invalidEmail
            DispatchQueue.main.async{
                self.errorMessage = "Invalid Email format"
            }
            return false
        }
        self.errorMessage = ""
        return true
    }
}
