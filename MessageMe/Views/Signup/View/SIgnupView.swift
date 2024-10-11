//
//  SIgnupView.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import SwiftUI

struct SIgnupView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up")
                .font(.title)
                .fontWeight(.semibold)
            
            
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .frame(width: 350, height: 50)
                .padding(.horizontal, 10)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            SecureField("Password", text: $password)
                .autocapitalization(.none)
                .frame(width: 350, height: 50)
                .padding(.horizontal, 10)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Button {
                
            } label: {
                Text("Register")
                    .foregroundStyle(.white)
                    .frame(width: 350, height: 50)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
            }
        }
    }
}

#Preview {
    SIgnupView()
}
