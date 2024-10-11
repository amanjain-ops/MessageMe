//
//  Signup.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import Foundation


struct Signup: Codable {
    let email: String
    let password: String
}


struct SignupResponse: Codable {
    let msg: String
    let userID: String
}
