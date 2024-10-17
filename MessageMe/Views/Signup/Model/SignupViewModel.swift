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
    
    func signup() {
        Task { @MainActor in
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
}
