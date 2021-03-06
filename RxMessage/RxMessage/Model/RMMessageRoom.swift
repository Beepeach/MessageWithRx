//
//  MessageRoom.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/23/22.
//

import Foundation
import RealmSwift

class RMMessageRoom: Object {
    // Int보다 ObjectID로 변경하는게 더 좋을듯
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var allMessages: List<RMMessage>
    
    convenience init(id: Int) {
        self.init()
        self.id = id
    }
}
