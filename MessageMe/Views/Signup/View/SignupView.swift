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
        ZStack {
//            LinearGradient(colors: [Color.primaryColor, Color.secondaryColor], startPoint: .topLeading, endPoint: .bottomTrailing)
            Color.secondaryColor
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                Text("Sign Up")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.primaryColor)
                
                VStack(alignment: .leading, spacing: 20){
                    TextField("Name", text: $viewModel.user.name)
                        .foregroundStyle(Color("TFText"))
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .focused($focusedTextField, equals: .name)
                        .onSubmit { focusedTextField = .email }
                        .submitLabel(.next)
                        .frame(width: 350, height: 50)
                        .padding(.horizontal, 10)
                        .background(Color("TFBackground"))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke((focusedTextField == .name) ? Color("TFOnFBorder") : Color("TFOFBorder"), lineWidth: 0.6)
                        }
                    
                    
                    TextField("Email", text: $viewModel.user.email)
                        .foregroundStyle(Color("TFText"))
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .focused($focusedTextField, equals: .email)
                        .onSubmit { focusedTextField = .password }
                        .submitLabel(.next)
                        .frame(width: 350, height: 50)
                        .padding(.horizontal, 10)
                        .background(Color("TFBackground"))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke((focusedTextField == .email) ? Color("TFOnFBorder") : Color("TFOFBorder"), lineWidth: 0.6)
                        }
                    
                    SecureField("Password", text: $viewModel.user.password)
                        .foregroundStyle(Color("TFText"))
                        .autocapitalization(.none)
                        .focused($focusedTextField, equals: .password)
                        .onSubmit { focusedTextField = nil }
                        .submitLabel(.continue)
                        .frame(width: 350, height: 50)
                        .padding(.horizontal, 10)
                        .background(Color("TFBackground"))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
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
                    viewModel.signup()
                } label: {
                    Text("Register")
                        .foregroundStyle(.white)
                        .frame(width: 350, height: 50)
                        .background(Color.primaryColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                }
                
                //            Text(viewModel.response?.msg ?? "No response")
                Spacer()
            }
            .padding()
            .onChange(of: viewModel.isSignupSuccessful) { old, newValue in
                print(old)
                if newValue {
                    dismiss()
                }
            }
        }
        
    }
}

#Preview {
    SignupView()
}
