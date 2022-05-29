//
//  MessageRoomViewModel.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/29/22.
//

import RxSwift
import RxCocoa


final class MessageRoomListViewModel: CommonViewModel {
    // Input
    let trigger: PublishSubject<Void>
    let createMessageRoomTrigger: PublishSubject<Void>
    
    // Output
    let messageRoomList: Driver<[RMMessageRoom]>
    
    // Service
    let realmService: LocalDBService
    
    // Init
    init(realmSerive: LocalDBService, sceneCoordinator: SceneCoordinatorType) {
        self.realmService = realmSerive
        self.trigger = PublishSubject<Void>()
        self.createMessageRoomTrigger = PublishSubject<Void>()
        
        messageRoomList = trigger
            .flatMap { realmSerive.queryAllMessageRoom() }
            .asDriver(onErrorJustReturn: [])
        
        super.init(sceneCoordinator: sceneCoordinator)
    }
}
