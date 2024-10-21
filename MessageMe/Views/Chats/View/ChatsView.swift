//
//  ChatsView.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import SwiftUI

struct ChatsView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var webSocketMg: WebSocketManager
    @StateObject var viewModel = ChatsViewModel()
    @Binding var path: NavigationPath
    
    var body: some View {
        if loginViewModel.loginResponsee?.accessToken == nil {
            LoginView()
        }
        
        else {
            NavigationStack(path: $path) {
                VStack {
                    if viewModel.isLoading {
                        ProgressView()
                            .task {
                                webSocketMg.configure(with: loginViewModel)
                                viewModel.getChatList(with: loginViewModel)
                            }
                        
                    }
                    else {
                        ScrollView {
                            LazyVStack(alignment: .leading){
                                ForEach(viewModel.chats.indices, id: \.self) { index in
                                    
                                    NavigationLink(value: viewModel.chats[index]) {
                                        
                                        ChatCardView(chat: viewModel.chats[index], loginViewModel: loginViewModel)
                                            .onChange(of: webSocketMg.chatss) { oldValue, newValue in
                                                
                                                if let ind = webSocketMg.chatss.firstIndex(where: { $0.id == viewModel.chats[index].id}) {
                                                    
                                                    viewModel.chats[index].lastMessage = webSocketMg.chatss[ind].lastMessage
                                                }
                                            }
                                    }
                                }
                            }
                            
                        }
                        .refreshable {
                            viewModel.getChatList(with: loginViewModel)
                        }
                        .task {
                            webSocketMg.joinAllChats(chatIds: viewModel.chats)
                        }
                        .navigationTitle("MessageMe")
                        .safeAreaInset(edge: .bottom, alignment: .trailing){
                            FloatingButton{
                                print("hola")
                                path.append(ChatNavigation.newChat)
                            }
                        }
                        
                    }
                }
                .background(Color.secondaryColor)
                .navigationTitle("MessageME")
                .navigationDestination(for: Chats.self) { chat in
                    ChatDetailView(chatId: chat.id, otherUser: chat.otherParticipantName, path: $path)
                }
                .navigationDestination(for: ChatNavigation.self) { val in
                    switch val {
                    case .newChat:
                        NewChatView(path: $path)
                        
                    case .chatDetail(let chatId, let user):
                        ChatDetailView(chatId: chatId, otherUser: user, path: $path)
                    }
                    
                }
                .safeAreaInset(edge: .top, alignment: .leading) {
                    HStack{
                        Text("MessageMe")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.primaryColor)
                        Spacer()
                    }
                    .padding()
                    .background(Color.secondaryColor)
                }
                
            }
            
        }
    }
}

#Preview {
    ChatsView( path: .constant(NavigationPath()))
        .environmentObject(LoginViewModel())
        .environmentObject(WebSocketManager())
}


struct ChatCardView: View {
    var chat: Chats
    var loginViewModel: LoginViewModel?
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            
            // profile pic
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60)
                .foregroundStyle(.gray)
            
            // name and last message
            VStack (alignment: .leading, spacing: 5){
                
                Text(chat.otherParticipantName?.profileName ?? "")
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundStyle(Color.textColor)
                
                Text(chat.lastMessage?.message ?? "")
                    .lineLimit(1)
                    .foregroundStyle(Color("secondaryTextColor"))
            }
            Spacer()
            // time and msg count
            VStack(alignment: .trailing, spacing: 6){
                
                //                Text(String(describing: chat.lastMessage?.sentAt
                //                    .formatted(
                //                    .dateTime
                //                        .hour(
                //                            // am/pm will not show
                //                            .twoDigits(amPM: .omitted))
                //                        .minute()
                //                )
                //                ))
                
                Text(StringToDate(strDate: chat.lastMessage?.sentAt ?? ""))
                    .foregroundStyle(.accent)
                    .font(.footnote)
                    .bold()
                
                
                Text("26")
                    .font(.caption)
                    .fontWeight(.bold)
                    .frame(width: 28, height: 28)
                    .foregroundStyle(.white)
                    .background(Color.primaryColor)
                    .clipShape(Circle())
            }
        }
        .padding()
    }
}

struct FloatingButton: View {
    var action: () -> Void
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.primaryColor)
                .frame(width: 60, height: 60)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .onTapGesture {
                    action()
                }
            
            Image(systemName: "plus")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
    }
}
