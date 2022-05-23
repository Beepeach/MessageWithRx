//
//  WebSocketDelegateProxy.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/19/22.
//

import Foundation
import RxSwift
import RxCocoa
import Starscream

public class RxWebSocketDelegateProxy: DelegateProxy<WebSocket, WebSocketDelegate>, DelegateProxyType, WebSocketDelegate {
    var subject = PublishSubject<WebSocketEvent>()
    
    public static func registerKnownImplementations() {
        self.register {
            RxWebSocketDelegateProxy(parentObject: $0, delegateProxy: RxWebSocketDelegateProxy.self)
        }
    }
    
    public static func currentDelegate(for object: WebSocket) -> WebSocketDelegate? {
        return object.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: WebSocketDelegate?, to object: WebSocket) {
        object.delegate = delegate
    }
    
    public func didReceive(event: WebSocketEvent, client: WebSocket) {
        subject.onNext(event)
    }
}


extension WebSocket: ReactiveCompatible { }
