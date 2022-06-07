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
    case detailImage(DetailImageViewModel)
    
    var associatedViewModel: CommonViewModel {
        switch self {
        case .messageRoom(let messageRoomViewModel):
            return messageRoomViewModel
        case .detailImage(let detailImageViewModel):
            return detailImageViewModel
        }
    }
}


extension Scene {
    func instantiate() -> UIViewController {
        switch self {
        case .messageRoom(let messageRoomViewModel):
             var messageRoomVC = MessageRoomViewController()
             messageRoomVC.bind(viewModel: messageRoomViewModel)
            
            return messageRoomVC
            
        case .detailImage(let detailImageViewModel):
            var detailImageVC = DetailImageViewController()
            detailImageVC.bind(viewModel: detailImageViewModel)
            
            return detailImageVC
        }
    }
}
