//
//  MessageService.swift
//  RxMessage
//
//  Created by JunHeeJo on 4/28/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol MessageService {
    
}

class MessageSender: MessageService {
    func sendDummyMessage() -> Observable<[Message]> {
        return Observable.create { observer in
            observer.onNext([Message(type: .text, who: "", body: "")])
            
            return Disposables.create()
        }
    }
}
