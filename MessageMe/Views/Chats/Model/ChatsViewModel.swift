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
    @Published var isLoading = true
    
    func getChatList(with viewModel: LoginViewModel) {
//        isLoading = true
        Task { @MainActor in
            do {
                chats = try await NetworkManger.shared.getChats(with: viewModel)
                chats = chats.filter{$0.lastMessage?.message != ""}
//                print(chats)
                isLoading = false
                
            } catch {
                throw MMError.invalidResponse
            }
        }
    }
}
