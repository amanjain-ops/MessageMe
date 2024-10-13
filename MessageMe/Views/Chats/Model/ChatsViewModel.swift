//
//  ChatsViewModel.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import Foundation

class ChatsViewModel: ObservableObject {
    @Published var chats: [Chats] = []
//    private var loginViewModel: LoginViewModel?
    
    func getChatList(with viewModel: LoginViewModel) {
        Task { @MainActor in
            do {
                chats = try await NetworkManger.shared.getChats(with: viewModel)
            } catch {
                throw MMError.invalidResponse
            }
        }
    }
}
