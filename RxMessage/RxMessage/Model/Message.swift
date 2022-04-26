//
//  Message.swift
//  RxMessage
//
//  Created by JunHeeJo on 4/26/22.
//

import Foundation

struct Message {
    let type: MessageType
    let who: String
    var body: String
    
    enum MessageType {
        case text
        case image
    }
}


