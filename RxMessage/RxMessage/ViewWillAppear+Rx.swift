//
//  ViewWillAppear+Rx.swift
//  RxMessage
//
//  Created by JunHeeJo on 4/26/22.
//

import Foundation
import RxSwift
import RxCocoa


extension Reactive where Base: UIViewController {
    public var viewWillAppear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewWillAppear)).map { _ in }
        
        return ControlEvent(events: source)
    }
}

