//
//  ChatsView.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import SwiftUI

struct ChatsView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @StateObject var viewModel = ChatsViewModel()
    
    var body: some View {
        if loginViewModel.loginResponsee?.accessToken == nil {
            LoginView()
        }
        
        else {
            ScrollView {
                LazyVStack{
                    ForEach(viewModel.chats, id: \.id) { chat in
                        ChatCardView(chat: chat)
                    }
                }
            }
            .task {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    viewModel.getChatList(with: loginViewModel)
                }
                
            }
            .navigationTitle("MessageMe")
            .safeAreaInset(edge: .bottom, alignment: .trailing){
                ZStack{
                    Circle()
                        .fill(.accent)
                        .frame(width: 60, height: 60)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        .onTapGesture {
                            print("jjj")
                        }
                    
                    Image(systemName: "plus")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    ChatsView()
        .environmentObject(LoginViewModel())
}


struct ChatCardView: View {
    var chat: Chats
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            
            // profile pic
            Circle()
                .frame(width: 60)
            
            // name and last message
            VStack (alignment: .leading, spacing: 5){
                Text(chat.participants[1])
                    .fontWeight(.semibold)
                
                Text(chat.lastMessage?.message ?? "")
                    .lineLimit(1)
            }
            
            // time and msg count
            VStack(alignment: .trailing, spacing: 6){
                
                Text(String(describing: chat.lastMessage?.sentAt
                    .formatted(
                    .dateTime
                        .hour(
                            // am/pm will not show
                            .twoDigits(amPM: .omitted))
                        .minute()
                )
                ))
                .foregroundStyle(.accent)
                .font(.footnote)
                .bold()
                
                
                Text("26")
                    .font(.caption)
                    .fontWeight(.bold)
                    .frame(width: 28, height: 28)
                    .foregroundStyle(.white)
                    .background(.accent)
                    .clipShape(Circle())
            }
            
            
            
        }
        .padding()
        
    }
}
