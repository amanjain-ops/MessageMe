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
            ZStack {
                Color.secondaryColor
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    Text("Login")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.primaryColor)
                    
                    
                    VStack(alignment: .leading, spacing: 20){
                        TextField("Email", text: $viewModel.loginUser.email)
                            .foregroundStyle(Color("TFText"))
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .frame(width: 350, height: 50)
                            .padding(.horizontal, 10)
                            .background(Color("TFBackground"))
                            .focused($focusedTextField, equals: .email)
                            .onSubmit { focusedTextField = .password }
                            .submitLabel(.next)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke((focusedTextField == .email) ? Color("TFOnFBorder") : Color("TFOFBorder"), lineWidth: 0.6)
                            }
                        
                        SecureField("Password", text: $viewModel.loginUser.password)
                            .foregroundStyle(Color("TFText"))
                            .autocapitalization(.none)
                            .frame(width: 350, height: 50)
                            .padding(.horizontal, 10)
                            .background(Color("TFBackground"))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .focused($focusedTextField, equals: .password)
                            .onSubmit { focusedTextField = nil }
                            .submitLabel(.continue)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke((focusedTextField == .password) ? Color("TFOnFBorder") : Color("TFOFBorder"), lineWidth: 0.6)
                            }
                        
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
                            .background(Color.primaryColor)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                    }
                    
                    //                Text(viewModel.loginResponsee?.accessToken ?? "No response")
                    HStack {
                        Text("Don't have an Account?")
                        NavigationLink("Sign Up", destination: SignupView())
                            .foregroundStyle(Color.primaryColor)
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(LoginViewModel())
}
