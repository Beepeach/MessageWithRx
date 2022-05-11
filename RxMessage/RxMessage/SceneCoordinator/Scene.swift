//
//  Scene.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/11/22.
//

import Foundation
import UIKit

enum Scene {
    case messageRoom(MessageRoomViewModel)
}


extension Scene {
    func instantiate() -> UIViewController {
        switch self {
        case .messageRoom(let messageRoomViewModel):
             var messageRoomVC = MessageRoomViewController()
             messageRoomVC.bind(viewModel: messageRoomViewModel)
            
            return UIViewController()
        }
    }
}
