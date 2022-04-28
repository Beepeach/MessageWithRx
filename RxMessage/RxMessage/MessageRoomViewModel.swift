//
//  MessageRoomViewModel.swift
//  RxMessage
//
//  Created by JunHeeJo on 4/27/22.
//

import UIKit
import RxSwift
import RxCocoa

final class MessageRoomViewModel {
    // MARK: Inputs
    let viewWillAppearSubject = PublishSubject<Void>()
    
    // MARK: Outputs
    var messages: Driver<[Message]>
    
    // MARK: Service
    private let messageService: MessageService
    
    // MARK: Init
    init(messageService: MessageService) {
        self.messageService = messageService
        
        let initMessage = viewWillAppearSubject
            .flatMap {
                messageService.sendMessage()
            }
            .asDriver(onErrorJustReturn: [])
        
        messages = initMessage
    }
}
