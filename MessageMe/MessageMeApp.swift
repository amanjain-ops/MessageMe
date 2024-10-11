//
//  MessageMeApp.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import SwiftUI

@main
struct MessageMeApp: App {
    
    @StateObject var loginUser = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            MessageMeTabView()
                .environmentObject(loginUser)
        }
    }
}
