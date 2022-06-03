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
import RealmSwift

final class MessageRoomViewModel: CommonViewModel {
    // MARK: Inputs
    let viewWillAppearSubject: PublishSubject<Void>
    let sendMessageSubject: PublishSubject<String>
    
    // MARK: Outputs
    var messages: Driver<[RMMessage]>
    
    // MARK: Service
    let messageService: MessageService
    let realmService: LocalDBService

    // MARK: Init
    init(messageService: MessageService, realmService: LocalDBService, sceneCoordinator: SceneCoordinatorType) {
        self.messageService = messageService
        self.realmService = realmService
        self.viewWillAppearSubject = PublishSubject<Void>()
        self.sendMessageSubject = PublishSubject<String>()
        
        // TODO: 현재 너무 realm에 live object 기능에 의존한 코드이다.
        // key도 메세지룸 별로 나눠야한다. 일단 0으로 통일
        let initMessage = viewWillAppearSubject
            .flatMap { _ in realmService.queryAllMessages(from: 0) }
        
        
        // TODO: 서버에 전달이 완료되면!! 해야하는데 아직 못함
        // MessageRoom에 대한 정보는 어디서 가져올까?? 일단 여기서는 0로 찾게 만들고 이후에 생각해보자.
        let sendMessage = sendMessageSubject
            .map { RMMessage(type: .text, who: "me", body: $0, date: Date()) }
            .withLatestFrom(realmService.getMessageRoom(key: 0)) { (message: $0, messageRoom: $1) }
            .flatMap { realmService.save(message: $0.message, to: $0.messageRoom) }
            .flatMap { _ in realmService.queryAllMessages(from: 0) }
            
        
        let receiveMessage = messageService.receiveMessage()
            .withLatestFrom(realmService.getMessageRoom(key: 0)) { (message: $0, messageRoom: $1) }
            .flatMap { realmService.save(message: $0.message, to: $0.messageRoom) }
            .flatMap { _ in realmService.queryAllMessages(from: 0) }
            
        
        let messages = Observable.merge(initMessage, sendMessage, receiveMessage)
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
