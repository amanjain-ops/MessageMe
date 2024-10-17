//
//  SIgnupView.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import SwiftUI

struct SignupView: View {
    @StateObject var viewModel = SignupViewModel()
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedTextField: FormTextField?
    enum FormTextField {
        case name, email, password
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up")
                .font(.title)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading, spacing: 20){
                TextField("Name", text: $viewModel.user.name)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .focused($focusedTextField, equals: .name)
                    .onSubmit { focusedTextField = .email }
                    .submitLabel(.next)
                    .frame(width: 350, height: 50)
                    .padding(.horizontal, 10)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                TextField("Email", text: $viewModel.user.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .focused($focusedTextField, equals: .email)
                    .onSubmit { focusedTextField = .password }
                    .submitLabel(.next)
                    .frame(width: 350, height: 50)
                    .padding(.horizontal, 10)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                SecureField("Password", text: $viewModel.user.password)
                    .autocapitalization(.none)
                    .focused($focusedTextField, equals: .password)
                    .onSubmit { focusedTextField = nil }
                    .submitLabel(.continue)
                    .frame(width: 350, height: 50)
                    .padding(.horizontal, 10)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundStyle(.red)
                        .font(.caption)
                }
            }
            
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
        .onChange(of: viewModel.isSignupSuccessful) { old, newValue in
            print(old)
            if newValue {
                dismiss()
            }
        }
        
    }
}

#Preview {
    SignupView()
}
