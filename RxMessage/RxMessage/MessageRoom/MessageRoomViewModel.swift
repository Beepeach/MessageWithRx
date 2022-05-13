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

final class MessageRoomViewModel: CommonViewModel {
    // MARK: Inputs
    let viewWillAppearSubject: PublishSubject<Void>
    
    // MARK: Outputs
    var messages: Driver<[Message]>
    
    // MARK: Service
    let messageService: MessageService

    // MARK: Init
    init(messageService: MessageService, sceneCoordinator: SceneCoordinatorType) {
        self.viewWillAppearSubject = PublishSubject<Void>() 
        self.messageService = messageService
        
        let initMessage = viewWillAppearSubject
            .flatMap { messageService.sendMessage() }
            .asDriver(onErrorJustReturn: [])
        
        messages = initMessage
        
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
}
