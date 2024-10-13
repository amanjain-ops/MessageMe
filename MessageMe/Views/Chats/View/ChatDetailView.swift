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
    
    var body: some View {
        if loginViewModel.loginResponsee?.accessToken == nil{
            //        if ((loginViewModel.loginResponsee?.accessToken) != nil){
            LoginView()
        }
        else {
            ScrollView {
                if viewModel.isLoading{
                    VStack{
                        ProgressView()
                    }
                }
                else if !webSocketManager.messages.isEmpty {
                    
                    ForEach(webSocketManager.messages) { message in
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
                    }
                    
                }
                else {
                    VStack{}
                }
                
            }
            .border(.yellow)
            .defaultScrollAnchor(.bottom)
            .frame(width: 400)
            .task {
                
                viewModel.chatId.chatId = chatId
                print(viewModel.chatId.chatId)
                viewModel.getMessages(with: loginViewModel)
                //                webSocketManager.configure(with: loginViewModel)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    webSocketManager.messages = viewModel.messages
                }
                
                webSocketManager.joinChat()
                
            }
            .safeAreaInset(edge: .bottom, alignment: .center) {
                HStack{
                    TextEditor(text: $webSocketManager.newMessage)
                        .frame(height: 30)
                    //                        .border(.blue)
                    
                    //                        .frame(height: 30)
                        .padding(.vertical, 7)
                        .padding(.leading, 20)
                        .padding(.bottom, 7)
                    //                        .clipShape(Capsule())
                    //                        .overlay {
                    //                            Capsule()
                    //                                .stroke(lineWidth: 1)
                    //                        }
                    
                    Button {
                        webSocketManager.sendMessage()
                        webSocketManager.newMessage = ""
                    } label: {
                        //                        Text("Send")
                        //                            .frame(width: 50, height: 50)
                        //                            .foregroundStyle(.white)
                        //                            .background(.black)
                        Image(systemName: "triangle.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .rotationEffect(.degrees(90))
                    }
                    
                }
                .padding()
            }
            
        }
        
        
        
    }
    func StringToDate(strDate: String) -> String {
        print(strDate)
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS" // Format of your input string
        
        // Step 2: Convert the string to a Date object
        if let date = inputDateFormatter.date(from: strDate) {
            
            // Step 3: Create a DateFormatter to format the Date to "hh:mm"
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "HH:mm" // For 24-hour format, or use "hh:mm a" for 12-hour with AM/PM
            
            // Step 4: Convert the Date to the desired string format
            let formattedTime = outputDateFormatter.string(from: date)
            print("Formatted Time: \(formattedTime)") // Output: "14:45"
            
            return formattedTime
            
        } else {
            print("Invalid date string")
            return ""
        }
    }
}

#Preview {
    ChatDetailView(chatId: "")
        .environmentObject(LoginViewModel())
        .environmentObject(WebSocketManager())
}


