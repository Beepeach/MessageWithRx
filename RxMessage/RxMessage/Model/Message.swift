//
//  Message.swift
//  RxMessage
//
//  Created by JunHeeJo on 4/26/22.
//

import Foundation
import RealmSwift

class Message: Object {
    @Persisted var type: MessageType = .text
    @Persisted var who: String = ""
    @Persisted var body: String = ""
    @Persisted var date: Date = Date()
    
    enum MessageType:String, PersistableEnum {
        case text
        case image
    }
    
    convenience init(type: MessageType, who: String, body: String, date: Date) {
        self.init()
        self.type = type
        self.who = who
        self.body = body
        self.date = date
    }
}
