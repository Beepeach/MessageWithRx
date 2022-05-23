//
//  MessageService.swift
//  RxMessage
//
//  Created by JunHeeJo on 4/28/22.
//

import Foundation
import RxSwift
import RxCocoa
import Starscream

protocol MessageService {
    func sendMessage(with text: String) -> Observable<Void>
    func receiveMessage() -> Observable<Message>
}

class EchoMessageService: MessageService {
    let webSocketManager: WebSocketManager
    
    init(webSocketManager: WebSocketManager) {
        self.webSocketManager = webSocketManager
        self.webSocketManager.connect()
    }
    
    deinit {
        self.webSocketManager.disconnect()
    }
    
    func sendMessage(with text: String) -> Observable<Void> {
        webSocketManager.socket.rx.write(string: text)
    }
    
    func receiveMessage() -> Observable<Message> {
        return webSocketManager.socket.rx.response
            .map { (event: WebSocketEvent) -> String in
                switch event {
                case .text(let text):
                    return text
                case .connected(_):
                    print("Connected")
                    return ""
                case .disconnected(_, _):
                    print("Disconnected")
                    return ""
                case .cancelled:
                    print("Cancelled")
                    return ""
                case .reconnectSuggested(_):
                    print("ReconnectedSuggested")
                    return ""
                case .error(let error):
                    print("Error \(error as Any)")
                    return ""
                default:
                    return ""
                }
            }
            .filter { $0.count > 0 }
            .map { Message(type: .text, who: "you", body: $0) }
    }
}

/*
class DummyMessageSender: MessageService {
    let dummyData = BehaviorRelay<[Message]>(value: [
        Message(type: .text, who: "me", body: "Hello RxSwift!!"),
        Message(type: .image, who: "me", body: imageURL),
        Message(type: .text, who: "me", body: "Good\nGood\nGoodGoodGood"),
        Message(type: .text, who: "you", body: "Hello"),
        Message(type: .text, who: "me", body: "안녕하세요?\n반가워요 전혀 Rx적이지 않네요?"),
        Message(type: .text, who: "me", body: "Bad\nBad\nGoodGoodGood"),
        Message(type: .image, who: "you", body: anotherImageURL),
        Message(type: .text, who: "me", body: "HAHAHAH\nHUHUHUHUHU\nGoodGoodGood"),
        Message(type: .text, who: "you", body: "Good\nGood\nGoodGoodGood")
    ])
    
    func sendMessage() -> Observable<[Message]> {
        return dummyData.asObservable()
    }
}
*/
