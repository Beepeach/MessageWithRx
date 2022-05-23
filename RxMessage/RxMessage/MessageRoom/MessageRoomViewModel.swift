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
    var messages: Driver<[Message]>
    
    // MARK: Service
    let messageService: MessageService
    let realm: Realm

    // MARK: Init
    init(messageService: MessageService, sceneCoordinator: SceneCoordinatorType, realm: Realm) {
        self.realm = realm
        self.messageService = messageService
        self.viewWillAppearSubject = PublishSubject<Void>()
        self.sendMessageSubject = PublishSubject<String>()
        
        // Room을 생성해야하는데 어디서 만드는게 좋을까?
        // 여기서 만드는건 좋은게 아닌듯
        // 한번만 만들어야한다. 여러번 만들면 안된다.
        if realm.object(ofType: MessageRoom.self, forPrimaryKey: 0) == nil {
            try! realm.write {
                realm.add(MessageRoom())
            }
        }
        
        let previousMessages = realm.object(ofType: MessageRoom.self, forPrimaryKey: 0)?.allMessages
        
        let initMessage = viewWillAppearSubject
            .map { _ in previousMessages?.sorted(by: { $0.date < $1.date}) ?? [] }
        
        let sendMessage = sendMessageSubject
            .map { text -> [Message] in
                // 서버에 전달이 완료되면!! 해야하는데 아직 못함
                // 로컬에 저장 다른 객체에서 하도록 하자
                let message = Message(type: .text, who: "me", body: text, date: Date())
          
                try! realm.write {
                    previousMessages?.append(message)
                }

                return previousMessages?.sorted(by: { $0.date < $1.date}) ?? []
            }
        
        let receiveMessage = messageService.receiveMessage().do(onNext: { message in
            try! realm.write {
                previousMessages?.append(message)
            }
        }).map { _ in previousMessages?.sorted(by: { $0.date < $1.date}) ?? [] }
        
        
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
