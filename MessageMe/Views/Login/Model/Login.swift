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

struct LoginResponseq: Codable {
    var accessToken: String?
    var msg: String?
    var user_id: String?
    var error: String?
}
