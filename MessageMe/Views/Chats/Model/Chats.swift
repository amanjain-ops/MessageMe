//
//  Chats.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import Foundation


struct Chats: Codable, Identifiable {
    let msg: String?
    let id: String
    let participants: [String]
    let createdAt: String?
    let lastMessage: LastMessage?
}

struct LastMessage: Codable {
    let message: String
    let senderId: String
    let sentAt: Date
}
