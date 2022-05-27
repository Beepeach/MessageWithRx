//
//  Message.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/27/22.
//

import Foundation

class Message {
    var type: MessageType
    var who: String
    var body: String
    var date: Date = Date()
    
    enum MessageType {
        case text
        case image
    }
    
    init(type: MessageType, who: String, body: String) {
        self.type = type
        self.who = who
        self.body = body
    }
}
