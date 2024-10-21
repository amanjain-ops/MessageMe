//
//  WebSocketManager.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import Foundation
import SwiftUI
import SocketIO

class WebSocketManager: ObservableObject {
    
    private var manager: SocketManager!
    private var socket: SocketIOClient!
    @Published var messages: [Messages] = []
    @Published var newMessage: String = ""
    private var loginViewModel: LoginViewModel?
    @Published var chatCreatedResponse: Chats?
    @Published var chatss: [Chats] = []
    
    // Initialize without any parameters
    init() {
    }
    
    // Method to set the LoginViewModel and configure the socket
    func configure(with viewModel: LoginViewModel) {
        self.loginViewModel = viewModel
        
        // Ensure the access token is available
        guard let accessToken = viewModel.loginResponsee?.accessToken else {
            print("Access token is not available")
            return
        }
        
        // Create the socket URL
        guard let url = URL(string: "ws://127.0.0.1:5000/socket.io/?EIO=3&transport=websocket") else {
            print("Invalid URL")
            return
        }
        
        // Initialize the manager and socket
        let config: SocketIOClientConfiguration = [.log(true), .forcePolling(true),
                                                   .extraHeaders(["Authorization": "Bearer \(accessToken)"])]
        self.manager = SocketManager(socketURL: url, config: config)
        self.socket = manager.defaultSocket
        
        // Set up the event handlers
        setupSocketHandlers()
        
        // Connect to the socket
        socket.connect()
    }
    
    func setupSocketHandlers() {
        
        socket.on(clientEvent: .connect) { _, _ in
            print("Socket connected")
        }
        
        socket.on("new_message") { data, _ in
            print("Data received and proceeding with parsing")
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []) {
                //                print("Raw data: \(data)")
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                
                
                do {
                    let response = try decoder.decode([Messages].self, from: jsonData)
                    
                    //                    print(response)
                    DispatchQueue.main.async {
                        //                        print(self.messages)
                        
                        self.messages.append(contentsOf: response)
                    }
                } catch {
                    print("Error decoding message: \(error.localizedDescription)")
                }
            } else {
                print("Error converting data to JSON")
            }
        }
        
        // chats updation
        socket.on("last_message") { data, _ in
            if let firstElement = data.first as? [String: Any] {
                do {
                    // Convert the first element into JSON data
                    let jsonData = try JSONSerialization.data(withJSONObject: firstElement, options: [])
                    
                    // Decode the JSON data
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let response = try decoder.decode(Chats.self, from: jsonData)
                    
                    print("Response:", response)
                    self.chatss = []
                    DispatchQueue.main.async {
//                        self.updateChatMessages(response: response)
                        self.chatss.append(response)
//                        print("fter chat append: ", self.chatss)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("Invalid data format")
            }
        }
        
        
        socket.on("chat_created") { data, _  in
            //            print(data)
            //            print(data.first ?? "")
            if let firstElement = data.first as? [String: Any] {
                do {
                    // Convert the first element into JSON data
                    let jsonData = try JSONSerialization.data(withJSONObject: firstElement, options: [])
                    
                    // Decode the JSON data
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let response = try decoder.decode(Chats.self, from: jsonData)
                    
                    print("Response:", response)
                    
                    DispatchQueue.main.async {
                        self.chatCreatedResponse = response
                        
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("Invalid data format")
            }
        }
        
        
        
        socket.on(clientEvent: .disconnect) { _, _ in
            print("Socket disconnected")
        }
    }
    
    func disconnect(){
        socket.on(clientEvent: .disconnect) { _, _ in
            print("Socket disconnected")
        }
    }
    
    func joinChat(chatId: String) {
        
        socket.emit("join_chat", ["chat_id": chatId])
    }
    
    // Call this function for each chat the user is in
    func joinAllChats(chatIds: [Chats]) {
        for chat in chatIds {
            joinChat(chatId: chat.id)
        }
    }
    func sendMessage(chatId: String) {
        socket.emit("sendMessage", [
            "chat_id": chatId,
            "message": self.newMessage
        ])
    }
    
    
//    func updateChatMessages(response: Chats) {
//        // Find the chat by chatId and append the message to the correct chat
//        
//        print("existing value in chats: ", self.chatss)
//        print("updating msgs")
//        
//        if let index = self.chatss.firstIndex(where: { $0.id == response.id }) {
////            print("response id: \(response.id), chat id: \(self.chatss[index].id)")
////            DispatchQueue.main.async {
//                self.chatss[index].lastMessage = response.lastMessage
////            }
//            
//        }
//        else {
//            print("else matters")
////            DispatchQueue.main.async {
//                self.chatss.append(response)
////                print("cjjj: ", self.chatss)
////            }
//        }
//    }
    
    
    func chatCreate(recipentId: String) {
        socket.emit("chatCreate", [
            "recipient_id": recipentId
        ])
    }
    
    
    
    
    
   
}
