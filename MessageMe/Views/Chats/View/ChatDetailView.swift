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
    @State private var hasLoadMessage: Bool = false
    @Binding var path: NavigationPath
    
    var body: some View {
        ScrollView {
            
            if !webSocketManager.messages.isEmpty {
                
                ForEach(webSocketManager.messages) { message in
                    if message.chatId == chatId {
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
                            .background(Color.cyan)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .padding(.vertical, (message.senderId == loginViewModel.loginResponsee?.userId) ? 0: 5)
                            
                        }
                        .frame(width: 400, alignment: (message.senderId == loginViewModel.loginResponsee?.userId) ? .trailing: .leading)
                    } // if
                    
                    
                } //ForEach
                
            } // if
            else {
                VStack{
                    ProgressView()
                        .onAppear{
                            Task{
                                print("hasLoadMessage: \(hasLoadMessage)")
                                if !hasLoadMessage {
                                    
                                    viewModel.chatId.chatId = chatId
                                    
                                    viewModel.getMessages(with: loginViewModel)
                                    hasLoadMessage = true
                                    
                                    webSocketManager.joinChat(chatId: chatId)
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        webSocketManager.messages = viewModel.messages
                                    }
                                    
                                } // if
                                
                            } // task
                        } // onAppear
                    
                } // vstack
            } // else
            
        } // scrollview
        .onDisappear {
            hasLoadMessage = false
            webSocketManager.messages = []
        }
        .defaultScrollAnchor(.bottom)
        .frame(width: 400)
        .toolbar(.hidden, for: .tabBar)
        
        .safeAreaInset(edge: .bottom, alignment: .center) {
            
            HStack{
                TextEditor(text: $webSocketManager.newMessage)
                    .frame(height: 30)
                    .padding(.vertical, 7)
                    .padding(.leading, 20)
                    .padding(.bottom, 7)
                
                Button {
                    webSocketManager.sendMessage(chatId: chatId)
                    webSocketManager.newMessage = ""
                } label: {
                    Image(systemName: "triangle.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .rotationEffect(.degrees(90))
                }// label
            } // hstack
            .padding()
        } //safeAreaInset
    }
}

#Preview {
    ChatDetailView(chatId: "", path: .constant(NavigationPath()))
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
