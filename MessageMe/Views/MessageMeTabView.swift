//
//  ContentView.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import SwiftUI

struct MessageMeTabView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        if loginViewModel.loginResponsee?.accessToken == nil {
            LoginView()
        }
        else {
            TabView{
                ChatsView()
                    .tabItem{Label("Chats", systemImage: "bolt.horizontal")}
                    .onAppear {
                        print(loginViewModel.loginResponsee?.accessToken ?? "no token")
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
        }
        
    }
}

#Preview {
    MessageMeTabView()
        .environmentObject(LoginViewModel())
}
