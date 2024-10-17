//
//  Login.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import Foundation

struct Login: Codable {
    
    var email: String = ""
    var password: String = ""
    
}

struct LoginResponse: Codable {
    var accessToken: String?
    let msg: String?
    let userId: String?
    let error: String?
}
