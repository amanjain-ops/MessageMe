//
//  Message.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import Foundation

struct Messages: Codable, Identifiable, Hashable {
    let id: String
    let chatId: String
    let senderId: String
    let message: String
    let sentAt: String
    let msg: String?
}


struct ChatId: Codable{
    var chatId: String = ""
}
