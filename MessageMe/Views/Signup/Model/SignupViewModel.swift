//
//  SignupViewModel.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import Foundation


class SignupViewModel: ObservableObject {
    @Published var user = Signup()
    @Published var response: SignupResponse?
    @Published var isSignupSuccessful = false
    @Published var isButtonActive = false
    @Published var errorMessage: String = ""
    
    
    
    
    func signup() {
        Task { @MainActor in
            guard isValidDForm else { return }
            do {
               let  (data, httpResponse) = try await NetworkManger.shared.signup(user: user)
                response = data
                if httpResponse.statusCode == 201 {
                    isSignupSuccessful = true
                    print(isSignupSuccessful)
                }
            } catch {
                print(error.localizedDescription)
                throw MMError.invalidData
            }
        }
        
    }
    var isValidDForm: Bool {
        guard !user.name.isEmpty, !user.email.isEmpty, !user.password.isEmpty else {
//                alertItem = AlertContext.invalidForm
            DispatchQueue.main.async{
                self.errorMessage = "Enter all fields"
                
            }
            return false
        }
        
        guard user.email.isValidEmail else {
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
