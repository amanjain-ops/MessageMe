//
//  SIgnupView.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import SwiftUI

struct SIgnupView: View {
    @StateObject var viewModel = SignupViewModel()
    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up")
                .font(.title)
                .fontWeight(.semibold)
            
            
            TextField("Email", text: $viewModel.user.email)
                .autocapitalization(.none)
                .frame(width: 350, height: 50)
                .padding(.horizontal, 10)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            SecureField("Password", text: $viewModel.user.password)
                .autocapitalization(.none)
                .frame(width: 350, height: 50)
                .padding(.horizontal, 10)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            
            Button {
                viewModel.signup()
            } label: {
                Text("Register")
                    .foregroundStyle(.white)
                    .frame(width: 350, height: 50)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
            }
            
            Text(viewModel.response?.msg ?? "No response")
        }
    }
}

#Preview {
    SIgnupView()
}
