//
//  NewChatView.swift
//  MessageMe
//
//  Created by Aman Jain on 12/10/24.
//

import SwiftUI

struct NewChatView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @StateObject var viewModel = NewChatViewModel()
    @EnvironmentObject var webSocketManager: WebSocketManager
    
    var body: some View {
        if loginViewModel.loginResponsee?.accessToken == nil {
            LoginView()
        }
        
        else {
            if webSocketManager.chatCreatedResponse?.id != nil {
                ChatDetailView(chatId: webSocketManager.chatCreatedResponse?.id ?? "")
                
            }
            else {
                ScrollView {
                    if !viewModel.userList.isEmpty{
                        ForEach(viewModel.userList) { user in
                            HStack(alignment: .center, spacing: 15) {
                                
                                Circle()
                                    .frame(width: 60)
                                
                                // name and last message
                                VStack (alignment: .leading, spacing: 5){
                                    Text(user.id)
                                        .fontWeight(.semibold)
                                }
                                Spacer()
                            }
                            .padding()
                            .onAppear{
                                webSocketManager.configure(with: loginViewModel)
                            }
                            .onTapGesture {
                                print("Hello")
                                
                                do {
                                     
                                     webSocketManager.chatCreate(recipentId: user.id)
                                }
                            }
                        }
                    }
                }
                .task{
                    viewModel.getUsers(with: loginViewModel)
                }
                .onDisappear{
                    webSocketManager.disconnect()
                }
            }
        }
    }
}

#Preview {
    NewChatView()
        .environmentObject(LoginViewModel())
        .environmentObject(WebSocketManager())
}
