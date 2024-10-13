//
//  NewChatViewModel.swift
//  MessageMe
//
//  Created by Aman Jain on 12/10/24.
//

import Foundation

class NewChatViewModel: ObservableObject {
    @Published var userList: [Profile] = []
    
    
    func getUsers(with viewLogin: LoginViewModel) {
        Task{@MainActor in
            do {
                let userListUnfilter = try await NetworkManger.shared.getUsers(with: viewLogin)
                userList = userListUnfilter.filter { $0.id != viewLogin.loginResponsee?.userId}
            } catch {
                throw MMError.invalidData
            }
        }
    }
}
