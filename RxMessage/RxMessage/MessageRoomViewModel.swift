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
    
    
    // MARK: Init
    init(viewController: UIViewController) {
        let initMessage = viewWillAppearSubject
            .flatMap { () -> BehaviorRelay<[Message]> in
                guard let messageVC = viewController as? MessageRoomViewController else {
                    return BehaviorRelay<[Message]>(value: [])
                }
                
                return messageVC.dummyData
            }
            .asDriver(onErrorJustReturn: [])
        

        messages = initMessage
    }
}
