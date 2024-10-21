//
//  ContentView.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import SwiftUI

struct MessageMeTabView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var path = NavigationPath()
    var body: some View {
        
        NavigationStack {
            Group{
                if loginViewModel.loginResponsee?.accessToken == nil {
                    LoginView()
                }
                else {
                    TabView{
                        
                        ChatsView(path: $path)
                            .tabItem{Label("Chats", systemImage: "bolt.horizontal")}
                        
                        ProfileView()
                            .tabItem {
                                Label("Profile", systemImage: "person")
                            }
                    }
                    .accentColor(Color.primaryColor)
                    .background(Color.secondaryColor)
                }
            }
        }
    }
}

#Preview {
    MessageMeTabView()
        .environmentObject(LoginViewModel())
        .environmentObject(WebSocketManager())
}
