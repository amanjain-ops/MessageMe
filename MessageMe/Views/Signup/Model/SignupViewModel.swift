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
    
    
    func signup() {
        Task { @MainActor in 
            do {
                response = try await NetworkManger.shared.signup(user: user)
            } catch {
                print(error.localizedDescription)
                throw MMError.invalidData
            }
        }
    }
}
