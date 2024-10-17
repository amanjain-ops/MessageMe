//
//  LoginView.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    @FocusState private var focusedTextField: FormTextField?
    enum FormTextField {
        case email, password
    }
    var body: some View {
        NavigationStack() {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.title)
                    .fontWeight(.semibold)
                
                
                VStack(alignment: .leading, spacing: 20){
                    TextField("Email", text: $viewModel.loginUser.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .frame(width: 350, height: 50)
                        .padding(.horizontal, 10)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .focused($focusedTextField, equals: .email)
                        .onSubmit { focusedTextField = .password }
                        .submitLabel(.next)
                    
                    SecureField("Password", text: $viewModel.loginUser.password)
                        .autocapitalization(.none)
                        .frame(width: 350, height: 50)
                        .padding(.horizontal, 10)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .focused($focusedTextField, equals: .password)
                        .onSubmit { focusedTextField = nil }
                        .submitLabel(.continue)
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundStyle(.red)
                            .font(.caption)
                    }
                }
                
                Button {
                    viewModel.login()
                } label: {
                    Text("Login")
                        .foregroundStyle(.white)
                        .frame(width: 350, height: 50)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                }
                
//                Text(viewModel.loginResponsee?.accessToken ?? "No response")
                HStack {
                    Text("Don't have an Account?")
                    NavigationLink("Sign Up", destination: SignupView())
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(LoginViewModel())
}
