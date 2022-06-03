//
//  MessageRoom.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/27/22.
//

import Foundation

class MessageRoom {
    var id: Int
    var allMessages: [Message] = []
    
    init(id: Int) {
        self.id = id
    }
}
