//
//  Profile.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import Foundation


struct Profile: Codable, Identifiable, Hashable {
    let id: String
    let email: String
    let profileName: String?
    let profilePicUrl: String?
}
