//
//  MessageRoom.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/27/22.
//

import Foundation

class MessageRoom {
    // Int보다 ObjectID로 변경하는게 더 좋을듯
    var id: Int
    var allMessages: [Message] = []
    
    init(id: Int) {
        self.id = id
    }
}
