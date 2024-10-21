//
//  ChatDetailView.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//
import Foundation
import SwiftUI

struct ChatDetailView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var webSocketManager: WebSocketManager
    @StateObject var viewModel = ChatDetailViewModel()
    var chatId: String
    var otherUser: Profile?
    @State private var hasLoadMessage: Bool = false
    @Binding var path: NavigationPath
    
    var body: some View {
            ZStack{
                Color.secondaryColor
                    .ignoresSafeArea()
            ScrollView {
                
                if viewModel.isLoading {
                    ProgressView()
                        .onAppear{
                            Task{
                                print("hasLoadMessage: \(hasLoadMessage)")
                                if !hasLoadMessage {
                                    
                                    viewModel.chatId.chatId = chatId
                                    
                                    viewModel.getMessages(with: loginViewModel)
                                    hasLoadMessage = true
                                    
                                    webSocketManager.joinChat(chatId: chatId)
                                } // if
                                
                            } // task
                        } // onAppear
                }
                else {
                    if viewModel.messages.isEmpty {
                        VStack {
                        }
                    }else {
                        ForEach(viewModel.messages.indices, id: \.self) { index in
                            if index >= 1 {
                                ChatBubble(message: viewModel.messages[index], previousMessage: viewModel.messages[index-1], userId: (loginViewModel.loginResponsee?.userId)!)
                            } else {
                                ChatBubble(message: viewModel.messages[index], userId: (loginViewModel.loginResponsee?.userId)!)
                            }
                            
                        }
                    }
                    
                    ForEach(webSocketManager.messages.indices, id: \.self) { ind in
                        //                    if webSocketManager.messages[ind].chatId == chatId {
                        if ind >= 1{
                            ChatBubble(message: webSocketManager.messages[ind], previousMessage: webSocketManager.messages[ind-1], userId: (loginViewModel.loginResponsee?.userId)!)
                        }
                        else{
                            ChatBubble(message: webSocketManager.messages[ind], previousMessage: viewModel.messages.last, userId: (loginViewModel.loginResponsee?.userId)!)
                        }
                        //                    }
                        
                    }
                }
                
            } // scrollview
            .onDisappear {
                hasLoadMessage = false
                webSocketManager.messages = []
            }
            .defaultScrollAnchor(.bottom)
            .frame(width: 400)
            .toolbar(.hidden, for: .tabBar)
            .navigationBarBackButtonHidden()
            .safeAreaInset(edge: .bottom, alignment: .center) {
                
                VStack {
                    HStack{
                        TextField("Message", text: $webSocketManager.newMessage, axis: .vertical)
                            .lineLimit(5)
                            .padding(.vertical, 7)
                            .padding(.leading, 20)
                            .padding(.bottom, 7)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            }
                        
                        
                        Button {
                            webSocketManager.sendMessage(chatId: chatId)
                            webSocketManager.newMessage = ""
                        } label: {
                            Image(systemName: "triangle.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .rotationEffect(.degrees(90))
                                .foregroundStyle(Color.primaryColor)
                        }// label
                    } // hstack
                    .padding(.horizontal, 5)
                    .padding(.top, 5)
                }
                .background(Color.secondaryColor)
            } //safeAreaInset
            
            .safeAreaInset(edge: .top) {
                //            ToolbarItem(placement: .topBarLeading){
                HStack{
                    Button(action: {
                        path.removeLast()
                    }) {
                        Image(systemName: "chevron.left")
                            .bold()
                    }
                    //            }
                    
                    //            ToolbarItem(placement: .principal) {
                    UserCardView(user: otherUser!, width: 40)
                        .padding(5)
                    //            }
                }
                .padding(.horizontal, 4)
                //            .background(Color.gray.mix(with: .pin, by: 0.2))
                .background(Color.secondaryColor)
                
                
                
            }
        }

    }
}

#Preview {
    ChatDetailView(chatId: "670903f421efb36287072a9d", otherUser: Profile(id: "670b7f43f8e2c3c770fd2383", email: "sdg", profileName: "sss", profilePicUrl: ""), path: .constant(NavigationPath()))
        .environmentObject(LoginViewModel())
        .environmentObject(WebSocketManager())
}


func StringToDate(strDate: String) -> String {
    //    print(strDate)
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS" // Format of your input string
    
    // Step 2: Convert the string to a Date object
    if let date = inputDateFormatter.date(from: strDate) {
        
        // Step 3: Create a DateFormatter to format the Date to "hh:mm"
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "HH:mm" // For 24-hour format, or use "hh:mm a" for 12-hour with AM/PM
        
        // Step 4: Convert the Date to the desired string format
        let formattedTime = outputDateFormatter.string(from: date)
        //        print("Formatted Time: \(formattedTime)") // Output: "14:45"
        
        return formattedTime
        
    } else {
        print("Invalid date string")
        return ""
    }
}

struct ChatBubble: View {
    var message: Messages
    var previousMessage: Messages?
    var userId: String
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text(message.message)
                    .padding(.horizontal, 5)
                
                HStack{
                    Spacer()
                    Text(StringToDate(strDate: message.sentAt))
                        .font(.caption)
                }
                .padding(.trailing, 3)
            }
            .frame(minWidth: 50, maxWidth: 250)
            .background((message.senderId == userId) ? Color.chatBubblesSent : Color.chatBubblesReceived)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.top, (message.senderId == previousMessage?.senderId) ? 0: 5)
            
        }
        .frame(width: 400, alignment: (message.senderId == userId) ? .trailing: .leading)
    }
}
