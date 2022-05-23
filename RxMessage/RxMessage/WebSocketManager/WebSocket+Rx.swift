//
//  WebSocket+Rx.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/19/22.
//

import Foundation
import RxSwift
import RxCocoa
import Starscream


extension Reactive where Base: WebSocket {

    public var response: Observable<WebSocketEvent> {
        return RxWebSocketDelegateProxy.proxy(for: base).subject
    }

    public var text: Observable<String> {
        return self.response
            .filter {
                switch $0 {
                case .text:
                    return true
                default:
                    return false
                }
            }
            .map {
                switch $0 {
                case .text(let message):
                    return message
                default:
                    return String()
                }
        }
    }

    public var connected: Observable<Bool> {
        return response
            .filter {
                switch $0 {
                case .connected, .disconnected:
                    return true
                default:
                    return false
                }
            }
            .map {
                switch $0 {
                case .connected:
                    return true
                default:
                    return false
                }
        }
    }

    public func write(string: String) -> Observable<Void> {
        return Observable.create { observer in
            self.base.write(string: string) {
                observer.onNext(())
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }
}
