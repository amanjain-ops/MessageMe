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
    @State private var chatId: String = ""
    @Binding var path: NavigationPath
    
    var body: some View {
        ScrollView {
            if viewModel.userList.isEmpty{
                ProgressView()
                    .onAppear {
                        Task {
                            viewModel.getUsers(with: loginViewModel)
                        }
                    }
            } // if
            else {
                
                ForEach(viewModel.userList) { user in
                    UserCardView(user: user)
                        .onTapGesture {
                            do {
                                webSocketManager.chatCreate(recipentId: user.id)
                                print("chatId: \(String(describing: webSocketManager.chatCreatedResponse?.id))")
                            }
                        }
                }
                .onChange(of: webSocketManager.chatCreatedResponse?.id) { oldValue, newValue in
                    print("chatId: \(String(describing: newValue))")
                    
                    if let id = newValue {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            chatId = id
                            path.removeLast()
                            path.append(ChatNavigation.chatDetail(chatId: chatId))
                        }
                    } else {
                        print("no navigation")
                    }
                }
                
                
            }
            
        }
    }
}

#Preview {
    NewChatView(path: .constant(NavigationPath()))
        .environmentObject(LoginViewModel())
        .environmentObject(WebSocketManager())
}

struct UserCardView: View {
    var user: Profile
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            
            //            Circle()
            //                .frame(width: 60)
            
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60)
                .foregroundStyle(.gray)
            
            // name and last message
            VStack (alignment: .leading, spacing: 5){
                Text(user.profileName ?? "")
                    .fontWeight(.semibold)
            }
            Spacer()
        }
        .padding()
        
    }
}




