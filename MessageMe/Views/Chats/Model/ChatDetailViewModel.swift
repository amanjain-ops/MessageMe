//
//  ChatDetailViewModel.swift
//  MessageMe
//
//  Created by Aman Jain on 13/10/24.
//

import Foundation


class ChatDetailViewModel: ObservableObject {
    @Published var messages: [Messages] = []
    @Published var isLoading = false
    @Published var chatId = ChatId()
    
    func getMessages(with viewModel: LoginViewModel) {
        Task {@MainActor in
            isLoading = true
            print(isLoading)
            do {
                print(chatId.chatId)
                messages = try await NetworkManger.shared.getMessages(with: viewModel, chatId: chatId)
                isLoading = false
                
            } catch {
                throw MMError.invalidData
            }
        }
    }
}
