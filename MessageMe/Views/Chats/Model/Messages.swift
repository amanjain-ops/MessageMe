//
//  Message.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import Foundation

struct Messages: Codable, Identifiable {
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


//{'id': '670ba017250e1ef37afb2488', 'chat_id': '670b7f43f8e2c3c770fd2383', 'sender_id': '670903f421efb36287072a9d', 'message': 'Now', 'sent_at': '2024-10-13 10:25:27.165000', 'msg': ''}

//[{'id': '670b9e278f99f70d4712179d', 'chat_id': '670b7f43f8e2c3c770fd2383', 'sender_id': '670903f421efb36287072a9d', 'message': 'Hi', 'sent_at': datetime.datetime(2024, 10, 13, 10, 17, 11, 695000), 'msg': ''},
// {'id': '670b9f82250e1ef37afb2487', 'chat_id': '670b7f43f8e2c3c770fd2383', 'sender_id': '670903f421efb36287072a9d', 'message': 'SDF', 'sent_at': datetime.datetime(2024, 10, 13, 10, 22, 58, 772000), 'msg': ''}, {'id': '670ba017250e1ef37afb2488', 'chat_id': '670b7f43f8e2c3c770fd2383', 'sender_id': '670903f421efb36287072a9d', 'message': 'Now', 'sent_at': datetime.datetime(2024, 10, 13, 10, 25, 27, 165000), 'msg': ''}]
