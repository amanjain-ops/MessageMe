//
//  ChatNavigation.swift
//  MessageMe
//
//  Created by Aman Jain on 18/10/24.
//

import Foundation


enum ChatNavigation: Hashable {
    case newChat
    case chatDetail(chatId: String,  user: Profile)
}
