//
//  ProfileView.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 50) {
                
                if !(viewModel.profile?.profilePicUrl == "")  {
                    Image(viewModel.profile?.profilePicUrl ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height:  150)
                        .clipShape(Circle())
                        .onAppear{
                            print("SDfsdf")
                        }
                    
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundStyle(.gray)
                }
                
                VStack(alignment: .leading){
                    ProfileCardView(name: viewModel.profile?.profileName ?? "", iconName: "person", label: "Name")
                        .onTapGesture {
                            print("on tap")
                            if viewModel.profile?.profileName == "" {
                                viewModel.isShowNameField = true
                                return
                            }
                        }
                    ProfileCardView(name: viewModel.profile?.email ?? "", iconName: "envelope", label: "Email")
                }
                Spacer()
            }
            .onAppear {
                viewModel.fetchProfile(with: loginViewModel)
            }
            .sheet(isPresented: $viewModel.isShowNameField) {
                NameFieldView(viewModel: viewModel)
                .presentationDetents([.fraction(0.22)])
            }
            
        }
    
    }
}

#Preview {
    ProfileView()
        .environmentObject(LoginViewModel())
}

struct ProfileCardView: View {
    var name: String
    var iconName: String
    var label: String
    
    var body: some View {
        HStack(spacing: 30) {
            
            Image(systemName: iconName)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.gray)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text(label)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.gray)
                
                Text(name)
                    .foregroundStyle(.black)
            }
            
            Spacer()
            
            if name.isEmpty && (label == "Name") {
                Image(systemName: "pencil")
                    .resizable()
                    .scaledToFit()
                    .bold()
                    .frame(width: 30, height: 18)
                    .foregroundStyle(.accent)
            }
        }
        .padding()
    }
}



struct NameFieldView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var viewModel: ProfileViewModel
    var body: some View {

        VStack(alignment: .leading, spacing: 30){
            Text("Enter your name")
                .font(.system(size: 20, weight: .medium))
            
            TextField(viewModel.profile?.profileName ?? "", text: $viewModel.profileName)
                .textFieldStyle(.roundedBorder)
            
            HStack(spacing: 40){
                Spacer()
                Text("Cancel")
                    .font(.callout)
                    .onTapGesture {
                        viewModel.isShowNameField = false
                    }
                
                Text("Save")
                    .font(.callout)
                    .onTapGesture {
                        if viewModel.profile?.profileName == viewModel.profileName {
                            viewModel.isShowNameField = false
                        }
                        
                        viewModel.updateName(with: loginViewModel)
                    }
                    
            }
            .foregroundStyle(.accent)
            .fontWeight(.semibold)
            .padding(.horizontal, 5)
            
        }
        .padding()
    }
}
