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
    func sendMessage() -> Observable<[Message]>
}

class DummyMessageSender: MessageService {
    let dummyData = BehaviorRelay<[Message]>(value: [
        Message(type: .text, who: "me", body: "Hello RxSwift!!"),
        Message(type: .image, who: "you", body: imageURL),
        Message(type: .text, who: "me", body: "Good\nGood\nGoodGoodGood"),
        Message(type: .text, who: "me", body: "Hello"),
        Message(type: .text, who: "me", body: "안녕하세요?\n반가워요 전혀 Rx적이지 않네요?"),
        Message(type: .text, who: "me", body: "Bad\nBad\nGoodGoodGood"),
        Message(type: .image, who: "you", body: anotherImageURL),
        Message(type: .text, who: "me", body: "HAHAHAH\nHUHUHUHUHU\nGoodGoodGood"),
        Message(type: .text, who: "me", body: "Good\nGood\nGoodGoodGood")
    ])
    
    func sendMessage() -> Observable<[Message]> {
        return dummyData.asObservable()
    }
}
