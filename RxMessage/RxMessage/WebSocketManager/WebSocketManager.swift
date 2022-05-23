//
//  WebSocketManager.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/19/22.
//

import Foundation
import RxSwift
import RxCocoa
import Starscream

class WebSocketManager {
    var socket: WebSocket!
    
    init() {
        setupWebSocket()
    }
    
    private func setupWebSocket() {
        let url = URL(string: "wss://ws.postman-echo.com/raw")!
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        
        socket = WebSocket(request: request)
    }
    
    func connect() {
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    func write(_ text: String) {
        socket.write(string: text)
    }
//    
//    func receive() {
//        socket.rx.response.map { event -> String in
//            switch event {
//            case .text(let text):
//                return text
//            default:
//                return ""
//            }
//        }
//    }
}
