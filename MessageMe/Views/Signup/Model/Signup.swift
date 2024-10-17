//
//  Signup.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import Foundation


struct Signup: Codable {
    var email: String = ""
    var password: String = ""
    var name: String = ""
}


struct SignupResponse: Codable {
    let msg: String
    let userId: String?
}
