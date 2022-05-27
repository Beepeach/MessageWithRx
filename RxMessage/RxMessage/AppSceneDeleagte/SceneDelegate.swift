//
//  SceneDelegate.swift
//  RxMessage
//
//  Created by JunHeeJo on 4/26/22.
//

import UIKit
import RxRelay
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let messageService = EchoMessageService(webSocketManager: WebSocketManager())
        let realmService = RealmService()
        let sceneCoordinator = SceneCoordinator(window: window)
        let messageRoomViewModel = MessageRoomViewModel(messageService: messageService, realmService: realmService, sceneCoordinator: sceneCoordinator)
        
        let messageRoomScene = Scene.messageRoom(messageRoomViewModel)
        
        // TODO: messageRoom이 만들어지는 시점을 정해야한다. 화면 전환이전?
        // 현재는 key도 0으로 해놓자.
        realmService.getMessageRoom(key: 0)
        
        sceneCoordinator.transition(to: messageRoomScene, using: .root)
    }
}

