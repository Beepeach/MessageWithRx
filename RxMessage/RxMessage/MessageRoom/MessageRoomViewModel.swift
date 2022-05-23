//
//  MessageRoomViewModel.swift
//  RxMessage
//
//  Created by JunHeeJo on 4/27/22.
//

import UIKit.UIImage
import RxSwift
import RxCocoa
import Action
import Network

final class MessageRoomViewModel: CommonViewModel {
    // MARK: Variable
    let previousMessages: BehaviorRelay<[Message]>
    
    // MARK: Inputs
    let viewWillAppearSubject: PublishSubject<Void>
    let sendMessageSubject: PublishSubject<String>
    
    // MARK: Outputs
    var messages: Driver<[Message]>
    
    // MARK: Service
    let messageService: MessageService

    // MARK: Init
    init(messageService: MessageService, sceneCoordinator: SceneCoordinatorType, previousMessages: BehaviorRelay<[Message]>) {
        self.messageService = messageService
        self.viewWillAppearSubject = PublishSubject<Void>()
        self.sendMessageSubject = PublishSubject<String>()
        self.previousMessages = previousMessages
        
        let initMessage = viewWillAppearSubject
            .flatMap { previousMessages }
        
        let sendMessage = sendMessageSubject.map {
            Message(type: .text, who: "me", body: $0)
        }
        
        // TODO: 이름 바꾸기
        let receiveMessage = Observable.merge(messageService.receiveMessage(), sendMessage)
            .scan(into: previousMessages.value) { previous, message in
                previous.append(message)
        }
        
        
        let messages = Observable.merge(initMessage, receiveMessage)
        
        self.messages = messages.asDriver(onErrorJustReturn: [])
        

        super.init(sceneCoordinator: sceneCoordinator)
    }
    
    
    // MARK: Action
    lazy var detailImageAction: Action<UIImage, Void> = {
        Action { image in
            let detailImageViewModel = DetailImageViewModel(image: image, sceneCoordinator: self.sceneCoordinator)
            
            let detailImageScene = Scene.detailImage(detailImageViewModel)
            
            return self.sceneCoordinator.transition(
                to: detailImageScene,
                using: .modal(animated: true)
            )
            .asObservable()
            .map { _ in }
        }
    }()
    
    lazy var sendTextAction: Action<String, Void> = {
        Action { text in
            let sendMessage = self.messageService.sendMessage(with: text)
            
            return sendMessage
        }
    }()
}
