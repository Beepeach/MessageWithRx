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
            .map { Message(type: .text, who: "you", body: $0, date: Date()) }
    }
}
