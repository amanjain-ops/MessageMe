//
//  LoginView.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.title)
                .fontWeight(.semibold)
            
            
            TextField("Email", text: $viewModel.loginUser.email)
                .autocapitalization(.none)
                .frame(width: 350, height: 50)
                .padding(.horizontal, 10)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            SecureField("Password", text: $viewModel.loginUser.password)
                .autocapitalization(.none)
                .frame(width: 350, height: 50)
                .padding(.horizontal, 10)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            
            Button {
                viewModel.login()
            } label: {
                Text("Login")
                    .foregroundStyle(.white)
                    .frame(width: 350, height: 50)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
            }
            
            Text(viewModel.loginResponsee?.accessToken ?? "No response")
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(LoginViewModel())
}
