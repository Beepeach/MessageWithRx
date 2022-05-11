//
//  MessageRoomViewModel.swift
//  RxMessage
//
//  Created by JunHeeJo on 4/27/22.
//

import UIKit
import RxSwift
import RxCocoa

final class MessageRoomViewModel: CommonViewModel {
    // MARK: Inputs
    let viewWillAppearSubject = PublishSubject<Void>()
    
    // MARK: Outputs
    var messages: Driver<[Message]>
    
    // MARK: Service
    let messageService: MessageService
    
    // MARK: Init
    init(messageService: MessageService, sceneCoordinator: SceneCoordinatorType) {
        self.messageService = messageService
        
        let initMessage = viewWillAppearSubject
            .flatMap { messageService.sendMessage() }
            .asDriver(onErrorJustReturn: [])
        
        messages = initMessage
        
        super.init(sceneCoordinator: sceneCoordinator)
    }
}
