//
//  Chats.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import Foundation


struct Chats: Codable, Identifiable, Hashable {
    let msg: String?
    var id: String
    let participants: [String]
    let createdAt: String?
    var lastMessage: LastMessage?
    var otherParticipantName: Profile?
}

struct LastMessage: Codable, Hashable {
    let message: String
    let senderId: String
    let sentAt: String
}
