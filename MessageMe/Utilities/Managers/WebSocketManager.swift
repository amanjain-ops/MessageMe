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
    
    @EnvironmentObject var loginViewModel: LoginViewModel
//    private var manager: SocketManager
    private var socket: SocketIOClient
    
    
    init(){
        let config: SocketIOClientConfiguration = [.log(true), .forcePolling(true), .extraHeaders(["Authorization": "Bearer \(String(describing: loginViewModel.loginResponsee?.accessToken))"])]
        guard let url = URL(string: "ws://127.0.0.1:5000/socket.io/?EIO=3&transport=websocket") else { return }
        let manager = WebSocketManager(socketURL: url, config: config)
    }
    
    func connect() {
        guard let url = URL(string: "ws://127.0.0.1:5000/socket.io/?EIO=3&transport=websocket") else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(String(describing: loginViewModel.loginResponsee?.accessToken))",
                         forHTTPHeaderField: "Authorization")
        
        webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask?.resume()
        
        receiveMessages()
    }
    
    func receiveMessages() {
        webSocketTask?.receive() { result in
            switch result {
                case .success(let message):
                print(message)
            case .failure(let error):
                print(error)
            }
        }
    }
}
