//
//  ProfileViewModel.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import Foundation


class ProfileViewModel: ObservableObject {
    @Published var profile: Profile?
    @Published var profileName = ""
    @Published var isShowNameField = false
    
    func fetchProfile(with viewLogin: LoginViewModel) {
        Task { @MainActor in
            do {
                profile = try await NetworkManger.shared.getUserInfo(with: viewLogin)
            }
            
        }
    }
    
    func updateName(with viewLogin: LoginViewModel){
        Task { @MainActor in
            do {
                profile = try await NetworkManger.shared.updateName(with: viewLogin, name: profileName)
                isShowNameField = false
            }
            
        }
    }
}
